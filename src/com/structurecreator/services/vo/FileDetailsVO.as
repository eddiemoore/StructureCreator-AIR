package com.structurecreator.services.vo
{
	public class FileDetailsVO
	{
		private var _dir:String;
		private var _name:String;
		private var _url:String;
		private var _file_content:String;
		
		public function FileDetailsVO()
		{
		}

		public function get dir():String
		{
			return _dir;
		}

		public function set dir(value:String):void
		{
			_dir = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

		public function get file_content():String
		{
			return _file_content;
		}

		public function set file_content(value:String):void
		{
			_file_content = value;
		}


	}
}