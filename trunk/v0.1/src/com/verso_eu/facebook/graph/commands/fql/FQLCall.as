package com.verso_eu.facebook.graph.commands.fql
{
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;

	import flash.events.Event;
	import flash.net.URLRequestMethod;

	public class FQLCall extends GraphCall
	{
		public function FQLCall(query:String="")
		{
			super("fql", _data, null, URLRequestMethod.GET, false);

			_data.q = query;
		}

		override protected function callCompleteHandler(e:Event):void
		{
			super.callCompleteHandler(e);

			var result:Array = FacebookGraph.getInstance().JSONHelper.parse(e.target.data.toString()).data;
			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {result:result}));

			close();
		}
	}
}