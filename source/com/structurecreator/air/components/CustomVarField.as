package com.structurecreator.air.components 
{
	import com.asfug.components.Checkbox;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVarField extends Sprite
	{
		private var _remeber:Checkbox;
		
		public function CustomVarField() 
		{
			variable_txt.restrict = 'a-zA-Z0-9_\-';
			
			_remeber = new Checkbox(remember_mc);
		}
		
		public function getVariable():String
		{
			return variable_txt.text;
		}
		
		public function getValue():String
		{
			return value_txt.text;
		}
		
		public function getRemember():Boolean
		{
			return _remeber.isChecked;
		}
		
		
		public function setVariable(variable:String = ''):void
		{
			variable_txt.text = variable;
		}
		
		public function setValue(value:String = ''):void
		{
			value_txt.text = value;
		}
		
	}

}