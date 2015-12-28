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
package com.verso_eu.facebook.graph.data.users
{

	public class FacebookUser
	{
		// Publicly available

		// The user's Facebook ID
		public var id:String;
		// The user's full name
		public var name:String;
		// The user's first name
		public var first_name:String;
		// The user's last name
		public var last_name:String;
		// The user's gender;
		public var gender:String;
		// The user's locale
		public var locale:String;

		// Available to everyone on Facebook

		// The URL of the profile for the user on Facebook
		public var link:String;
		// An anonymous, but unique identifier for the user
		public var third_party_id:String;
		// The user's timezone offset from UTC
		public var timezone:int;
		// The last time the user's profile was updated
		public var updated_time:String;
		// The user's account verification status
		public var verified:Boolean;

		// Additional permissions required

		// The blurb that appears under the user's profile picture
		public var about:String;
		// The user's biography
		public var bio:String;
		// The user's birthday
		public var birthday:String
		// A list of the user's education history
		public var education:Object;
		// The proxied or contact email address granted by the user
		public var email:String;
		// The user's hometown
		public var hometown:Object;
		// The genders the user is interested in
		public var interested_in:Object;
		// The user's current location
		public var location:Object;
		// The types of relationships the user is seeking
		public var meeting_for:Object;
		// The user's political view
		public var political:String;
		// The user's favorite quotes
		public var quotes:String;
		// The user's relationship status
		public var relationship_status:String;
		// The user's religion
		public var religion:String;
		// The user's significant other
		public var significant_other:Object;
		// The URL of the user's personal website
		public var website:String;
		// A list of the user's work history
		public var work:Object;


		public function FacebookUser(me:Object)
		{
			// Publicly available
			id = me.id ? me.id : id;
			name = me.name ? me.name : name;
			first_name = me.first_name ? me.first_name : first_name;
			last_name = me.last_name ? me.last_name : last_name;
			gender = me.gender ? me.gender : gender;
			locale = me.locale ? me.locale : locale;

			// Available to everyone on Facebook
			link = me.link ? me.link : link;
			third_party_id = me.third_party_id ? me.third_party_id : third_party_id;
			timezone = me.timezone ? me.timezone : timezone;
			updated_time = me.updated_time ? me.updated_time : updated_time;
			verified = me.verified ? me.verified : verified;

			// Additional permissions required
			about = me.about ? me.about : about;
			bio = me.bio ? me.bio : bio;
			birthday = me.birthday ? me.birthday : birthday;
			education = me.education ? me.education : education;
			email = me.email ? me.email : email;
			hometown = me.hometown ? me.hometown : hometown;
			interested_in = me.interested_in ? me.interested_in : interested_in;
			location = me.location ? me.location : location;
			meeting_for = me.meeting_for ? me.meeting_for : meeting_for;
			political = me.political ? me.political : political;
			quotes = me.quotes ? me.quotes : quotes;
			relationship_status = me.relationship_status ? me.relationship_status : relationship_status;
			religion = me.religion ? me.religion : religion;
			significant_other = me.significant_other ? me.significant_other : significant_other;
			website = me.website ? me.website : website;
			work = me.work ? me.work : work;
		}

	}

}