package com.structurecreator.model
{
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ProjectFolderModel extends Actor
	{
		private var _projectFolder:File;
		
		public function ProjectFolderModel()
		{
		}
		
		public function get projectFolder():File
		{
			return _projectFolder;
		}
		
		public function set projectFolder(folder:File):void
		{
			_projectFolder = folder;
		}
	}
}