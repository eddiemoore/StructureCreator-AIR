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
		public static const FOUND_PROFILES:String = 'foundProfiles';
		public static const PROFILE_ADDED:String = 'profileAdded';
		static public const FOUND_SINGLE_PROFILE:String = "foundSingleProfile";
		static public const FOUND_SCHEMA_URL:String = "foundSchemaUrl";
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