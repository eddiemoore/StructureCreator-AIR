package com.structurecreator.model
{
	import com.structurecreator.events.SchemaEvent;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SchemaModel extends Actor
	{
		private var _schemaFile:File = File.documentsDirectory;
		
		public function SchemaModel()
		{
			
		}
		
		public function get schemaFile():File
		{
			return _schemaFile;
		}
		
		public function selectSchemaFile():void
		{
			schemaFile.browse();
			schemaFile.addEventListener(Event.SELECT, onSchemaSelected);
		}
		
		protected function onSchemaSelected(event:Event):void
		{
			dispatch(new SchemaEvent(SchemaEvent.SCHEMA_SELECTED));
		}
	}
}