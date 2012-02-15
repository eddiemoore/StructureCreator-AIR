package com.structurecreator
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context
	{
		public function MainContext()
		{
			super();
		}
		
		override public function startup():void
		{
			trace("App Started");
			super.startup();
		}
	}
}