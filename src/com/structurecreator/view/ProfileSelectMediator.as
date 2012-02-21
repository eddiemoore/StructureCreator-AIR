package com.structurecreator.view
{
	import com.structurecreator.events.DatabaseEvent;
	import com.structurecreator.events.ProfileEvent;
	import com.structurecreator.services.DatabaseService;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.ComboBox;
	import spark.events.IndexChangeEvent;
	
	public class ProfileSelectMediator extends Mediator
	{
		[Inject]
		public var view:ProfileSelect;
		
		[Inject]
		public var model:DatabaseService;
		
		[Bindable]
		private var provider:ArrayCollection;
		
		public function ProfileSelectMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, Event.CHANGE, onChange);
			eventDispatcher.addEventListener(DatabaseEvent.DATABASE_UPDATED, onDatabaseUpdated);
			updateProfiles();
		}
		
		private function onDatabaseUpdated(e:DatabaseEvent):void
		{
			updateProfiles();
		}
		
		private function updateProfiles():void
		{
			var profiles:Array = model.selectAllProfiles();
			//trace(profiles[0].name);
			
			if (profiles.length > 0)
				view.enabled = true;
			else
				view.enabled = false;
			
			provider = new ArrayCollection();
			for (var i:uint = 0; i < profiles.length; i++)
			{
				trace(profiles[i].name);
				provider.addItem( { label:profiles[i].name, data:profiles[i].profile_id } );
			}
			view.dataProvider = provider;
		}
		
		/**
		 * On profile combobox change update everything
		 */
		protected function onChange(event:IndexChangeEvent):void
		{
			trace("Profile Select Box Change");
			eventDispatcher.dispatchEvent(new ProfileEvent(ProfileEvent.PROFILE_CHANGED, String(view.selectedItem.data)));
		}
	}
}