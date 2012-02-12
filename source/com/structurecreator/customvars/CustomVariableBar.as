package com.structurecreator.customvars 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVariableBar extends Sprite 
	{
		
		public function CustomVariableBar() 
		{
			//keep_cb
		}
		
		internal function setVariable(variable:String = ''):void
		{
			if (variable != '')
			{
				variable_txt.text = variable;
			}
		}
		
		internal function setValue(value:String = ''):void
		{
			if (value != '')
			{
				value_txt.text = value;
			}
		}
		
		internal function getVariable():String
		{
			return variable_txt.text;
		}
		
		internal function getValue():String
		{
			return value_txt.text;
		}
		
		internal function setWidth(width:int):void
		{
			this.width = width;
		}
		
	}

}