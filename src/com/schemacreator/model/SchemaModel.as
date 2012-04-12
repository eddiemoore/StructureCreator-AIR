package com.schemacreator.model
{
	import com.schemacreator.events.SchemaEvent;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SchemaModel extends Actor
	{
		private var _projectFolder:File = File.documentsDirectory;
		private var _schemaFile:File = File.documentsDirectory;
		private var _saveText:String = '';
		
		public function SchemaModel()
		{
			
		}
		
		public function get projectFolder():File
		{
			return _projectFolder;
		}
		
		public function browseForFolder():void
		{
			_projectFolder.addEventListener(Event.SELECT, onFolderSelect);
			_projectFolder.browseForDirectory("Select Schema Folder");
		}
		
		protected function onFolderSelect(event:Event):void
		{
			eventDispatcher.dispatchEvent(new SchemaEvent(SchemaEvent.FOLDER_SELECTED));
		}
		
		public function browseForFile():void
		{
			_saveText = '<?xml version="1.0" encoding="utf-8"?>\n';
			checkFolder(_projectFolder);
			
			saveFile();
		}
		
		private function checkFolder(dir:File, tabs:int = 1, dirName:String='%BASE%'):void
		{
			_saveText += new Array(tabs).join('\t');
			_saveText += '<folder name="'+dirName+'">\n';
			var files:Array = dir.getDirectoryListing();
			var len:int = files.length;
			var f:File;
			var u1:String, u2:String, url:String;
			for(var i:uint = 0; i < len; ++i)
			{
				f = files[i];
				if (f.isDirectory)
				{
					checkFolder(f, tabs+1, f.name);
				}
				else
				{
					_saveText += new Array(tabs+1).join('\t');
					_saveText += '<file name="'+f.name+'" url="'+f.url+'" />\n';
				}
			}
			_saveText += new Array(tabs).join('\t');
			_saveText += '</folder>\n';
		}
		
		private function saveFile():void
		{
			try
			{
				
				_schemaFile.browseForSave("Save Schema As");
				_schemaFile.addEventListener(Event.SELECT, onFileSelect);
			}
			catch (error:Error)
			{
				trace("Failed:", error.message);
			}	
		}
		
		protected function onFileSelect(event:Event):void
		{
			var filestream:FileStream = new FileStream();
			filestream.addEventListener(Event.CLOSE, fileWrittenComplete);
			filestream.open(_schemaFile, FileMode.WRITE);
			filestream.writeUTFBytes(_saveText);
			filestream.close();
		}
		
		protected function fileWrittenComplete(event:Event):void
		{
			trace("MySchema.xml has been written to the file system.");
			eventDispatcher.dispatchEvent(new SchemaEvent(SchemaEvent.SCHEMA_CREATED));
		}
	}
}