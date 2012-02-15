package com.structurecreator.view.customvars
{
	import com.structurecreator.model.CustomVariableModel;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CustomVariableBarMediator extends Mediator
	{
		[Inject]
		public var view:CustomVariableBarView;
		
		[Inject]
		public var model:CustomVariableModel;
		
		private var _id:uint;
		
		public function CustomVariableBarMediator()
		{
		}
		
		override public function onRegister():void
		{
			_id = model.customVars.length - 1;
			view.variableTI.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			view.valueTI.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		}
		
		protected function onFocusOut(event:FocusEvent):void
		{
			//trace("Update custom var VO");
			model.updateVariableById(_id, view.variableTI.text, view.valueTI.text);
		}
	}
}