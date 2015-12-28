/*
Flash ActionScript 3.0 API for Facebook Graph



Copyright (C) 2011  Diederik Van Remoortere

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/
package com.verso_eu.facebook.graph
{

	import com.agency.brussels.net.json.IJSON;
	import com.verso_eu.facebook.graph.data.connect.ConnectMethod;
	import com.verso_eu.facebook.graph.data.users.FacebookUser;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.system.Security;

	public class FacebookGraph extends EventDispatcher
	{
		private var _appid:String;
		private var _redirectURI:String;
		private var _scope:Vector.<String> = new Vector.<String>();

		private var _debug:Boolean

		protected var jsConfirm:String = "confirmFacebookConnection";
		protected var jsWindowName:String = "facebookConnector";

		public const apiSecuredPath:String = "https://graph.facebook.com";
		public const apiUnsecuredPath:String = "http://graph.facebook.com";
		public var useSecuredPath:Boolean = true;

		protected var tokenCallbackDefined:Boolean;
		protected var _authorized:Boolean;
		protected var _token:String;
		protected var _savedSession:SharedObject;
		protected var _me:FacebookUser;
		protected var _storeSession:Boolean;

		protected static var INSTANCE:FacebookGraph;

		private var _connect_method:String = ConnectMethod.DISPLAY_POPUP;

		private var _JSONHelper:IJSON;

		use namespace graph_internal;

		public function FacebookGraph(enforcer:FBGraphEnforcer)
		{
			super();

			Security.loadPolicyFile(apiSecuredPath + "/crossdomain.xml");
			Security.loadPolicyFile(apiUnsecuredPath + "/crossdomain.xml");
		}

		public static function getInstance():FacebookGraph
		{
			if (INSTANCE == null) {
				INSTANCE = new FacebookGraph(new FBGraphEnforcer());
			}
			return INSTANCE;
		}

		/**
		 * ==== PUBLIC METHODS ====
		 */

		public function init(appId:String, token:String = ''):void
		{
			if(!_JSONHelper){
				throw new Error("Please set the desired JSONHelper (fp10 or fp11) class before calling init()");
			}
			_appid = appId;
			autoConnect(token);
		}

		public function autoConnect(_token:String = ''):URLLoader
		{
			var session:Object;
			if(_token != '')
				return verifyToken(_token);

			return verifySavedToken();
		}

		public function verifySavedToken():URLLoader
		{
			return savedSession.data.token && _storeSession
				? verifyToken(savedSession.data.token)
				: null;
		}

		public function verifyToken(token:String):URLLoader
		{
			var loader:URLLoader = graph_internal::call("me", null, "", token);
			loader.addEventListener(FacebookGraphEvent.DATA,
				function(event:FacebookGraphEvent):void
				{
					EventDispatcher(event.currentTarget).removeEventListener(event.type, arguments.callee);
					verifyTokenSuccess(event, token);
				});
			return loader;
		}

		protected function verifyTokenSuccess(event:FacebookGraphEvent, token:String):void
		{
			_me = new FacebookUser(_JSONHelper.parse(event.data.toString()));
			_token = token;
			_authorized = true;

			if(_storeSession){
				savedSession.data.token = token;
				savedSession.flush();
			}

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CONNECTED, {me:_me}));
		}

		graph_internal function call(path:String, data:URLVariables=null, method:String="", token:String=null, apiPath:String=null):URLLoader
		{
			if(!data)
				data = new URLVariables();
			data.access_token = token || this.token;

			var url:String = (apiPath || this.apiPath) + '/' + path;
			var request:URLRequest = new URLRequest(url);
			request.data = data;
			request.method = method || URLRequestMethod.GET;

			var loader:URLLoader = new URLLoader();
			loaderAddListeners(loader);
			loader.load(request);
			return loader;
		}

		protected function loaderComplete(event:Event):void
		{
			var loader:URLLoader = URLLoader(event.currentTarget);
			loaderRemoveListeners(loader);

			loader.dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.DATA, loader.data, false, false));
		}

		protected function loaderError(event:IOErrorEvent):void
		{
			var loader:URLLoader = URLLoader(event.currentTarget);
			loaderRemoveListeners(loader);

			loader.dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.ERROR, event.text, false, false));
		}

		protected function loaderSecurityError(event:SecurityErrorEvent):void
		{
			var loader:URLLoader = URLLoader(event.currentTarget);
			loaderRemoveListeners(loader);

			loader.dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.ERROR, event.text, false, false));
		}

		protected function loaderAddListeners(loader:URLLoader):void
		{
			loader.addEventListener(Event.COMPLETE, loaderComplete, false, int.MAX_VALUE);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderError, false, int.MAX_VALUE);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityError, false, int.MAX_VALUE);
		}

		protected function loaderRemoveListeners(loader:URLLoader):void
		{
			loader.removeEventListener(Event.COMPLETE, loaderComplete, false);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loaderError, false);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityError, false);
		}


		public function connect(redirectURI:String, scope:Vector.<String> = null):void
		{
			_scope = scope;
			_redirectURI = redirectURI;

			if(!_appid)
				return;

			if(_connect_method == ConnectMethod.DISPLAY_PAGE)
			{
				navigateToURL(new URLRequest(authorizationURL), "_self");
			}
			else if(_connect_method == ConnectMethod.DISPLAY_POPUP)
			{
				if(!tokenCallbackDefined)
				{
					tokenCallbackDefined = true;
					ExternalInterface.addCallback(jsConfirm, confirmConnection);
				}

				var id:String = ExternalInterface.objectID;
				var url:String = authorizationURL;
				var name:String = jsWindowName;
				var props:String = "width=670,height=370,status=1,location=yes,menubar=yes'";
				var js:String = ''
					+ 'if(!window.' + jsConfirm + '){'
					+ '    window.' + jsConfirm + ' = function(hash){'
					+ '        var flash = document.getElementById("' + id + '");'
					+ '        flash.' + jsConfirm + '(hash);'
					+ '    }'
					+ '};'
					+ 'window.open("' + url + '", "' + name + '", "' + props + '");'

				ExternalInterface.call("function(){" + js + "}");
			}

		}

		public function confirmConnection(hash:String):void
		{
			if(hash)
				verifyToken(hashToToken(hash));
		}

		public function call(call:GraphCall):GraphCall
		{
			call.initialize();
			return call;
		}

		protected function hashToToken(hash:String):String
		{
			hash = hash.substr(0, 1) == "#" ? hash.substr(1) : hash;
			var data:URLVariables = new URLVariables(hash);
			return data.access_token;
		}

		protected function tokenToExpiration(token:String):Date
		{
			var parts:Array = token.split(".");
			var matches:Array = String(parts[3]).match(/^([0-9]+)\-[0-9]/);
			return new Date(Number(String(matches[1])) * 1000);
		}

		/**
		 * ==== GETTERS SETTERS ====
		 */

		public function get debug():Boolean
		{
			return _debug;
		}

		public function set debug(value:Boolean):void
		{
			_debug = value;
		}

		public function get appid():String
		{
			return _appid;
		}

		public function get redirectURI():String
		{
			return _redirectURI;
		}

		public function set redirectURI(value:String):void
		{
			_redirectURI = value;
		}

		public function get scope():Vector.<String>
		{
			return _scope;
		}

		public function set scope(value:Vector.<String>):void
		{
			_scope = value;
		}

		public function get connect_method():String
		{
			return _connect_method;
		}

		public function set connect_method(value:String):void
		{
			_connect_method = value;
		}

		public function get authorizationURL():String
		{
			return apiPath + "/oauth/authorize"
				+ "?client_id=" + _appid
				+ "&redirect_uri=" + _redirectURI
				+ "&type=user_agent"
				+ "&scope=" + _scope.toString()
				+ "&display=" + connect_method;
		}

		public function get token():String { return _token; }

		public function get apiPath():String
		{
			return useSecuredPath ? apiSecuredPath : apiUnsecuredPath;
		}

		public function get me():FacebookUser
		{
			return _me;
		}

		public function get authorized():Boolean
		{
			return _authorized;
		}

		public function get savedSession():SharedObject
		{
			if(_savedSession)
				return _savedSession;

			var name:String = "FacebookGraph" + _appid;
			_savedSession = SharedObject.getLocal(name);
			return _savedSession;
		}

		/* Whether or not to store the access token in a flash cookie */
		public function get storeSession():Boolean
		{
			return _storeSession;
		}

		public function set storeSession(value:Boolean):void
		{
			_storeSession = value;
		}

		public function get JSONHelper():IJSON
		{
			return _JSONHelper;
		}

		public function set JSONHelper(value:IJSON):void
		{
			_JSONHelper = value;
		}

	}
}

class FBGraphEnforcer{}