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
package com.verso_eu.facebook.graph.data.stream
{
	import com.verso_eu.facebook.graph.data.users.FacebookUser;

	public class Post
	{
		public var likes:int; // The number of likes on this post
		public var id:String; // The post ID
		public var from:FacebookUser; // Information about the user who posted the message
		public var to:FacebookUser; // Profiles mentioned or targeted in this post
		public var message:String; // The message
		public var picture:String; // If available, a link to the picture included with this post
		public var link:String; // The link attached to this post
		public var name:String; // The name of the link
		public var caption:String; // The caption of the link (appears beneath the link name)
		public var description:String; // A description of the link (appears beneath the link caption)
		public var source:String; // A URL to a Flash movie or video file to be embedded within the post
		public var icon:String; // A link to an icon representing the type of this post
		public var attribution:String // A string indicating which application was used to create this post
		public var actions:Object; // A list of available actions on the post (including commenting, liking, and an optional app-specified action)
		public var privacy:Object; // The privacy settings of the Post
		public var created_time:String; //created_time
		public var updated_time:String; // The time of the last comment on this post
		public var targeting:Object; // Location and language restrictions for Page posts only

		public function Post(_data:Object)
		{
			likes = _data.likes ? _data.likes : likes;
			id = _data.id ? _data.id : id;
			from = _data.from ? new FacebookUser(_data.from) : from;
			to = _data.to ? new FacebookUser(_data.to) : to;
			message = _data.message ? _data.message : message;
			picture = _data.picture ? _data.picture : picture;
			link = _data.link ? _data.link : link;
			name = _data.name ? _data.name : name;
			caption = _data.caption ? _data.caption : caption;
			description = _data.description ? _data.description : description;
			source = _data.source ? _data.source : source;
			icon = _data.icon ? _data.icon : icon;
			attribution = _data.attribution ? _data.attribution : attribution;
			actions = _data.actions ? _data.actions : actions;
			privacy = _data.privacy ? _data.privacy : privacy;
			created_time = _data.created_time ? _data.created_time : created_time;
			updated_time = _data.updated_time ? _data.updated_time : updated_time;
			targeting = _data.targeting ? _data.targeting : targeting;
		}
	}
}