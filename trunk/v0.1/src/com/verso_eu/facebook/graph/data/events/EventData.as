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
package com.verso_eu.facebook.graph.data.events
{
	public class EventData
	{
		// The event ID
		public var id:String;
		// The profile that created the event
		public var owner:Object;
		// The event title
		public var name:String;
		// The long-form description of the event
		public var description:String;
		// The start time of the event, as you want it to be displayed on facebook
		public var start_time:String;
		// The end time of the event, as you want it to be displayed on facebook
		public var end_time:String;
		// The location for this event
		public var location:String;
		// The location of this event (sic)
		public var venue:Object;
		// The visibility of this event
		public var privacy:String;
		// The last time the event was updated
		public var updated_time:String;

		public function EventData(_data:Object)
		{
			id = _data.id ? _data.id : id;
			owner = _data.owner ? _data.owner : owner;
			name = _data.name ? _data.name : name;
			description = _data.description ? _data.description : description;
			start_time = _data.start_time ? _data.start_time : start_time;
			end_time = _data.end_time ? _data.end_time : end_time;
			location = _data.location ? _data.location : location;
			venue = _data.venue ? _data.venue : venue;
			privacy = _data.privacy ? _data.privacy : privacy;
			updated_time = _data.updated_time ? _data.updated_time : updated_time;
		}
	}
}