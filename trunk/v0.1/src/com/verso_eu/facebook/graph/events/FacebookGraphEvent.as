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
package com.verso_eu.facebook.graph.events
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Dreammonkey
	 */
	public class FacebookGraphEvent extends Event
	{

		public static const CONNECTED:String = "connected";
		public static const DATA:String = "data";
		public static const ERROR:String = "error";
		public static const CALL_COMPLETE:String = "callComplete";

		public var data:Object;

		public function FacebookGraphEvent(type:String, _data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			data = _data;
		}

		public override function clone():Event
		{
			return new FacebookGraphEvent(type, data, bubbles, cancelable);
		}

		public override function toString():String
		{
			return formatToString("FacebookGraphEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
		}

	}

}