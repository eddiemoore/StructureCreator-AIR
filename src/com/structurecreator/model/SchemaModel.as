package com.structurecreator.model
{
	import com.structurecreator.events.SchemaEvent;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SchemaModel extends Actor
	{
		private var _schemaFile:File = File.documentsDirectory;
		private var _schemaURL:String = '';
		
		public function SchemaModel()
		{
			
		}
		
		/**
		 * Open file select to select schema file
		 */
		public function selectSchemaFile():void
		{
			schemaFile.browse();
			schemaFile.addEventListener(Event.SELECT, onSchemaSelected);
		}
		
		/**
		 * On select dispatch the event to the event dispatcher
		 */
		protected function onSchemaSelected(event:Event):void
		{
			_schemaURL = _schemaFile.url;
			eventDispatcher.dispatchEvent(new SchemaEvent(SchemaEvent.SCHEMA_SELECTED));
		}
		
		public function get schemaFile():File
		{
			return _schemaFile;
		}

		public function get schemaURL():String
		{
			return _schemaURL;
		}

		public function set schemaURL(value:String):void
		{
			_schemaURL = value;
		}

	}
}