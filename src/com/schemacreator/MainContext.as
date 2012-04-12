package com.schemacreator
{
	
	import com.schemacreator.events.SchemaEvent;
	import com.schemacreator.model.SchemaModel;
	import com.schemacreator.view.CreateSchemaBtnMediator;
	import com.schemacreator.view.CreateSchemaBtnView;
	import com.schemacreator.view.DirectorySelectMediator;
	import com.schemacreator.view.DirectorySelectView;
	
	import mx.controls.Alert;
	
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context
	{
		public function MainContext()
		{
		}
		
		override public function startup():void
		{
			injector.mapSingleton(SchemaModel);
			
			mediatorMap.mapView(DirectorySelectView, DirectorySelectMediator);
			mediatorMap.mapView(CreateSchemaBtnView, CreateSchemaBtnMediator); 
			
			eventDispatcher.addEventListener(SchemaEvent.SCHEMA_CREATED, onSchemaCreated);
			
			super.startup();
		}
		
		private function onSchemaCreated(e:SchemaEvent):void
		{
			trace("Schema Created");
			Alert.show("Your schema has been created", "Schema Created"); 
		}
	}
}