package com.schemacreator.view
{
	import com.schemacreator.model.FolderBrowse;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class DirectorySelectMediator extends Mediator
	{
		[Inject]
		public var view:DirectorySelectView;
		
		[Inject]
		public var model:FolderBrowse;
		
		public function DirectorySelectMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.browseBtn, MouseEvent.CLICK, browseForFolder);
		}
		
		private function browseForFolder(e:MouseEvent):void
		{
			model.browseForFolder();
		}
	}
}