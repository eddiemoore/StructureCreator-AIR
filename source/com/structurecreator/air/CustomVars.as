package com.structurecreator.air
{
	import com.structurecreator.air.components.CustomVarField;
	import com.structurecreator.air.components.CustomVarsHolder;
	import com.structurecreator.air.db.Database;
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
			var reg:RegExp;
			var field:CustomVarField;
			for (var i:int = 0; i < CustomVarsHolder.customVars.length; i++) 
			{
				field = CustomVarsHolder.customVars[i] as CustomVarField;
				reg = new RegExp("%" + field.getVariable() + "%", "g");
				fileContent = fileContent.replace(reg, field.getValue());
			}
			fileContent = fileContent.replace(/%PROJECT_TITLE%/g, Main.project_title);
			return fileContent;
		}
		
	}
	
}

class Singleton{}