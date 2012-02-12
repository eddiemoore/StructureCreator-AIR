package com.structurecreator.customvars 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVarsHolder extends MovieClip 
	{
		private var variables:Vector.<CustomVariableBar> = new Vector.<CustomVariableBar>();
		
		public function CustomVarsHolder() 
		{
			
		}
		
		public function add(variable:String='', value:String=''):void
		{
			trace("Add a custom variable");
			var cv:CustomVariableBar = new CustomVariableBar();
			cv.y = height;
			addChild(cv);
			
			variables.push(cv);
		}
		
		public function remove():void
		{
			
		}
		
		public function getFullData():Array
		{
			var a:Array = [];
			var cvb:CustomVariableBar;
			for (var i:int = 0; i < variables.length; i++) 
			{
				cvb = variables[i];
				a.push( { 'variable':cvb.getVariable(), 'value':cvb.getValue() } );
			}
			return a;
		}
		
		public function onResize():void 
		{
			trace('custom vars on resize');
			for each(var cv:CustomVariableBar in variables)
			{
				cv.setWidth(this.parent.width);
			}
		}
		
	}

}