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
package com.verso_eu.facebook.graph.commands.albums
{
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.data.albums.AlbumData;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;

	/**
	 * Returns an array of AlbumData objects.
	 *
	 *
	 */
	public class GetAlbums extends GraphCall
	{
		public function GetAlbums(target:String="me", limit:int = 25)
		{
			super(target + '/albums', _data, null, URLRequestMethod.GET, false);

			_data.limit = limit.toString();
		}

		override protected function callCompleteHandler(e:Event):void
		{
			super.callCompleteHandler(e);

			var albumData:Array = FacebookGraph.getInstance().JSONHelper.parse(e.target.data.toString()).data;
			var albums:Vector.<AlbumData> = new Vector.<AlbumData>();

			var tot:int = albumData.length;
			var i:int = 0;
			while(i<tot) {
				albums[i] = new AlbumData(albumData[i]);
				i++;
			}

			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {albums:albums}));
			albumData = null;
		}

	}
}