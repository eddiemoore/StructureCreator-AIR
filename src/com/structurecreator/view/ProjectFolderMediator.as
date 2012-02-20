package com.structurecreator.view
{
	import com.structurecreator.events.ProjectFolderEvent;
	import com.structurecreator.model.ProjectFolderModel;
	
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
		
		/**
		 * On folder selected update the text of the project field
		 */
		private function onProjectFolderSelected(e:ProjectFolderEvent):void
		{
			view.projectFolderTI.text = model.projectFolder.nativePath;
		}
		
		/**
		 * On Click call the model to open the directory selector
		 */
		private function onClick(e:MouseEvent):void
		{
			model.selectProjectFolder();
		}
	}
}