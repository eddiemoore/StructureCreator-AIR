package com.structurecreator.view.saveprofile
{
	import com.structurecreator.events.ProfileEvent;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SaveProfileWindowMediator extends Mediator
	{
		[Inject]
		public var view:SaveProfileWindow;
		
		public function SaveProfileWindowMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			trace("Save Profile Window registered");
			view.saveBtn.addEventListener(MouseEvent.CLICK, onSaveClick);
			
			view.profile_name.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if (event.keyCode == Keyboard.ENTER) 
			{
				view.saveBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
		}
		
		/**
		 * On Save Click dispatch the name of the profile
		 */
		protected function onSaveClick(event:MouseEvent):void
		{
			if (view.profile_name.text != '')
			{
				trace("dispatch profile name");
				eventDispatcher.dispatchEvent(new ProfileEvent(ProfileEvent.SAVE_PROFILE, view.profile_name.text));
			}
		}
	}
}