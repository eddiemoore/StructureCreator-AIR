package com.structurecreator.model
{
	import com.structurecreator.events.StructureCreatorEvent;
	import com.structurecreator.model.schemas.XMLSchema;
	
	import org.robotlegs.mvcs.Actor;
	
	public class StructureCreatorModel extends Actor
	{
		[Inject]
		public var projectFolderModel:ProjectFolderModel;
		
		[Inject]
		public var schemaModel:SchemaModel;
		
		[Inject]
		public var xmlSchema:XMLSchema;
		
		public function StructureCreatorModel()
		{
			
		}
		
		/**
		 * Starts inital creation of project
		 * Decides which schema model to use
		 */
		public function startCreation():void
		{
			eventDispatcher.dispatchEvent(new StructureCreatorEvent(StructureCreatorEvent.CREATION_STARTED));
			var schemaType:String = schemaModel.schemaFile.nativePath.substr(schemaModel.schemaFile.nativePath.lastIndexOf('.') + 1);
			switch (schemaType)
			{
				case 'xml' :
					xmlSchema.start(schemaModel.schemaFile.url, projectFolderModel.projectFolder.url);
					break;
				case 'zip' :
					break;
			}
		}
		
		
	}
}