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
		
		public function addCustomVariable():void
		{
			trace("Add a custom variable");
			var cv:CustomVariableVO = new CustomVariableVO();
			customVars.push(cv);
			eventDispatcher.dispatchEvent(new CustomVarsEvent(CustomVarsEvent.CUSTOM_VAR_ADDED));
		}
	}
}