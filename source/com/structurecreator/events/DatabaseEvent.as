package com.structurecreator.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class DatabaseEvent extends Event 
	{
		public static const DB_CREATED:String = 'dbCreated';
		public static const GOT_PROFILES:String = 'gotProfiles';
		public static const PROFILE_ADDED:String = 'profileAdded';
		private var _result:Array;
		
		public function DatabaseEvent(type:String, result:Array=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_result = result;
		} 
		
		public override function clone():Event 
		{ 
			return new DatabaseEvent(type, result, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DatabaseEvent", "type", "result", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get result():Array 
		{
			return _result;
		}
		
	}
	
}