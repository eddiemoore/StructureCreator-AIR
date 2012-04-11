package com.structurecreator.events
{
	import flash.events.Event;
	
	public class CustomVarsEvent extends Event
	{
		public static var CUSTOM_VAR_ADDED:String = 'customVarAdded';
		public static var CANNOT_ADD_VAR:String = 'cannotAddVar';
		
		public function CustomVarsEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new CustomVarsEvent(type);
		}
	}
}