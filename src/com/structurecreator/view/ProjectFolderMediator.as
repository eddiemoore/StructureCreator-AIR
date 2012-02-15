package com.structurecreator.view
{
	import com.structurecreator.events.ProjectFolderEvent;
	import com.structurecreator.model.ProjectFolderModel;
	import com.structurecreator.model.StructureCreatorModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ProjectFolderMediator extends Mediator
	{
		[Inject]
		public var view:ProjectFolderView;
		
		[Inject]
		public var model:ProjectFolderModel;
		
		public function ProjectFolderMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.browse, MouseEvent.CLICK, onClick);
			eventMap.mapListener(eventDispatcher, ProjectFolderEvent.PROJECT_FOLDER_SELECTED, onProjectFolderSelected);
		}
		
		private function onProjectFolderSelected(e:ProjectFolderEvent):void
		{
			view.projectFolderTI.text = model.projectFolder.nativePath;
		}
		
		private function onClick(e:MouseEvent):void
		{
			model.selectProjectFolder();
		}
	}
}