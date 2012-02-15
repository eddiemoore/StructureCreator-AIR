package com.structurecreator.view
{
	import com.structurecreator.events.SchemaEvent;
	import com.structurecreator.model.StructureCreatorModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SchemaSelectMediator extends Mediator
	{
		[Inject]
		public var view:SchemaSelectView;
		
		[Inject]
		public var model:StructureCreatorModel;
		
		public function SchemaSelectMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.browse, MouseEvent.CLICK, onClick);
			eventMap.mapListener(eventDispatcher, SchemaEvent.SCHEMA_SELECTED, onSchemaSelected);
		}
		
		private function onSchemaSelected(e:SchemaEvent):void
		{
			view.schemaTI.text = model.schemaFile.nativePath;
		}
		
		private function onClick(e:MouseEvent):void
		{
			model.selectSchemaFile();
		}
	}
}