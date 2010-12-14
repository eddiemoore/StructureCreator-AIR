package com.structurecreator.air.files 
{
	import com.structurecreator.air.CustomVars;
	import com.structurecreator.air.FileTypes;
	import flash.utils.ByteArray;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import nochump.util.zip.*;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class DocX
	{
		private var _outputFile:File;
		private var _docx:ZipFile;
		private var _bytes:ByteArray;
		
		public function DocX(file:File, bytes:ByteArray) 
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
					if (FileTypes.nonTextExtArray.indexOf(zipEntry.name.substr(zipEntry.name.lastIndexOf('.') + 1)) == -1)
					{
						//text file
						fileContent = _docx.getInput(zipEntry).toString();
						fileContent = CustomVars.getInstance().addVariables(fileContent);
						
						//var fileName:String = zipEntry.name;
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
		}
		
	}

}