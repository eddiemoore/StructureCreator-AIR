package com.structurecreator.air
{
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
	public class StructureCreator extends MovieClip
	{
		var directory:File = File.documentsDirectory;
		var schema_file:File = new File();
		private static const _VERSION:String = '0.1';
		public static var project_title:String;
		
		public function StructureCreator() 
		{
			version_txt.text = 'StructureCreator v' + _VERSION;
			
			CaptainsLog.getInstance().initLogField(getChildByName('info_txt') as TextArea);
			
			create_btn.addEventListener(MouseEvent.CLICK, createFolderStructure);
			browse_btn.addEventListener(MouseEvent.CLICK, browseForFolder);
			schema_btn.addEventListener(MouseEvent.CLICK, selectSchema);
			
			new UpdateChecker();
		}

		private function browseForFolder(e:MouseEvent):void
		{
			try
			{
				directory.browseForDirectory("Select Directory");
				directory.addEventListener(Event.SELECT, directorySelected);
			}
			catch (error:Error)
			{
				CaptainsLog.getInstance().addToLog('Failed: ' + error.message);
			}
		}

		private function directorySelected(event:Event):void 
		{
			directory = event.target as File;
			dir_txt.text = directory.nativePath;
		}

		private function selectSchema(e:MouseEvent):void
		{
			try
			{
				schema_file.browseForOpen("Select Schema", [new FileFilter("Schema XML/ZIP (*.xml, *.zip)", "*.xml; *.zip")]);
				schema_file.addEventListener(Event.SELECT, schemaSelected);
			}
			catch (error:Error)
			{
				CaptainsLog.getInstance().addToLog('Failed: ' + error.message);
			}
		}

		private function schemaSelected(event:Event):void 
		{
			schema_file = event.target as File;
			schema_txt.text = schema_file.nativePath;
		}

		private function createFolderStructure(e:MouseEvent):void 
		{
			project_title = projectname_txt.text;
			
			CaptainsLog.getInstance().addToLog(directory.url);
			CaptainsLog.getInstance().addToLog(schema_file.url);
			
			var schemaFileType:String = schema_file.nativePath.substr(schema_file.nativePath.lastIndexOf('.') + 1);
			
			if (schemaFileType.toLowerCase() == 'xml')
				new XMLTransverse(schema_file.url, directory.url);
			else if (schemaFileType.toLowerCase() == 'zip')
				new SchemaUnzip(schema_file, directory);
		}
	}

}