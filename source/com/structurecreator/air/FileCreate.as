﻿package com.structurecreator.air{	import com.structurecreator.air.files.DocX;	import flash.display.BitmapData;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.filesystem.File;	import flash.filesystem.FileMode;	import flash.filesystem.FileStream;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.net.URLStream;	import flash.text.TextField;	import fl.controls.TextArea;	import flash.utils.ByteArray;	//import flash.utils.Endian;	/**	 * ...	 * @author Ed Moore	 */	public class FileCreate	{		private var _dir:String;		private var _url:String;		private var _name:String;		private var _file_content:String;		private var _byte_content:ByteArray;				private var _loader:URLStream;		private var _urlLoader:URLLoader;		private var _file_ext:String;				public function FileCreate(dir:String, name:String = '', url:String = '', file_content:String = ''/*, quality:uint = 80*/) 		{			_dir = dir;			_url = url;			_name = name;			_file_content = file_content;						_file_ext = (_name.split('.')[1] as String).toLowerCase();						CaptainsLog.getInstance().addToLog("File name: " + _name + " : " + _file_ext);						if (_url == '')			{				//Text file from content in XML				createTextFile();			}			else if (FileTypes.nonTextExtArray.indexOf(_file_ext) > -1)			{				loadByteFile();			} 			else			{				//Text file from URL				loadTextFileContent();			}						}				private function loadByteFile():void		{			_loader = new URLStream();			_byte_content = new ByteArray();			//_byte_content.endian = Endian.BIG_ENDIAN;			_loader.addEventListener(Event.COMPLETE, byteFileLoaded);			_loader.addEventListener(IOErrorEvent.IO_ERROR, byteFileIOError);			_loader.load(new URLRequest(_url));		}				private function byteFileIOError(e:IOErrorEvent):void 		{			CaptainsLog.getInstance().addToLog("CANNOT LOAD " + _name);		}				private function byteFileLoaded(e:Event):void 		{			_loader.removeEventListener(Event.COMPLETE, byteFileLoaded);			_loader.removeEventListener(IOErrorEvent.IO_ERROR, byteFileIOError);			CaptainsLog.getInstance().addToLog("File contents LOADED for " + _name);						_loader.readBytes(_byte_content, 0, _loader.bytesAvailable);			createByteFile();		}				private function createByteFile():void		{			var file:File = new File();			file.url = _dir;			file = file.resolvePath(_name);						if (_file_ext == 'docx')			{				new DocX(file, _byte_content);			}			else			{				var fs:FileStream = new FileStream();				fs.open(file, FileMode.WRITE);				fs.writeBytes(_byte_content);				fs.close();			}		}				/**		 * Text Based File		 */		private function loadTextFileContent():void		{			CaptainsLog.getInstance().addToLog("Load file contents for " + _name);			_urlLoader = new URLLoader();			_urlLoader.addEventListener(Event.COMPLETE, textFileLoaded);			_urlLoader.load(new URLRequest(_url));		}				private function textFileLoaded(e:Event):void		{			_urlLoader.removeEventListener(Event.COMPLETE, textFileLoaded);			CaptainsLog.getInstance().addToLog("File contents LOADED for " + _name);			_file_content = e.currentTarget.data as String;			createTextFile();		}				private function createTextFile():void		{			_file_content = CustomVars.getInstance().addVariables(_file_content);						var file:File = new File();			file.url = _dir;			file = file.resolvePath(_name);						var fs:FileStream = new FileStream();			fs.open(file, FileMode.WRITE);			fs.writeUTFBytes(_file_content);			fs.close();		}			}}