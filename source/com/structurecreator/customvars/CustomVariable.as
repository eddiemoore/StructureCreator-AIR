package com.structurecreator.customvars 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVariable extends Sprite 
	{
		
		public function CustomVariable() 
		{
			//2 text fields and a checkbox
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 300, 22);
			graphics.endFill();
		}
		
		internal function setWidth(width:int):void
		{
			this.width = width;
		}
		
	}

}