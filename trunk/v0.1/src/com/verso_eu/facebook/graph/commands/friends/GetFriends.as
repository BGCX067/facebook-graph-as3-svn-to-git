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
package com.verso_eu.facebook.graph.commands.friends
{
	import com.adobe.serialization.json.JSON;
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.data.users.FacebookUser;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;

	public class GetFriends extends GraphCall
	{
		public static const METHOD_NAME:String = 'me/friends';
		public static const BINARY:Boolean = false;

		public function GetFriends(limit:uint=0, offset:uint=0)
		{
			super(METHOD_NAME, _data, null, URLRequestMethod.GET, BINARY);

			_data.limit = limit.toString();
			_data.offset = offset.toString();
		}

		override protected function callCompleteHandler(e:Event):void
		{
			var friendsData:Array = FacebookGraph.getInstance().JSONHelper.parse(e.target.data.toString()).data;
			var friends:Vector.<FacebookUser> = new Vector.<FacebookUser>();

			var tot:int = friendsData.length;
			var i:int = 0;
			while(i<tot) {
				friends[i] = new FacebookUser(friendsData[i]);
				i++;
			}

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {friends:friends}));
			friendsData = null;
		}

	}

}