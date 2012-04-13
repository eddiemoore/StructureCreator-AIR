package com.structurecreator.events
{
	import flash.events.Event;
	
	public class ProfileChangeEvent extends Event
	{
		public static const PROFILE_CHANGED:String = 'profileChanged';
		
		private var _profile:Array;
		
		public function ProfileChangeEvent(type:String, profile:Array)
		{
			super(type);
			_profile = profile;
		}
		
		override public function clone():Event
		{
			return new ProfileChangeEvent(type, _profile);
		}
		
		
		public function get profile():Array
		{
			return _profile;
		}

	}
}