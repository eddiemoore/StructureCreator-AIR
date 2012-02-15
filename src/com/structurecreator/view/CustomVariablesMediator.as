package com.structurecreator.view
{
	import com.structurecreator.events.CustomVarsEvent;
	import com.structurecreator.model.CustomVariableModel;
	import com.structurecreator.view.customvars.CustomVariableBarView;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.DataRenderer;
	
	public class CustomVariablesMediator extends Mediator
	{
		[Inject]
		public var view:CustomVariablesView;
		
		[Inject]
		public var model:CustomVariableModel;
		
		public function CustomVariablesMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.add, MouseEvent.CLICK, addCustomVariable);
			eventMap.mapListener(eventDispatcher, CustomVarsEvent.CUSTOM_VAR_ADDED, onCustomVarAdded); 
		}
		
		private function onCustomVarAdded(e:CustomVarsEvent):void
		{
			//trace("Added Custom Variable");
			var cvb:CustomVariableBarView = new CustomVariableBarView();
			cvb.y = model.customVars.length * cvb.height;
			view.customVarsHolder.addElement(cvb);
		}
		
		private function addCustomVariable(e:MouseEvent):void
		{
			model.addCustomVariable();
		}
	}
}