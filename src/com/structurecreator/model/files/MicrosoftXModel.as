package com.structurecreator.model.files
{
	//import com.structurecreator.air.CustomVars;
	//import com.structurecreator.customvars.CustomVariables;
	import com.structurecreator.events.FileEvent;
	import com.structurecreator.model.files.FileTypes;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import nochump.util.zip.*;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class MicrosoftXModel extends EventDispatcher
	{
		private var _outputFile:File;
		private var _docx:ZipFile;
		private var _bytes:ByteArray;
		
		public function MicrosoftXModel(file:File, bytes:ByteArray) 
		{
			_outputFile = file;
			_bytes = bytes;
			
			readDocx();
		}
		
		private function readDocx():void
		{
			_docx = new ZipFile(_bytes);
			
			var zipEntry:ZipEntry;
			var fileContent:String;
			var zipOut:ZipOutput = new ZipOutput();
			var fileName:String;
			var fileData:ByteArray;
			
			for (var i:int = 0; i < _docx.entries.length; i++) 
			{
				zipEntry = _docx.entries[i] as ZipEntry;
				fileName = zipEntry.name;
				
				if(!zipEntry.isDirectory())  
				{
					if (FileTypes.NON_TEXT_EXT_ARRAY.indexOf(zipEntry.name.substr(zipEntry.name.lastIndexOf('.') + 1)) == -1)
					{
						//text file
						fileContent = _docx.getInput(zipEntry).toString();
						fileContent = fileContent; //CustomVariables.getInstance().updateVars(fileContent);						
						
						fileData = new ByteArray();
						fileData.writeUTFBytes(fileContent);
					}
					else
					{
						fileData = _docx.getInput(zipEntry);
					}
				}
				
				// Add entry to zip
				zipEntry = new ZipEntry(fileName);
				zipOut.putNextEntry(zipEntry);
				zipOut.write(fileData);
				zipOut.closeEntry();
			}
			// end the zip
			zipOut.finish();
			// access the zip data
			//var zipData:ByteArray = zipOut.byteArray;
			
			var fs:FileStream = new FileStream();
			fs.open(_outputFile, FileMode.WRITE);
			fs.writeBytes(zipOut.byteArray);
			fs.close();
			
			complete();
		}
		
		private function complete():void 
		{
			_outputFile = null;
			_bytes = null;
			_docx = null;
			
			dispatchEvent(new FileEvent(FileEvent.FILE_CREATED));
		}
		
	}
}