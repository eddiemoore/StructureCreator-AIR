package com.structurecreator.view
{
	import com.structurecreator.events.ProfileEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ProfileButtonsMediator extends Mediator
	{
		[Inject]
		public var view:ProfileButtons;
		
		public function ProfileButtonsMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.saveBtn, MouseEvent.CLICK, onSaveClick);
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