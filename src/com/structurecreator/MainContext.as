package com.structurecreator
{
	import com.structurecreator.model.ProjectFolderModel;
	import com.structurecreator.model.SchemaModel;
	import com.structurecreator.view.CreateButton;
	import com.structurecreator.view.CreateButtonMediator;
	import com.structurecreator.view.ProjectFolderMediator;
	import com.structurecreator.view.ProjectFolderView;
	import com.structurecreator.view.SchemaSelectMediator;
	import com.structurecreator.view.SchemaSelectView;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context
	{
		public function MainContext()
		{
		}
		
		override public function startup():void
		{
			trace("App Started");
			injector.mapSingleton(ProjectFolderModel);
			injector.mapSingleton(SchemaModel);
			
			mediatorMap.mapView(ProjectFolderView, ProjectFolderMediator);
			mediatorMap.mapView(SchemaSelectView, SchemaSelectMediator);
			mediatorMap.mapView(CreateButton, CreateButtonMediator);
			
			super.startup();
		}
	}
}