package com.schemacreator.events
{
	import flash.events.Event;
	
	public class SchemaEvent extends Event
	{
		public static const FOLDER_SELECTED:String = 'folderSelected';
		public static const FILE_SELECTED:String = 'fileSelected';
		public static const SCHEMA_CREATED:String = 'schemaCreated';
		
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