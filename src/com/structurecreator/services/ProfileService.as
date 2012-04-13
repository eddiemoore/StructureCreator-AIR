package com.structurecreator.services
{
	import org.robotlegs.mvcs.Actor;
	
	public class ProfileService extends Actor
	{
		[Inject]
		public var db:DatabaseService;
		
		public function ProfileService()
		{
		}
		
		public function exportProfile(id:int):void
		{
			var profile:Array = db.selectProfile(id);
			var custVars:Array = db.selectAllCustomVars(id);
			
			trace(profile);
			for (var i:int =0; i < profile.length; i++)
			{
				trace(profile[i].name);
				//name
				trace(profile[i].schema_file);
				//schema_file
				trace(profile[i].isDefault);
				//isDefault
			}
		}
	}
}