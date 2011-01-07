package com.structurecreator.air.components 
{
	import com.structurecreator.air.db.Database;
	import com.structurecreator.air.events.CustomVarEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class CustomVarsHolder extends Sprite
	{
		private var _numOfCustomVars:int;
		public static var customVars:Vector.<CustomVarField> = new Vector.<CustomVarField>();
		
		public function CustomVarsHolder() 
		{
			_numOfCustomVars = 1;
			
			add_mc.addEventListener(MouseEvent.CLICK, addClick);
			add_mc.buttonMode = true;
			
			
			for (var i:int = 0; i < _numOfCustomVars; i++) 
			{
				addNewCustomVar();
			}
		}
		
		private function addClick(e:MouseEvent):void 
		{
			addNewCustomVar();
		}
		
		public function addNewCustomVar(variable:String = '', value:String = ''):void 
		{
			removeChild(add_mc);
			
			var cust:CustomVarField = new CustomVarField();
			cust.setVariable(variable);
			cust.setValue(value);
			
			cust.addEventListener(CustomVarEvent.REMOVE, removeCustVar);
			
			cust.y = this.height + 5;
			customVars.push(cust);
			addChild(cust);
			
			add_mc.y = this.height + 5;
			addChild(add_mc);
		}
		
		private function removeCustVar(e:CustomVarEvent):void 
		{
			removeChild(add_mc);
			
			var cust:CustomVarField = e.currentTarget as CustomVarField;
			customVars.splice(customVars.indexOf(cust), 1);
			cust.removeEventListener(CustomVarEvent.REMOVE, removeCustVar);
			removeChild(cust);
			
			add_mc.y = this.height + 5;
			addChild(add_mc);
		}
		
		public function removeAll():void
		{
			removeChild(add_mc);
			
			var cust:CustomVarField;
			for (var i:int = 0; i < customVars.length; i++) 
			{
				cust = customVars[i] as CustomVarField;
				customVars.splice(customVars.indexOf(cust), 1);
				cust.removeEventListener(CustomVarEvent.REMOVE, removeCustVar);
				removeChild(cust);
			}
			
			add_mc.y = this.height + 5;
			addChild(add_mc);
		}
		
	}

}