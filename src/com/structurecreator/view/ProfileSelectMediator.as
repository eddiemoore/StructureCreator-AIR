package com.structurecreator.view
{
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class ProfileSelectMediator extends Mediator
	{
		[Inject]
		public var view:ProfileSelect;
		
		public function ProfileSelectMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, Event.CHANGE, onChange);
		}
		
		/**
		 * On profile combobox change update everything
		 */
		protected function onChange(event:IndexChangeEvent):void
		{
			trace("Profile Select Box Change");
		}
	}
}