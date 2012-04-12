package com.structurecreator.events
{
	import flash.events.Event;
	
	public class SchemaEvent extends Event
	{
		public static const SCHEMA_SELECTED:String = "schemaSelected";
		public static const CREATE_NEW_SCHEMA:String = "createNewSchema";
		
		public function SchemaEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new SchemaEvent(type);
		}
	}
}