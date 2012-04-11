package com.schemacreator.model
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FolderBrowse extends Actor
	{
		public function FolderBrowse()
		{
			
		}
		
		public function browseForFolder():void
		{
			var file:File = new File();
			file.addEventListener(Event.SELECT, onFolderSelect);
			file.browseForDirectory("Select Schema Folder");
		}
		
		protected function onFolderSelect(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}