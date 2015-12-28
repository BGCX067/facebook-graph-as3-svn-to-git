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
package com.verso_eu.facebook.graph.commands.likes
{
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.data.likes.LikeData;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;

	public class GetLikes extends GraphCall
	{

		public function GetLikes(path:String="me", limit:uint=0, offset:uint=0)
		{
			super(path + '/likes', _data, null, URLRequestMethod.GET, false);

			_data.limit = limit.toString();
			_data.offset = offset.toString();
		}

		override protected function callCompleteHandler(e:Event):void
		{
			super.callCompleteHandler(e);

			var likeData:Array = FacebookGraph.getInstance().JSONHelper.parse(e.target.data.toString()).data;
			var likes:Vector.<LikeData> = new Vector.<LikeData>();

			var tot:int = likeData.length;
			var i:int = 0;
			while(i<tot) {
				likes[i] = new LikeData(likeData[i]);
				i++
			}

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {likes:likes}));
			likeData = null;
			close();
		}
	}
}