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
		private var variables:Vector.<CustomVariable> = new Vector.<CustomVariable>();
		
		public function CustomVarsHolder() 
		{
			
		}
		
		public function add():void
		{
			trace("Add a custom variable");
			var cv:CustomVariable = new CustomVariable();
			cv.y = height;
			addChild(cv);
			
			variables.push(cv);
		}
		
		public function remove():void
		{
			
		}
		
		public function onResize():void 
		{
			trace('custom vars on resize');
			for each(var cv:CustomVariable in variables)
			{
				cv.setWidth(this.parent.width);
			}
		}
		
	}

}