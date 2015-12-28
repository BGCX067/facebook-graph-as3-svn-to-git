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
package com.verso_eu.facebook.graph.commands.photos
{
	import com.adobe.serialization.json.JSON;
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	import ru.inspirit.net.MultipartURLLoader;

	public class PhotoUpload extends GraphCall
	{
		protected var _ba:ByteArray;
		protected var _msg:String;
		protected var multiCaller:MultipartURLLoader;

		public function PhotoUpload(byteArray:ByteArray, album_id:String = 'me', message:String = '')
		{
			super(album_id + '/photos', _data, null, URLRequestMethod.POST, false);

			/*
			var bmd1:BitmapData = new BitmapData(200, 200, false, 0x666666);
			var bm1:Bitmap = new Bitmap(bmd1);
			var jpgEncoder:JPGEncoder = new JPGEncoder();
			*/
			_ba = byteArray;
			_msg = message;
		}

		override public function initialize():void
		{
			success = false;

			multiCaller = new MultipartURLLoader();
			multiCaller.addEventListener(Event.COMPLETE, callCompleteHandler);

			multiCaller.addVariable('message', _msg);
			multiCaller.addVariable('access_token', FacebookGraph.getInstance().token);
			multiCaller.addFile(_ba, "image.jpg", 'image');

			var url:String = apiPath + "/" + path +  "?";

			multiCaller.load(url);
		}

		override protected function callCompleteHandler(e:Event):void
		{

			var result:Object = FacebookGraph.getInstance().JSONHelper.parse(String(e.currentTarget.loader.data));

			multiCaller.removeEventListener(Event.COMPLETE, callCompleteHandler);

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {result:result}));
		}
	}
}