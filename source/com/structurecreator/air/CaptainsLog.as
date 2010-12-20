package com.structurecreator.air
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import fl.controls.TextArea;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CaptainsLog 
	{
		private static var _instance:CaptainsLog = null;
		private var _log:String = '';
		private var _logField:TextArea;
		private var date:Date;
		
		public function CaptainsLog(e:Singleton) {}
		
		public function addToLog(text:String):void
		{
			date = new Date();
			_log += date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate() + ' ';
			_log += (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':' + (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':' + (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds()) + ' : ';
			_log += text + "\r\n";
			updateLogField();
		}
		
		public function initLogField(field:TextArea):void
		{
			_logField = field;
		}
		
		public function updateLogField():void
		{
			if (_logField)
				_logField.htmlText = _log;
		}
		
		public static function getInstance():CaptainsLog 
		{
            if(_instance==null)	_instance=new CaptainsLog(new Singleton());
            return _instance;
        }
		
		public function writeToFile():void 
		{
			trace("WRITE TO FILE");
			//var logFile:File = File.applicationStorageDirectory;
			var logFile:File = File.desktopDirectory;
			logFile = logFile.resolvePath("logs/CaptainsLog.txt");
			
			var fs:FileStream = new FileStream();
			fs.open(logFile, FileMode.UPDATE);
			
			fs.writeUTFBytes(_log);
			fs.close();
		}
		
	}
	
}

class Singleton{}