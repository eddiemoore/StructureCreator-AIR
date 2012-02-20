package com.structurecreator.model.schemas
{
	
	import com.structurecreator.events.FileEvent;
	import com.structurecreator.events.StructureCreatorEvent;
	import com.structurecreator.model.CustomVariableModel;
	import com.structurecreator.services.FileCreateService;
	import com.structurecreator.services.vo.FileDetailsVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.base.CommandMap;
	import org.robotlegs.mvcs.Actor;
	
	public class XMLSchema extends Actor
	{
		private var _directory:String = '';
		private var _xmlLoader:URLLoader;
		private var _totalFolders:int;
		private var _totalFiles:int;
		private var _foldersCreated:int;
		private var _filesCreated:int;
		
		[Inject]
		public var customVarsModel:CustomVariableModel;
		
		[Inject]
		public var fileCreatorService:FileCreateService;
		
		public function XMLSchema()
		{
			
		}
		
		/**
		 * Starts initail creation from xml schema
		 */
		public function start (schema_xml:String, directory:String):void
		{
			_directory = directory;
			
			_totalFiles = 0;
			_totalFolders = 0;
			_filesCreated = 0;
			_foldersCreated = 0;
			
			loadSchemaXml(schema_xml);
		}
		
		/**
		 * Sets up loader and starts loading of xml
		 */
		private function loadSchemaXml(url:String=''):void 
		{
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, hComplete);
			_xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, secError);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, hError);
			_xmlLoader.load(new URLRequest(url));
		}
		
		/**
		 * On xml load complete find total files and folders and start creation
		 */
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
			
			//listen for file creation event
			eventDispatcher.addEventListener(FileEvent.FILE_CREATED, onFileCreated);
			
			var fileDetailsVO:FileDetailsVO;
			for (var j:int = 0; j < xml.file.length(); j++) 
			{
				//Setup new file details value object
				fileDetailsVO = new FileDetailsVO();
				fileDetailsVO.dir = _directory + currPath;
				fileDetailsVO.name = xml.file[j].@name;
				fileDetailsVO.url = xml.file[j].@url;
				fileDetailsVO.file_content = xml.file[j].text();
				
				dispatch(new FileEvent(FileEvent.START_CREATION, fileDetailsVO));
			}
			
			//FOLDERS
			var dir:File;
			var newname:String;
			for (var i:int = 0; i < xml.folder.length(); ++i)
			{
				trace("create folder : " + xml.folder[i].@name);
				dir = new File();
				dir.url = _directory + currPath;
				newname = customVarsModel.updateVariablesInStr(xml.folder[i].@name);
				dir = dir.resolvePath(newname);
				dir.createDirectory();
				
				if (xml.folder[i].folder.length() > 0 || xml.folder[i].file.length() > 0)
				{
					createStructure(xml.folder[i] as XML, currPath + newname + '/');
				}
				_foldersCreated += 1;
			}
			trace("Files : " + _filesCreated + '/' + _totalFiles);
			trace("Folders : " + _foldersCreated + '/' + _totalFolders);
			allDone();
		}
		
		/**
		 * On file creation complete add 1 to files created and run check to see if creation is complete
		 */
		private function onFileCreated(e:FileEvent):void 
		{
			_filesCreated += 1;
			allDone();
		}
		
		/**
		 * Checks to see if all files and folders have been created
		 */
		private function allDone():void
		{
			trace(_filesCreated, '/', _totalFiles);
			if (_filesCreated >= _totalFiles && _foldersCreated >= _totalFolders)
			{
				trace("Created Everything");
				eventDispatcher.dispatchEvent(new StructureCreatorEvent(StructureCreatorEvent.CREATION_COMPLETE));
				cleanUp();
			}
		}
		
		/**
		 * Clears up variables and listeners
		 */
		private function cleanUp():void 
		{
			_xmlLoader = null;
			_directory = '';
		}
		
		/**
		 * On Security Error
		 */
		private function secError(e:SecurityErrorEvent):void 
		{
			trace("security error: " + e);
		}
		
		/**
		 * On IO Error
		 */
		private function hError(e:IOErrorEvent):void 
		{
			trace("Error: " + e);
		}
	}
}