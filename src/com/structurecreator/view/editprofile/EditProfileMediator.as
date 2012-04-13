package com.structurecreator.view.editprofile
{
	import com.structurecreator.events.DatabaseEvent;
	import com.structurecreator.services.DatabaseService;
	import com.structurecreator.services.ProfileService;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditProfileMediator extends Mediator
	{
		[Inject]
		public var view:EditProfileView;
		
		[Inject]
		public var model:DatabaseService;
		
		[Inject]
		public var profileService:ProfileService;
		
		[Bindable]
		private var provider:ArrayCollection;
		
		public function EditProfileMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.deleteBtn, MouseEvent.CLICK, onDeleteBtnClick);
			eventMap.mapListener(view.exportBtn, MouseEvent.CLICK, onExportBtnClick);
			
			eventDispatcher.addEventListener(DatabaseEvent.DATABASE_UPDATED, onDatabaseUpdated);
			
			getAllProfiles();
		}
		
		/**
		 * When database is updated, update view
		 */
		private function onDatabaseUpdated(e:DatabaseEvent):void
		{
			getAllProfiles();
		}
		
		/**
		 * Get all the Profiles
		 */
		private function getAllProfiles():void
		{
			var profiles:Array = model.selectAllProfiles();
			provider = new ArrayCollection();
			if (profiles && profiles.length > 0)
			{
				view.enabled = true;
				
				
				//provider = new ArrayCollection();
				for (var i:uint = 0; i < profiles.length; i++)
				{
					trace(profiles[i].name);
					provider.addItem( { label:profiles[i].name, data:profiles[i].profile_id } );
				}
			}
			else
				view.enabled = false;
			
			view.profileList.dataProvider = provider;
		}
		
		/**
		 * Export Button Clicked
		 */
		private function onExportBtnClick(e:MouseEvent):void
		{
			if (view.profileList.selectedIndex > -1)
			{
				var selected:Object = provider[view.profileList.selectedIndex];
				
				profileService.exportProfile(selected.data);
			}
			else
			{
				Alert.show("Please select a profile to export", "Error", 4, view);
			}
		}
		
		/**
		 * Delete Button Clicked
		 */
		private function onDeleteBtnClick(e:MouseEvent):void
		{
			//get selected item from list
			if (view.profileList.selectedIndex > -1)
			{
				var selected:Object = provider[view.profileList.selectedIndex];
				
				model.deleteProfile(selected.data);
			}
			else
			{
				Alert.show("Please select a profile to delete", "Error", 4, view);
			}
			//trace(selected);
		}
	}
}