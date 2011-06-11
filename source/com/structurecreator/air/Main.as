package com.structurecreator.air
{
	import com.structurecreator.air.components.CustomVarsHolder;
	import com.structurecreator.air.db.Database;
	import flash.display.*;
	import flash.net.FileFilter;
	import flash.text.*;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.events.Event;
	//import com.asfug.XMLTransverse;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Main extends Sprite
	{
		private static const _VERSION:String = '0.2';
		
		internal var directory:File = File.documentsDirectory;
		internal var schema_file:File = new File();
		public static var project_title:String;
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			new UpdateChecker();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			version_txt.text = 'StructureCreator v' + _VERSION;
			
			//Setup buttons
			create_btn.addEventListener(MouseEvent.CLICK, onCreateClick);
			browse_btn.addEventListener(MouseEvent.CLICK, onBrowseClick);
			schema_btn.addEventListener(MouseEvent.CLICK, onSchemaClick);
			
			//setupDatabase();
		}
		
		private function onCreateClick(e:MouseEvent):void 
		{
			createFolderStructure();
		}
		
		//Schema button clicked
		private function onSchemaClick(e:MouseEvent):void 
		{
			selectSchema();
		}
		
		//Select folder button clicked
		private function onBrowseClick(e:MouseEvent):void 
		{
			browseForFolder();
		}
		
		//Initialises the database for StructureCreator
		private function setupDatabase():void 
		{
			Database.getInstance().createDB();
			Database.getInstance().addProfile('Default');
			var result:Array = Database.getInstance().selectAllProfiles();
			
			for (var i:int = 0; i < result.length; i++) 
			{
				if (result[i].isDefault == 1)
					Database.getInstance().currentProfileId = int(result[i].profile_id);
			}
			
			// Get saved schema file
			result = Database.getInstance().selectProfile(Database.getInstance().currentProfileId);
			schema_file.url = result[0].schema_file == null ? '' : result[0].schema_file
			schema_txt.text = result[0].schema_file == null ? '' : result[0].schema_file;
			
			// Get custom vars for profile
			result = Database.getInstance().selectAllCustomVars(Database.getInstance().currentProfileId);
			if (result != null && result.length > 0)
			{
				var customVarsHolder:CustomVarsHolder = getChildByName('customVarsHolder_mc') as CustomVarsHolder;
				customVarsHolder.removeAll();
				for (var j:int = 0; j < result.length; j++) 
				{
					customVarsHolder.addNewCustomVar(result[j].variable, result[j].value);
				}
			}
		}
		
		//Open browse for project folder
		private function browseForFolder():void
		{
			try
			{
				directory.browseForDirectory("Select Directory");
				directory.addEventListener(Event.SELECT, onDirectorySelected);
			}
			catch (error:Error)
			{
				CaptainsLog.getInstance().addToLog('Failed: ' + error.message);
			}
		}
		
		//Project Directory Selected
		private function onDirectorySelected(event:Event):void 
		{
			directory = event.target as File;
			dir_txt.text = directory.nativePath;
		}
		
		//Browse for schema file
		private function selectSchema():void
		{
			try
			{
				schema_file.browseForOpen("Select Schema", [new FileFilter("Schema XML/ZIP (*.xml, *.zip)", "*.xml; *.zip")]);
				schema_file.addEventListener(Event.SELECT, onSchemaSelected);
			}
			catch (error:Error)
			{
				CaptainsLog.getInstance().addToLog('Failed: ' + error.message);
			}
		}
		
		//Schema is selected
		private function onSchemaSelected(event:Event):void 
		{
			schema_file = event.target as File;
			schema_txt.text = schema_file.nativePath;
		}
		
		private function createFolderStructure():void 
		{
			project_title = projectname_txt.text;
			
			CaptainsLog.getInstance().addToLog('**************************************************');
			CaptainsLog.getInstance().addToLog('NEW PROJECT STARTED');
			CaptainsLog.getInstance().addToLog('**************************************************');
			CaptainsLog.getInstance().addToLog(directory.url);
			CaptainsLog.getInstance().addToLog(schema_file.url);
			
			//trace(Database.getInstance().currentProfileId, schema_file.url);
			//Database.getInstance().updateProfile(Database.getInstance().currentProfileId, schema_file.url);
			
			//Database.getInstance().addCustomVars(CustomVarsHolder.customVars, Database.getInstance().currentProfileId);
			
			
			var schemaFileType:String = schema_file.nativePath.substr(schema_file.nativePath.lastIndexOf('.') + 1);
			
			if (schemaFileType.toLowerCase() == 'xml')
				new XMLTransverse(schema_file.url, directory.url);
			else if (schemaFileType.toLowerCase() == 'zip')
				new SchemaUnzip(schema_file, directory);
		}
	}

}