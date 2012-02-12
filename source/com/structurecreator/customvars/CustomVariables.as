package com.structurecreator.customvars 
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVariables 
	{
		private static var _instance:CustomVariables = null;
		public var variables:Array = [];
		
		public function CustomVariables(e:Singleton) {}
		
		public static function getInstance():CustomVariables 
		{
            if (_instance == null)
                _instance = new CustomVariables(new Singleton());
            return _instance;
        }
		
		public function updateVars(str:String=''):String
		{
			var reg:RegExp;
			var o:Object;
			for (var i:int = 0; i < variables.length; i++) 
			{
				o = variables[i];
				reg = new RegExp("%" + o.variable + "%", "g");
				str = str.replace(reg, o.value);
			}
			return str;
		}
		
		
		
	}

}


class Singleton{}