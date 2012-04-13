package com.structurecreator.view
{
	import com.structurecreator.events.ProfileChangeEvent;
	import com.structurecreator.events.ProfileEvent;
	import com.structurecreator.events.SchemaEvent;
	import com.structurecreator.model.SchemaModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SchemaSelectMediator extends Mediator
	{
		[Inject]
		public var view:SchemaSelectView;
		
		[Inject]
		public var model:SchemaModel;
		
		public function SchemaSelectMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.browse, MouseEvent.CLICK, onClick);
			eventMap.mapListener(eventDispatcher, SchemaEvent.SCHEMA_SELECTED, onSchemaSelected);
			
			eventDispatcher.addEventListener(ProfileChangeEvent.PROFILE_CHANGED, onProfileChanged);
		}
		
		private function onProfileChanged(e:ProfileChangeEvent):void
		{
			//trace("Schema URL", e.schema_url);
			for (var i:int=0; i < e.profile.length; i++)
			{
				view.schemaTI.text = e.profile[i].schema_file;
				model.schemaURL = e.profile[i].schema_file;
			}
			//view.schemaTI.text = model.schemaURL;
			//model.schemaURL = e.schema_url;
		}
		
		/**
		 * On Schema select update the display
		 */
		private function onSchemaSelected(e:SchemaEvent):void
		{
			view.schemaTI.text = model.schemaFile.nativePath;
		}
		
		/**
		 * On Click call the model to open a file select box
		 */
		private function onClick(e:MouseEvent):void
		{
			model.selectSchemaFile();
		}
	}
}