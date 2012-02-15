package com.structurecreator
{
	import com.structurecreator.events.StructureCreatorEvent;
	import com.structurecreator.model.CustomVariableModel;
	import com.structurecreator.model.ProjectFolderModel;
	import com.structurecreator.model.SchemaModel;
	import com.structurecreator.model.StructureCreatorModel;
	import com.structurecreator.model.files.FileCreatorModel;
	import com.structurecreator.model.schemas.XMLSchema;
	import com.structurecreator.services.FileCreateService;
	import com.structurecreator.view.CreateButton;
	import com.structurecreator.view.CreateButtonMediator;
	import com.structurecreator.view.CustomVariablesMediator;
	import com.structurecreator.view.CustomVariablesView;
	import com.structurecreator.view.ProjectFolderMediator;
	import com.structurecreator.view.ProjectFolderView;
	import com.structurecreator.view.SchemaSelectMediator;
	import com.structurecreator.view.SchemaSelectView;
	import com.structurecreator.view.customvars.CustomVariableBarMediator;
	import com.structurecreator.view.customvars.CustomVariableBarView;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.controls.Alert;
	
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
			injector.mapSingleton(XMLSchema);
			injector.mapSingleton(StructureCreatorModel);
			injector.mapSingleton(CustomVariableModel);
			
			injector.mapClass(FileCreateService, FileCreateService);
			
			mediatorMap.mapView(ProjectFolderView, ProjectFolderMediator);
			mediatorMap.mapView(SchemaSelectView, SchemaSelectMediator);
			mediatorMap.mapView(CreateButton, CreateButtonMediator);
			mediatorMap.mapView(CustomVariablesView, CustomVariablesMediator);
			mediatorMap.mapView(CustomVariableBarView, CustomVariableBarMediator);
			
			eventDispatcher.addEventListener(StructureCreatorEvent.CREATION_COMPLETE, onCreationComplete);
			
			super.startup();
		}
		
		private function onCreationComplete(event:Event):void
		{
			Alert.show("All the files and folders have been created.", "All Done!");
		}
	}
}