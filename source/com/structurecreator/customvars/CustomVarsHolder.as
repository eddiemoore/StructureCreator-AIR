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
		private var _yPos:int;
		
		public function CustomVarsHolder() 
		{
			_yPos = 0;
		}
		
		public function add(variable:String='', value:String=''):void
		{
			trace("Add a custom variable");
			var cv:CustomVariableBar = new CustomVariableBar();
			cv.setVariable(variable);
			cv.setValue(value);
			trace('before ', _yPos);
			cv.y = _yPos;
			_yPos += 30; //Height of bar. height is going all screwy at the moment. cv.height;
			trace('after ', _yPos);
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
		
		public function addVariables(result:Array):void 
		{
			clearAll();
			
			var o:Object;
			for (var i:int = 0; i < result.length; i++) 
			{
				o = result[i];
				add(o.variable, o.value);
			}
		}
		
		public function clearAll():void
		{
			while (numChildren > 0)
				removeChildAt(0);
				
			variables.length = 0;
			_yPos = 0;
		}
		
	}

}