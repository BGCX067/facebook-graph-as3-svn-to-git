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
package com.verso_eu.facebook.graph.commands.pictures
{
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author Dreammonkey
	 */
	public class GetPicture extends GraphCall
	{
		protected var picLoader:Loader;
		protected var type:String;

		public function GetPicture(target:String="me",type:String="square")
		{
			super(target + '/picture', _data, FacebookGraph.getInstance().apiSecuredPath, URLRequestMethod.GET, true);

			this.type = type;
			_data.type = type.toString();
		}

		override protected function callCompleteHandler(e:Event):void
		{
			picLoader = new Loader();
			picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoaded);
			picLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			picLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			picLoader.loadBytes(e.target.data as ByteArray);

			close();
		}

		private function onSecurityError(event:SecurityErrorEvent):void
		{
			picLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPicLoaded);
			picLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			picLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.ERROR, {error:event.text}));
		}

		protected function onPicLoaded(event:Event):void
		{
			picLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPicLoaded);
			picLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			picLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {picture:picLoader}));
		}

		protected function onIOError(event:IOErrorEvent):void
		{
			picLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPicLoaded);
			picLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			picLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}

	}

}