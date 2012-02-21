package com.structurecreator.events
{
	import flash.events.Event;
	
	public class ProfileEvent extends Event
	{
		public static const OPEN_SAVE_WINDOW:String = 'openSaveWindow';
		public static const SAVE_PROFILE:String = 'saveProfile';
		public static const PROFILE_CHANGED:String = 'profileChanged';

		private var _name:String;
		
		public function ProfileEvent(type:String, name:String='')
		{
			super(type);
			_name = name;
		}
		
		override public function clone():Event
		{
			return new ProfileEvent(type);
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}