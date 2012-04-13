package com.structurecreator.controller
{
	import com.structurecreator.events.ProfileChangeEvent;
	import com.structurecreator.events.ProfileEvent;
	import com.structurecreator.services.DatabaseService;
	
	import org.robotlegs.mvcs.Command;
	
	public class ProfileChangeCommand extends Command
	{
		[Inject]
		public var event:ProfileEvent;
		
		[Inject]
		public var service:DatabaseService;
		
		public function ProfileChangeCommand()
		{
			//super();
		}
		
		/**
		 * Initialises the creation of a new file
		 */
		override public function execute():void
		{
			//trace("Add the profile");
			//service.addProfile(event.name, event.schema_url);
			trace(int(event.name));
			var profile:Array = service.selectProfile(int(event.name));
			eventDispatcher.dispatchEvent(new ProfileChangeEvent(ProfileChangeEvent.PROFILE_CHANGED, profile));
		}
	}
}