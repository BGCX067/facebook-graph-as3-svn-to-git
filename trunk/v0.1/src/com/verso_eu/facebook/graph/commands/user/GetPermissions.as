package com.verso_eu.facebook.graph.commands.user
{
	import com.flashoasis.debug.Debugger;
	import com.verso_eu.facebook.graph.FacebookGraph;
	import com.verso_eu.facebook.graph.events.FacebookGraphEvent;
	import com.verso_eu.facebook.graph.net.GraphCall;
	
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class GetPermissions extends GraphCall
	{
		public function GetPermissions(path:String="me", data:URLVariables=null, apiPath:String=null, method:String=null, binary:Boolean=false)
		{
			super(path + '/permissions', _data, null, URLRequestMethod.GET, false);
		}

		override protected function callCompleteHandler(e:Event):void
		{
			super.callCompleteHandler(e);

			Debugger.debug(e.target.data);
			var permissions:Vector.<String> = new Vector.<String>;
			var perm_obj:Object = FacebookGraph.getInstance().JSONHelper.parse(e.target.data.toString()).data[0];
			for (var p:String in perm_obj){
				//Debugger.debug(p, perm_obj[p]);
				if(perm_obj[p] === 1) permissions.push(p);
			}
			//Debugger.debug(permissions);
			dispatchEvent(new FacebookGraphEvent(FacebookGraphEvent.CALL_COMPLETE, {permissions:permissions}));
			perm_obj = null;
		}
	}
}