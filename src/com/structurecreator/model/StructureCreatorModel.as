package com.structurecreator.model
{
	import com.structurecreator.events.ProjectFolderEvent;
	import com.structurecreator.events.SchemaEvent;
	import org.robotlegs.mvcs.Actor;
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class StructureCreatorModel extends Actor
	{
		private var _projectFolder:File = File.documentsDirectory;
		private var _schemaFile:File = File.documentsDirectory;
		
		public function StructureCreatorModel()
		{
		}
		
		/**
		 * Project Folder
		 */
		public function get projectFolder():File
		{
			return _projectFolder;
		}
		
		public function selectProjectFolder():void
		{
			projectFolder.browseForDirectory("Select Project Folder");
			projectFolder.addEventListener(Event.SELECT, onProjectFolderSelected);
		}
		
		protected function onProjectFolderSelected(event:Event):void
		{
			eventDispatcher.dispatchEvent(new ProjectFolderEvent(ProjectFolderEvent.PROJECT_FOLDER_SELECTED));
		}
		
		/**
		 * Schema File
		 */
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
			eventDispatcher.dispatchEvent(new SchemaEvent(SchemaEvent.SCHEMA_SELECTED));
		}
	}
}