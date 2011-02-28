import com.structurecreator.*;
import com.structurecreator.updates.UpdateChecker;

import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import mx.events.FlexEvent;

private var directory:File = File.documentsDirectory;
private var schemaFile:File = new File();


new UpdateChecker();


protected function setup(event:FlexEvent):void
{
	// TODO Auto-generated method stub
	CustomVars.getInstance().ac = new ArrayCollection();
}

/**
 * Button Click Events
 */
protected function addButton_clickHandler(event:MouseEvent):void
{
	// TODO Auto-generated method stub
	//
	CustomVars.getInstance().ac.addItem({id:CustomVars.getInstance().ac.length, variable:'', value:''});
}


protected function selectFolder_clickHandler(event:MouseEvent):void
{
	trace("Select Folder");
	try
	{
		directory.browseForDirectory("Select Directory");
		directory.addEventListener(Event.SELECT, onDirectorySelected);
	}
	catch(e:Error)
	{
		trace("Couldn't select a directory");
	}
}


protected function selectSchema_clickHandler(event:MouseEvent):void
{
	trace("selectSchema");
	try
	{
		schemaFile.browseForOpen("Select Schema", [new FileFilter("Schema XML/ZIP (*.xml, *.zip)", "*.xml; *.zip")]);
		schemaFile.addEventListener(Event.SELECT, onSchemaSelected);
	}
	catch (error:Error)
	{
		trace("Error Selecting Schema File");
	}
}


protected function createBtn_clickHandler(event:MouseEvent):void
{
	trace("Create Structure");
	//validate
	if (validate())
	{
		//Start Createion
		com.structurecreator.ProjectVars.projectName = projectName.text;
		
		var schemaFileType:String = (schemaField.text as String).substr((schemaField.text as String).lastIndexOf('.') + 1);
		
		if (schemaFileType.toLowerCase() == 'xml')
			new XMLTransverse(schemaFile.url, directory.url);
		else if (schemaFileType.toLowerCase() == 'zip')
			new SchemaUnzip(schemaFile, directory);
		else
			trace("Unknown Schema Type");
	}
	else
	{
		trace("not valid");
	}
	
}


/**
 * Directory Selected
 */
private function onDirectorySelected(event:Event):void
{
	trace("Directory Selected");
	directory = event.target as File;
	projectFolderField.text = directory.nativePath;
}

//Schema Selected
private function onSchemaSelected(event:Event):void
{
	trace("Schema Selected");
	schemaFile = event.target as File;
	schemaField.text = schemaFile.nativePath;
}

private function validate():Boolean
{
	var isValid:Boolean = true;
	
	if (projectName.text == "")
		isValid = false;
	if (projectFolderField.text == "")
		isValid = false;
	if (schemaField.text == "")
		isValid = false;
	
	return isValid;
}


