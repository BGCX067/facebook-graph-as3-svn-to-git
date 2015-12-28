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
package com.verso_eu.facebook.graph.data.photos
{
	import com.verso_eu.facebook.graph.data.tags.TagsData;

	public class PhotoData
	{
		public var created_time:String;
		public var from:Object;
		public var tags:Vector.<TagsData> = new Vector.<TagsData>();
		public var height:int;
		public var icon:String;
		public var id:String;
		public var images:Array;
		public var link:String;
		public var picture:String;
		public var position:int;
		public var source:String;
		public var updated_time:String;
		public var width:String;

		public function PhotoData(_data:Object)
		{
			created_time = _data.created_time ? _data.created_time : created_time;
			from = _data.from ? _data.from : from;
			height = _data.height ? _data.height : height;
			icon = _data.icon ? _data.icon : icon;
			id = _data.id ? _data.id : id;
			images = _data.images ? _data.images : images;
			link = _data.link ? _data.link : link;
			picture = _data.picture ? _data.picture : picture;
			position = _data.position ? _data.position : position;
			source = _data.source ? _data.source : source;
			updated_time = _data.updated_time ? _data.updated_time : updated_time;
			width = _data.width ? _data.width : width;

			if(_data.tags) {
				var tot:int = _data.tags.data.length;
				var i:int = 0;
				while(i<tot){
					tags[i] = new TagsData(_data.tags.data[i]);
					i++;
				}
			}

		}
	}
}