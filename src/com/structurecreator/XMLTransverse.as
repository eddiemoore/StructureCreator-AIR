package com.structurecreator
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLTransverse
	{
		private static var _schemaXML:String;
		private static var _directory:String;
		
		private var _totalFiles:int;
		private var _filesCreated:int;
		
		public function XMLTransverse(schemaXML:String, directory:String)
		{
			_schemaXML = schemaXML;
			_directory = directory;
			
			loadXML();
		}
		
		private function loadXML():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			xmlLoader.load(new URLRequest(_schemaXML));
		}
		
		private function onLoadComplete(event:Event):void
		{
			trace("Schema Load Complete");
			removeEvents(event.target as URLLoader);
			
			var xml:XML = new XML(event.currentTarget.data);
			
			_totalFiles = xml.descendants('file').length();
			_filesCreated = 0;
			
			createStructure(xml);
		}
		
		/**
		 * Recursive function that generates the structure of the project
		 */
		private function createStructure(xml:XML, path:String = '/'):void
		{
			var currPath:String = path;
			
			//FILES
			var file:File;
			var url:String;
			
			var length:int = xml.file.length();
			
			for (var i:int = 0; i < length; ++i)
			{
				url = xml.file[i].@url;
				
				new FileCreate(_directory + currPath, CustomVars.getInstance().addVariables(xml.file[i].@name), url, xml.file[i].text());
				
				_filesCreated += 1;
			}
			
			//FOLDERS
			var dir:File;
			length = xml.folder.length();
			for (var j:int = 0; j < length; ++j)
			{
				//CaptainsLog.getInstance().addToLog("create folder : " + xml.folder[i].@name);
				dir = new File();
				dir.url = _directory + currPath;
				dir = dir.resolvePath(CustomVars.getInstance().addVariables(xml.folder[j].@name));
				dir.createDirectory();
				
				if (xml.folder[j].folder.length() > 0 || xml.folder[j].file.length() > 0)
				{
					createStructure(xml.folder[j] as XML, currPath + CustomVars.getInstance().addVariables(xml.folder[j].@name) + '/');
				}
			}
			//_filesCreated >= _totalFiles ? writeLogFile() : '';
		}
		
		
		/**
		 * Error Handling Below
		 */
		private function onSecurityError(event:SecurityErrorEvent):void
		{
			trace("Security Error: " + event);
			removeEvents(event.target as URLLoader);
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			trace("IO Error: " + event);
			removeEvents(event.target as URLLoader);
			
		}
		
		private function removeEvents(xmlLoader:URLLoader):void
		{
			xmlLoader.removeEventListener(Event.COMPLETE, onLoadComplete);
			xmlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
	}
}