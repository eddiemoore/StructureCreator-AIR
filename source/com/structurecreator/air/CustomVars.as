package com.structurecreator.air
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVars 
	{
		private static var _instance:CustomVars = null;
		
		public function CustomVars(e:Singleton) {}
		
		public static function getInstance():CustomVars 
		{
            if(_instance==null)
                _instance = new CustomVars(new Singleton());
            return _instance;
        }
		
		public function addVariables(fileContent:String = ''):String
		{
			//TODO: Custom Variables
			/*var vars:Array = [{name:'TITLE', data:'MY PROJECT'}, 
							{name:'TEST', data:'This is the title'},
							{name:'MY_PARA', data:'this is the paragraph'}];
			var reg:RegExp;
			for (var i:int = 0; i < vars.length; i++)
			{
				reg = new RegExp("%" + vars[i].name + "%", "g");
				fileContent = _file_content.replace(reg, vars[i].data);
			}*/
			fileContent = fileContent.replace(/%PROJECT_TITLE%/g, StructureCreator.project_title);
			return fileContent;
		}
		
	}
	
}

class Singleton{}