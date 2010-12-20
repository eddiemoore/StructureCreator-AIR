package com.structurecreator.air
{
	import com.structurecreator.air.components.CustomVarsHolder;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVars 
	{
		private static var _instance:CustomVars = null;
		public var customVars:Vector.<Object> = new Vector.<Object>();
		
		public function CustomVars(e:Singleton) {}
		
		public static function getInstance():CustomVars 
		{
            if(_instance==null)
                _instance = new CustomVars(new Singleton());
            return _instance;
        }
		
		public function addCustomVars(variable:String, value:String):void
		{
			customVars.push( { name:variable, value:value } );
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
			var reg:RegExp;
			for (var i:int = 0; i < CustomVarsHolder.customVars.length; i++) 
			{
				reg = new RegExp("%" + CustomVarsHolder.customVars[i].getVariable() + "%", "g");
				fileContent = fileContent.replace(reg, CustomVarsHolder.customVars[i].getValue());
			}
			fileContent = fileContent.replace(/%PROJECT_TITLE%/g, StructureCreator.project_title);
			return fileContent;
		}
		
	}
	
}

class Singleton{}