package com.structurecreator.events
{
	import flash.events.Event;
	
	public class StructureCreatorEvent extends Event
	{
		public static const APP_STARTED:String = 'appStarted';
		public static const CREATION_STARTED:String = 'creationStarted';
		public static const CREATION_COMPLETE:String = 'creationComplete';
		
		public function StructureCreatorEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new Event(type);
		}
	}
}