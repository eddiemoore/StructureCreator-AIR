package com.structurecreator.air.components 
{
	import com.asfug.components.Checkbox;
	import com.structurecreator.air.events.CustomVarEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
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
			
			var remove:MovieClip = getChildByName('delete_mc') as MovieClip;
			remove.buttonMode = true;
			remove.addEventListener(MouseEvent.CLICK, removeClicked, false, 0, true);
		}
		
		private function removeClicked(e:MouseEvent):void 
		{
			dispatchEvent(new CustomVarEvent(CustomVarEvent.REMOVE));
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