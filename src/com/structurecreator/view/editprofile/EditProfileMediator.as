package com.structurecreator.view.editprofile
{
	import com.structurecreator.events.DatabaseEvent;
	import com.structurecreator.services.DatabaseService;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditProfileMediator extends Mediator
	{
		[Inject]
		public var view:EditProfileView;
		
		[Inject]
		public var model:DatabaseService;
		
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
		}
		
		private function onDatabaseUpdated(e:DatabaseEvent):void
		{
			getAllProfiles();
		}
		
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
		
		private function onExportBtnClick(e:MouseEvent):void
		{
			
		}
		
		private function onDeleteBtnClick(e:MouseEvent):void
		{
			//get selected item from list
			var selected:int = view.profileList.selectedIndex;
			
		}
	}
}