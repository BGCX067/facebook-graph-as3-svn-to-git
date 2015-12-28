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
package com.verso_eu.facebook.graph.net
{
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class GraphCall extends EventDispatcher
	{
		protected var path:String = "me";
		protected var _data:URLVariables = new URLVariables();
		protected var apiPath:String = "https://graph.facebook.com";
		protected var method:String = URLRequestMethod.POST;
		protected var binary:Boolean;
		protected var caller:URLLoader;

		protected var contentType:String = "application/x-www-form-urlencoded";

		protected var success:Boolean;

		public function GraphCall(path:String="me", data:URLVariables=null, apiPath:String=null, method:String=null, binary:Boolean=false)
		{
			this.path = path;
			this._data = data ? data : this._data;
			this.apiPath = apiPath ? apiPath : this.apiPath;
			this.method = method ? method : this.method;
			this.binary = binary;

		}

		public function initialize():void
		{
			success = false;

			_data.access_token = FacebookGraph.getInstance().token;

			caller = new URLLoader();
			caller.addEventListener(Event.COMPLETE, callCompleteHandler);
			caller.addEventListener(IOErrorEvent.IO_ERROR, callErrorHandler);

			var req:URLRequest = new URLRequest();
			req.contentType = contentType;
			req.url = apiPath + "/" + path +  "?";
			req.data = _data;
			req.method = method;

			caller.dataFormat = this.binary ? URLLoaderDataFormat.BINARY : URLLoaderDataFormat.TEXT;

			if(FacebookGraph.getInstance().debug)
				trace(this, this + " : " + req.url + unescape(_data.toString()));

			caller.load(req);
		}

		protected function callErrorHandler(e:IOErrorEvent):void
		{
			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, { }));
			close();
		}

		protected function callCompleteHandler(e:Event):void
		{
			success = true;
			close();
		}

		protected function close():void
		{
			caller.removeEventListener(Event.COMPLETE, callCompleteHandler);
			caller.removeEventListener(IOErrorEvent.IO_ERROR, callErrorHandler);
		}

		public function get data():URLVariables { return _data; }

		public function set data(value:URLVariables):void
		{
			_data = value;
		}

		/**
		 * Images will only be loaded when developing locally and for Air.
		 * All image paths are redirected to static.sk.fbcdn.net
		 * It's cross domain policy file is not opened for third party websites.
		 * http://profile.ak.fbcdn.net/crossdomain.xml
		 *
		 * The solution is to load the image through a serverside proxy.
		 * php example:
		 *
		 * <?php
		 * 	$path=$_GET['path'];
		 * 	header("Content-Description: Facebook Proxied File");
		 * 	header("Content-Type: image");
		 * 	header("Content-Disposition: attachment; filename=".$path);
		 * 	@readfile($path);
		 * ?>
		 */

		public function get callpath():String
		{
			_data.access_token = FacebookGraph.getInstance().token;

			var req:URLRequest = new URLRequest();
			req.contentType = contentType;
			req.url = apiPath + "/" + path +  "?";
			req.data = _data;
			req.method = method;

			return req.url + unescape(_data.toString());
		}

	}

}