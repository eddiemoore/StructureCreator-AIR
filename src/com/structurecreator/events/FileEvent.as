package com.structurecreator.events
{
	import flash.events.Event;
	
	public class FileEvent extends Event
	{
		public static const START_CREATION:String = 'startCreation';
		public static const FILE_CREATED:String = 'fileCreated';
		
		public function FileEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new FileEvent(type);
		}
	}
}