package com.structurecreator.view.customvars
{
	import com.structurecreator.model.CustomVariableModel;
	
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CustomVariableBarMediator extends Mediator
	{
		[Inject]
		public var view:CustomVariableBarView;
		
		[Inject]
		public var model:CustomVariableModel;
		
		public function CustomVariableBarMediator()
		{
		}
		
		override public function onRegister():void
		{
			view.variableTI.addEventListener(KeyboardEvent.KEY_UP, onKeyUp)
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			trace("Update custom var VO");
		}
	}
}