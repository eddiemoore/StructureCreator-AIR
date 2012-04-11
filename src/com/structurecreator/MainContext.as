package com.structurecreator
{
	import com.structurecreator.controller.DatabaseCommand;
	import com.structurecreator.controller.FileCommand;
	import com.structurecreator.controller.ProfileCommand;
	import com.structurecreator.events.FileEvent;
	import com.structurecreator.events.ProfileEvent;
	import com.structurecreator.events.StructureCreatorEvent;
	import com.structurecreator.model.CustomVariableModel;
	import com.structurecreator.model.ProjectFolderModel;
	import com.structurecreator.model.SchemaModel;
	import com.structurecreator.model.StructureCreatorModel;
	import com.structurecreator.model.schemas.XMLSchema;
	import com.structurecreator.services.DatabaseService;
	import com.structurecreator.services.FileCreateService;
	import com.structurecreator.services.MicrosoftXFileService;
	import com.structurecreator.view.CreateButton;
	import com.structurecreator.view.CreateButtonMediator;
	import com.structurecreator.view.CustomVariablesMediator;
	import com.structurecreator.view.CustomVariablesView;
	import com.structurecreator.view.ProfileButtons;
	import com.structurecreator.view.ProfileButtonsMediator;
	import com.structurecreator.view.ProfileSelect;
	import com.structurecreator.view.ProfileSelectMediator;
	import com.structurecreator.view.ProjectFolderMediator;
	import com.structurecreator.view.ProjectFolderView;
	import com.structurecreator.view.SchemaSelectMediator;
	import com.structurecreator.view.SchemaSelectView;
	import com.structurecreator.view.customvars.CustomVariableBarMediator;
	import com.structurecreator.view.customvars.CustomVariableBarView;
	import com.structurecreator.view.saveprofile.SaveProfileWindow;
	import com.structurecreator.view.saveprofile.SaveProfileWindowMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context
	{

		private var _saveProfileWindow:SaveProfileWindow;
		public function MainContext()
		{
		}
		
		override public function startup():void
		{
			trace("App Started");
			/* Setup models */
			injector.mapSingleton(ProjectFolderModel);
			injector.mapSingleton(SchemaModel);
			injector.mapSingleton(XMLSchema);
			injector.mapSingleton(StructureCreatorModel);
			injector.mapSingleton(CustomVariableModel);
			injector.mapSingleton(DatabaseService);
			
			/* Setup File Creation Services */
			injector.mapClass(FileCreateService, FileCreateService);
			//var fcs:FileCreateService = injector.getInstance(FileCreateService);
			//injector.mapValue(FileCreateService, fcs);
			injector.mapClass(MicrosoftXFileService, MicrosoftXFileService);
			
			/* Map views to their mediators */
			mediatorMap.mapView(ProfileSelect, ProfileSelectMediator);
			mediatorMap.mapView(ProjectFolderView, ProjectFolderMediator);
			mediatorMap.mapView(SchemaSelectView, SchemaSelectMediator);
			mediatorMap.mapView(CreateButton, CreateButtonMediator);
			mediatorMap.mapView(CustomVariablesView, CustomVariablesMediator);
			mediatorMap.mapView(CustomVariableBarView, CustomVariableBarMediator);
			mediatorMap.mapView(ProfileButtons, ProfileButtonsMediator);
			mediatorMap.mapView(SaveProfileWindow, SaveProfileWindowMediator);
			
			/* Commands for file creation */
			commandMap.mapEvent(FileEvent.START_CREATION, FileCommand, FileEvent);
			commandMap.mapEvent(StructureCreatorEvent.APP_STARTED, DatabaseCommand, StructureCreatorEvent);
			commandMap.mapEvent(ProfileEvent.SAVE_PROFILE, ProfileCommand, ProfileEvent);
			
			/* Listen for creation complete event */
			eventDispatcher.addEventListener(StructureCreatorEvent.CREATION_COMPLETE, onCreationComplete);
			eventDispatcher.dispatchEvent(new StructureCreatorEvent(StructureCreatorEvent.APP_STARTED));
			eventDispatcher.addEventListener(ProfileEvent.OPEN_SAVE_WINDOW, onOpenSaveProfile);
			eventDispatcher.addEventListener(ProfileEvent.SAVE_PROFILE, onSaveProfile);
			
			super.startup();
		}
		
		/**
		 * Opens Save Profile window
		 */
		private function onOpenSaveProfile(e:ProfileEvent):void
		{
			_saveProfileWindow = new SaveProfileWindow();
			
			PopUpManager.addPopUp(_saveProfileWindow, _contextView, true);
			PopUpManager.centerPopUp(_saveProfileWindow);
			
			mediatorMap.createMediator(_saveProfileWindow);
		}
		
		/**
		 * When profile is saved Close the window
		 */
		private function onSaveProfile(e:ProfileEvent):void
		{
			PopUpManager.removePopUp(_saveProfileWindow);
		}
		
		/**
		 * On Creation Complete
		 * Show that all files have been created
		 */
		private function onCreationComplete(event:Event):void
		{
			Alert.show("All the files and folders have been created.", "All Done!");
		}
	}
}