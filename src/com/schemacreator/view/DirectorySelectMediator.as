package com.schemacreator.view
{
	import com.schemacreator.events.SchemaEvent;
	import com.schemacreator.model.SchemaModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class DirectorySelectMediator extends Mediator
	{
		[Inject]
		public var view:DirectorySelectView;
		
		[Inject]
		public var model:SchemaModel;
		
		public function DirectorySelectMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.browseBtn, MouseEvent.CLICK, browseForFolder);
			eventMap.mapListener(eventDispatcher, SchemaEvent.FOLDER_SELECTED, onFolderSelected);
		}
		
		private function onFolderSelected(e:SchemaEvent):void
		{
			view.directoryField.text = model.projectFolder.nativePath;
		}
		
		private function browseForFolder(e:MouseEvent):void
		{
			model.browseForFolder();
		}
	}
}