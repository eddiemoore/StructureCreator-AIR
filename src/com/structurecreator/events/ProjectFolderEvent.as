package com.structurecreator.events
{
	import flash.events.Event;
	
	public class ProjectFolderEvent extends Event
	{
		public static const PROJECT_FOLDER_SELECTED:String = "projectFolderSelected";
		
		public function ProjectFolderEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new ProjectFolderEvent(type);
		}
	}
}