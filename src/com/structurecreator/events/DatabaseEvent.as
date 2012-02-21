package com.structurecreator.events
{
	import flash.events.Event;
	
	public class DatabaseEvent extends Event
	{
		public static const DATABASE_UPDATED:String = 'databaseUpdated';
		
		public function DatabaseEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new DatabaseEvent(type); 
		}
	}
}