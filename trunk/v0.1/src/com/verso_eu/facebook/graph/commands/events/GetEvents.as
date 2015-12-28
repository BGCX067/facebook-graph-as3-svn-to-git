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
package com.verso_eu.facebook.graph.commands.events
{
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.data.events.EventData;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;

	public class GetEvents extends GraphCall
	{
		public static const METHOD_NAME:String = 'events';
		public static const BINARY:Boolean = false;

		public function GetEvents(target:String = 'me')
		{
			super(target + '/' + METHOD_NAME, _data, null, URLRequestMethod.GET, BINARY);
		}

		override protected function callCompleteHandler(e:Event):void
		{
			var eventsData:Array = FacebookGraph.getInstance().JSONHelper.parse(e.target.data.toString()).data;
			var events:Vector.<EventData> = new Vector.<EventData>();

			var tot:int = eventsData.length;
			var i:int = 0;
			while(i<tot) {
				events[i] = new EventData(eventsData[i]);
				i++;
			}

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {events:events}));
			eventsData = null;
		}

	}

}