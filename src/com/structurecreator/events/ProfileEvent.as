package com.structurecreator.events
{
	import flash.events.Event;
	
	public class ProfileEvent extends Event
	{
		public static const OPEN_SAVE_WINDOW:String = 'openSaveWindow';
		public static const SAVE_PROFILE:String = 'saveProfile';
		public static const PROFILE_SELECTED:String = 'profileSelected';
		public static const EDIT_PROFILES:String = 'editProfile';

		private var _name:String;
		private var _schema_url:String;

		
		public function ProfileEvent(type:String, name:String='', schema_url:String='')
		{
			super(type);
			_name = name;
			trace("Event", schema_url);
			_schema_url = schema_url;
		}
		
		override public function clone():Event
		{
			return new ProfileEvent(type);
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get schema_url():String
		{
			return _schema_url;
		}
	}
}