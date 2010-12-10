package com.asfug 
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import fl.controls.TextArea;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CaptainsLog 
	{
		private static var _instance:CaptainsLog = null;
		private var _log:String = '';
		private var _logField:TextArea;
		
		public function CaptainsLog(e:Singleton) {}
		
		public function addToLog(text:String):void
		{
			_log += text + "\n";
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
		
	}
	
}

class Singleton{}