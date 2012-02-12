package com.structurecreator.schemas 
{
	import com.structurecreator.customvars.CustomVariables;
	import com.structurecreator.customvars.CustomVarsHolder;
	import com.structurecreator.events.FileEvent;
	import com.structurecreator.FileCreator;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class XMLSchema 
	{
		private var _xmlUrl:String = '';
		private var _directory:String = '';
		private var _xmlLoader:URLLoader;
		private var _totalFolders:int;
		private var _totalFiles:int;
		private var _foldersCreated:int;
		private var _filesCreated:int;
		private var _customVars:Array;
		
		public function XMLSchema(schema_xml:String, directory:String) 
		{
			_xmlUrl = schema_xml;
			_directory = directory;
			
			_totalFiles = 0;
			_totalFolders = 0;
			_filesCreated = 0;
			_foldersCreated = 0;
			
			loadSchemaXml();
		}
		
		private function loadSchemaXml():void 
		{
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, hComplete);
			_xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, secError);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, hError);
			_xmlLoader.load(new URLRequest(_xmlUrl));
		}
		
		private function hComplete(e:Event):void 
		{
			trace("XML Load Complete");
			_xmlLoader.removeEventListener(Event.COMPLETE, hComplete);
			_xmlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, secError);
			_xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, hError);
			
			var xml:XML = new XML(e.currentTarget.data);
			
			trace(xml.folder.length());
			_totalFiles = xml.descendants('file').length();
			_totalFolders = xml.descendants('folder').length();
			_filesCreated = 0;
			
			_xmlLoader = null;
			
			createStructure(xml);
		}
		
		private function createStructure(xml:XML, path:String = '/'):void
		{
			var currPath:String = path;
			
			//CaptainsLog.getInstance().addToLog(currPath);
			
			//FILES
			var file:File;
			var url:String;
			var fc:FileCreator;
			
			
			for (var j:int = 0; j < xml.file.length(); j++) 
			{
				trace("create file: " + xml.file[j].@name);
				url = xml.file[j].@url;
				trace("URL = ", url);
				
				fc = new FileCreator(_directory + currPath, xml.file[j].@name, url, xml.file[j].text());
				fc.addEventListener(FileEvent.FILE_CREATED, fc_fileCreated);
			}
			
			//FOLDERS
			var dir:File;
			var newname:String;
			for (var i:int = 0; i < xml.folder.length(); ++i)
			{
				trace("create folder : " + xml.folder[i].@name);
				dir = new File();
				dir.url = _directory + currPath;
				newname = CustomVariables.getInstance().updateVars(xml.folder[i].@name);
				dir = dir.resolvePath(newname);
				dir.createDirectory();
				
				if (xml.folder[i].folder.length() > 0 || xml.folder[i].file.length() > 0)
				{
					createStructure(xml.folder[i] as XML, currPath + newname + '/');
				}
				_foldersCreated += 1;
			}
			
			if (_filesCreated >= _totalFiles && _foldersCreated >= _totalFolders)
			{
				trace("DONE!!!");
				cleanUp();
			}
		}
		
		private function fc_fileCreated(e:FileEvent):void 
		{
			_filesCreated += 1;
			trace(_filesCreated, '/', _totalFiles);
			if (_filesCreated >= _totalFiles && _foldersCreated >= _totalFolders)
			{
				trace("DONE!!!");
				cleanUp();
			}
		}
		
		private function cleanUp():void 
		{
			_customVars = null;
			_xmlLoader = null;
		}
		
		private function secError(e:SecurityErrorEvent):void 
		{
			trace("security error: " + e);
		}
		
		private function hError(e:IOErrorEvent):void 
		{
			trace("Error: " + e);
		}
		
	}

}