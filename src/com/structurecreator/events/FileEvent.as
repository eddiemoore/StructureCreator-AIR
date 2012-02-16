package com.structurecreator.events
{
	import com.structurecreator.services.vo.FileDetailsVO;
	
	import flash.events.Event;
	
	public class FileEvent extends Event
	{
		public static const START_CREATION:String = 'startCreation';
		public static const FILE_CREATED:String = 'fileCreated';
		
		private var _fileDeatailsVO:FileDetailsVO;
		
		public function FileEvent(type:String, fileDetailsVO:FileDetailsVO=null)
		{
			super(type);
			_fileDeatailsVO = fileDetailsVO;
		}
		
		override public function clone():Event
		{
			return new FileEvent(type);
		}

		public function get fileDeatailsVO():FileDetailsVO
		{
			return _fileDeatailsVO;
		}

	}
}