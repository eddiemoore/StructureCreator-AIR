package com.structurecreator.view
{
	import com.structurecreator.events.ProfileEvent;
	import com.structurecreator.events.SchemaEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ProfileButtonsMediator extends Mediator
	{
		[Inject]
		public var view:ProfileButtonsView;
		
		public function ProfileButtonsMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.saveBtn, MouseEvent.CLICK, onSaveClick);
			eventMap.mapListener(view.createSchemaBtn, MouseEvent.CLICK, onCreateSchemaBtnClick);
		}
		
		private function onCreateSchemaBtnClick(e:MouseEvent):void
		{
			eventDispatcher.dispatchEvent(new SchemaEvent(SchemaEvent.CREATE_NEW_SCHEMA));
		}
		
		/**
		 * On Save button Clicked
		 */
		private function onSaveClick(e:MouseEvent):void
		{
			eventDispatcher.dispatchEvent(new ProfileEvent(ProfileEvent.OPEN_SAVE_WINDOW));
		}
	}
}