package com.structurecreator
{
	import com.structurecreator.view.CreateButton;
	import com.structurecreator.view.CreateButtonMediator;
	import com.structurecreator.view.ProjectFolderButton;
	import com.structurecreator.view.ProjectFolderButtonMediator;
	import com.structurecreator.view.SchemaButton;
	import com.structurecreator.view.SchemaButtonMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context
	{
		public function MainContext()
		{
			super();
		}
		
		override public function startup():void
		{
			trace("App Started");
			
			//mediatorMap.mapView(ProjectFolderButton, ProjectFolderButtonMediator);
			mediatorMap.mapView(SchemaButton, SchemaButtonMediator);
			mediatorMap.mapView(CreateButton, CreateButtonMediator);
			
			super.startup();
		}
	}
}