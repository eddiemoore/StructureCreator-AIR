package com.structurecreator.controller
{
	import com.structurecreator.events.ProfileEvent;
	import com.structurecreator.services.DatabaseService;
	
	import org.robotlegs.mvcs.Command;
	
	public class ProfileCommand extends Command
	{
		[Inject]
		public var event:ProfileEvent;
		
		[Inject]
		public var service:DatabaseService;
		
		public function ProfileCommand()
		{
			//super();
		}
		
		/**
		 * Initialises the creation of a new file
		 */
		override public function execute():void
		{
			trace("Add the profile");
			service.addProfile(event.name, event.schema_url);
		}
	}
}