package com.structurecreator.model
{
	import com.structurecreator.events.CustomVarsEvent;
	import com.structurecreator.model.vo.CustomVariableVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CustomVariableModel extends Actor
	{
		private var _customVars:Vector.<CustomVariableVO> = new Vector.<CustomVariableVO>();
		
		public function CustomVariableModel()
		{
			
		}
		
		/**
		 * returns all the current custom variables
		 */
		public function get customVars():Vector.<CustomVariableVO>
		{
			return _customVars;
		}
		
		/**
		 * Updates variable and value given it's ID
		 */
		public function updateVariableById(id:uint, variable:String='', value:String=''):void
		{
			customVars[id].variable = variable;
			customVars[id].value = value;
			trace(customVars[id].variable, customVars[id].value);
		}
		
		/**
		 * Uses RegEx to search through a given string and update any variables from the custom vars vector
		 */
		public function updateVariablesInStr(str:String=''):String
		{
			var vo:CustomVariableVO;
			var reg:RegExp;
			for (var i:int =0; i < customVars.length; i++)
			{
				vo = customVars[i];
				reg = new RegExp('%' + vo.variable + '%', 'g');
				str = str.replace(reg, vo.value);
			}
			return str;
		}
		
		/**
		 * Adds a new custom variable to the custom variables vector
		 */
		public function addCustomVariable():void
		{
			trace("Add a custom variable");
			//TODO check if last is empty
			var lastItem:CustomVariableVO = customVars.length > 0 ? customVars[customVars.length - 1] as CustomVariableVO : null;
			if (lastItem && lastItem.value == 'value' && lastItem.variable == 'variable')
			{
				eventDispatcher.dispatchEvent(new CustomVarsEvent(CustomVarsEvent.CANNOT_ADD_VAR));
			}
			else
			{
				var cv:CustomVariableVO = new CustomVariableVO();
				customVars.push(cv);
				eventDispatcher.dispatchEvent(new CustomVarsEvent(CustomVarsEvent.CUSTOM_VAR_ADDED));
			}
		}
	}
}