package com.structurecreator.air
{
	import com.structurecreator.air.files.MicrosoftX;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import nochump.util.zip.*;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class SchemaUnzip 
	{
		private var _zipInput:File;
		private var _directory:File;
		private var _zipFile:ZipFile;
		
		public function SchemaUnzip(schema_zip:File, directory:File) 
		{
			_zipInput = schema_zip;
			_directory = directory;
			
			CaptainsLog.getInstance().addToLog("Start Creation");
			
			loadZip();
		}
		
		private function loadZip():void 
		{
			var stream:FileStream = new FileStream();  
			stream.open(_zipInput, FileMode.READ);
			
			_zipFile = new ZipFile(stream);  
			//extract.enabled = true;
			
			extractZIP();
		}
		
		private function extractZIP():void  
		{  
			var entryFile:File;
			var entry:FileStream;
			var zipEntry:ZipEntry;
			var fileContent:String;
			var fileext:String = '';
			
			for(var i:uint = 0; i < _zipFile.entries.length; i++)  
			{  
				zipEntry = _zipFile.entries[i] as ZipEntry;  
				// The class considers the folder itself (without the contents) as a ZipEntry.  
				// So the code creates the subdirectories as expected.  
				if(!zipEntry.isDirectory())  
				{  
					//var targetDir:File = e.target as File;  
					entryFile = new File();
					entryFile = _directory.resolvePath(zipEntry.name);  
					entry = new FileStream();  
					entry.open(entryFile, FileMode.WRITE);
					
					fileext = zipEntry.name.substr(zipEntry.name.lastIndexOf('.') + 1);
					
					if (FileTypes.nonTextExtArray.indexOf(fileext) > -1)
					{
						switch (fileext) 
						{
							case 'docx':
							case 'pptx':
							case 'xlsx':
								entry.close();
								new MicrosoftX(entryFile, _zipFile.getInput(zipEntry));
							break;
							default:
								entry.writeBytes(_zipFile.getInput(zipEntry));
							break;
						}
					}
					else
					{
						fileContent = _zipFile.getInput(zipEntry).toString();
						fileContent = CustomVars.getInstance().addVariables(fileContent);
						entry.writeUTFBytes(fileContent);
					}
					
					entry.close();
				}
			}
		}

	}
}