package com.structurecreator.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class FileEvent extends Event 
	{
		public static const FILE_CREATED:String = 'fileCreated';
		
		public function FileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FileEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FileEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}