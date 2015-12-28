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
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;

	public class PublishStream extends GraphCall
	{

		public var message:String;
		public var picture:String;
		public var link:String;
		public var name:String;
		public var caption:String;
		public var description:String;
		public var source:String;
		//public var actions:Object;
		//public var privacy:Object;
		//public var targeting:Object;

		public function PublishStream(target:String = 'me')
		{
			super(target+"/feed", null, "https://graph.facebook.com", URLRequestMethod.POST, false);

		}

		override public function initialize():void
		{
			if(message) _data.message = message;
			if(picture) _data.picture = picture;
			if(link) _data.link = link;
			if(name) _data.name = name;
			if(caption) _data.caption = caption;
			if(description) _data.description = description;
			if(source) _data.source = source;

			//todo: source / actions / privacy / targeting

			super.initialize();
		}


		override protected function callCompleteHandler(e:Event):void
		{
			super.callCompleteHandler(e);
			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, e))
		}

	}

}