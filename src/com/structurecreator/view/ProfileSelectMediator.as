package com.structurecreator.view
{
	import com.structurecreator.events.DatabaseEvent;
	import com.structurecreator.services.DatabaseService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class ProfileSelectMediator extends Mediator
	{
		[Inject]
		public var view:ProfileSelect;
		
		[Inject]
		public var model:DatabaseService;
		
		public function ProfileSelectMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, Event.CHANGE, onChange);
			eventDispatcher.addEventListener(DatabaseEvent.DATABASE_UPDATED, onDatabaseUpdated);
		}
		
		private function onDatabaseUpdated(e:DatabaseEvent):void
		{
			
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