package com.structurecreator.air.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVarEvent extends Event 
	{
		public static const REMOVE:String = 'remove';
		
		public function CustomVarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
	}
	
}