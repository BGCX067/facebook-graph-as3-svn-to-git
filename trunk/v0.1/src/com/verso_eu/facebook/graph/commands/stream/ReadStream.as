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
package com.verso_eu.facebook.graph.commands.stream
{
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.data.stream.Post;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;

	public class ReadStream extends GraphCall
	{
		public function ReadStream(target:String="me")
		{
			super(target+'/feed', null, null, URLRequestMethod.GET, false);
		}

		override protected function callCompleteHandler(e:Event):void
		{
			super.callCompleteHandler(e);

			var streamData:Array = FacebookGraph.getInstance().JSONHelper.parse(e.target.data.toString()).data;
			var stream:Vector.<Post> = new Vector.<Post>();

			var tot:int = streamData.length;
			var i:int;
			while(i<tot){
				stream[i] = new Post(streamData[i]);
				i++;
			}

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {stream:stream}));
		}
	}
}