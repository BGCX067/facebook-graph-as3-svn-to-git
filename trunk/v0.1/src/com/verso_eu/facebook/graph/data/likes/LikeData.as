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
package com.verso_eu.facebook.graph.data.likes
{
	public class LikeData
	{
		public var id:String;
		public var name:String;
		public var category:String;
		public var created_time:String;

		public function LikeData(_data:Object)
		{
			id = _data.id ? _data.id : id;
			name = _data.name ? _data.name : name;
			category = _data.category ? _data.category : category;
			created_time = _data.created_time ? _data.created_time : created_time;
		}
	}
}