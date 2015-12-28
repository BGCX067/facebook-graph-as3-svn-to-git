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
package com.verso_eu.facebook.graph.data.albums
{
	public class AlbumData
	{
		public var count:int;
		public var created_time:String;
		public var from:Object;
		public var id:String;
		public var link:String;
		public var name:String;
		public var description:String;
		public var location:String;
		public var privacy:String;
		public var type:String;
		public var updated_time:String;

		public function AlbumData(_data:Object)
		{
			count = _data.count ? _data.count : count;
			created_time = _data.created_time ? _data.created_time : created_time;
			from = _data.from ? _data.from : from;
			id = _data.id ? _data.id : id;
			link = _data.link ? _data.link : link;
			name = _data.name ? _data.name : name;
			description = _data.description ? _data.description : description;
			location = _data.location ? _data.location : location;
			privacy = _data.privacy ? _data.privacy : privacy;
			type = _data.type ? _data.type : type;
			updated_time = _data.updated_time ? _data.updated_time : updated_time;
		}
	}
}