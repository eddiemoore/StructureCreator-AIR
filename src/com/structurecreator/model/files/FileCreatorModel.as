package com.structurecreator.model.files
{
	import com.structurecreator.events.FileEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	public class FileCreatorModel extends EventDispatcher
	{
		private var _dir:String;
		private var _url:String;
		private var _name:String;
		private var _file_content:String;
		private var _byte_content:ByteArray;
		
		private var _loader:URLStream;
		private var _urlLoader:URLLoader;
		private var _file_ext:String;
		
		public function FileCreatorModel(dir:String, name:String = '', url:String = '', file_content:String = '')  
		{
			_dir = dir;
			_url = url;
			
			_name = name;//CustomVariables.getInstance().updateVars(name);
			_file_content = file_content;
			
			_file_ext = (_name.substr(_name.lastIndexOf('.') + 1) as String).toLowerCase();
			
			if (_url == '')
			{
				//Text file from content in XML
				createTextFile();
			}
			else if (FileTypes.NON_TEXT_EXT_ARRAY.indexOf(_file_ext) > -1)
			{
				loadByteFile();
			} 
			else
			{
				//Text file from URL
				loadTextFileContent();
			}
		}
		
		private function loadByteFile():void
		{
			_loader = new URLStream();
			_byte_content = new ByteArray();
			//_byte_content.endian = Endian.BIG_ENDIAN;
			_loader.addEventListener(Event.COMPLETE, byteFileLoaded);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, byteFileIOError);
			_loader.load(new URLRequest(_url));
		}
		
		private function byteFileIOError(e:IOErrorEvent):void 
		{
			trace("CANNOT LOAD " + _name);
		}
		
		private function byteFileLoaded(e:Event):void 
		{
			_loader.removeEventListener(Event.COMPLETE, byteFileLoaded);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, byteFileIOError);
			trace("File contents LOADED for " + _name);
			
			_loader.readBytes(_byte_content, 0, _loader.bytesAvailable);
			createByteFile();
		}
		
		private function createByteFile():void
		{
			var file:File = new File();
			file.url = _dir;
			file = file.resolvePath(_name);
			
			trace('the file ext : ' + _file_ext);
			switch (_file_ext) 
			{
				case 'docx':
				case 'pptx':
				case 'xlsx':
					//trace("WRITE A MICROSOFT FILE : " + _file_ext);
					var mx:MicrosoftXModel = new MicrosoftXModel(file, _byte_content);
					mx.addEventListener(FileEvent.FILE_CREATED, mx_fileCreated);
					break;
				
				default:
					var fs:FileStream = new FileStream();
					fs.open(file, FileMode.WRITE);
					fs.writeBytes(_byte_content);
					fs.close();
					
					complete();
					break;
			}
		}
		
		private function mx_fileCreated(e:FileEvent):void 
		{
			//(e.currentTarget as MicrosoftX).removeEventListener(FileEvent.FILE_CREATED, mx_fileCreated);
			complete();
		}
		
		/**
		 * Text Based File
		 */
		private function loadTextFileContent():void
		{
			trace("Load file contents for " + _name);
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, textFileLoaded);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, urlLoader_progress);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.load(new URLRequest(_url));
		}
		
		private function urlLoader_progress(e:ProgressEvent):void 
		{
			trace(e.bytesLoaded / e.bytesTotal);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace("Error loading text file");
			//TODO add to log file
			complete();
		}
		
		private function textFileLoaded(e:Event):void
		{
			_urlLoader.removeEventListener(Event.COMPLETE, textFileLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			trace("File contents LOADED for " + _name);
			_file_content = e.currentTarget.data as String;
			createTextFile();
		}
		
		private function createTextFile():void
		{
			//_file_content = CustomVars.getInstance().addVariables(_file_content);
			
			var file:File = new File();
			file.url = _dir;
			file = file.resolvePath(_name);
			
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			//fs.writeUTFBytes(CustomVariables.getInstance().updateVars(_file_content));
			fs.writeUTFBytes(_file_content);
			fs.close();
			
			complete();
		}
		
		private function complete():void 
		{
			trace(_name, 'created');
			_loader = null;
			_urlLoader = null;
			
			//setTimeout(function() { dispatchEvent(new FileEvent(FileEvent.FILE_CREATED)); }, 100);
			dispatchEvent(new FileEvent(FileEvent.FILE_CREATED));
		}
	}
}