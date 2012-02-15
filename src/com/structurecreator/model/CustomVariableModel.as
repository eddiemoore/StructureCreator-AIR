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
		
		public function get customVars():Vector.<CustomVariableVO>
		{
			return _customVars;
		}
		
		public function updateVariableById(id:uint, variable:String='', value:String=''):void
		{
			customVars[id].variable = variable;
			customVars[id].value = value;
			trace(customVars[id].variable, customVars[id].value);
		}
		
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
		
		public function addCustomVariable():void
		{
			trace("Add a custom variable");
			var cv:CustomVariableVO = new CustomVariableVO();
			customVars.push(cv);
			eventDispatcher.dispatchEvent(new CustomVarsEvent(CustomVarsEvent.CUSTOM_VAR_ADDED));
		}
	}
}