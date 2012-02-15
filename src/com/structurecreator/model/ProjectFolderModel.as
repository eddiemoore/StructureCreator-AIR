package com.structurecreator.model
{
	import com.structurecreator.events.ProjectFolderEvent;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ProjectFolderModel extends Actor
	{
		private var _projectFolder:File = File.documentsDirectory;
		
		public function ProjectFolderModel()
		{
			
		}
		
		public function get projectFolder():File
		{
			return _projectFolder;
		}
		
		public function selectProjectFolder():void
		{
			projectFolder.browseForDirectory("Select Project Folder");
			projectFolder.addEventListener(Event.SELECT, onProjectFolderSelected);
		}
		
		protected function onProjectFolderSelected(event:Event):void
		{
			eventDispatcher.dispatchEvent(new ProjectFolderEvent(ProjectFolderEvent.PROJECT_FOLDER_SELECTED));
		}
	}
}