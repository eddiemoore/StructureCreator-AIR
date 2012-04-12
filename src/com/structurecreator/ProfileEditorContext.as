package com.structurecreator
{
	import com.structurecreator.model.CustomVariableModel;
	import com.structurecreator.model.SchemaModel;
	import com.structurecreator.services.DatabaseService;
	import com.structurecreator.view.editprofile.EditProfileMediator;
	import com.structurecreator.view.editprofile.EditProfileView;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class ProfileEditorContext extends Context
	{
		public function ProfileEditorContext()
		{
		}
		
		override public function startup():void
		{
			injector.mapSingleton(CustomVariableModel);
			injector.mapSingleton(DatabaseService);
			
			mediatorMap.mapView(EditProfileView, EditProfileMediator);
		}
	}
}