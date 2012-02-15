package com.structurecreator.view
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CustomVariablesMediator extends Mediator
	{
		[Inject]
		public var view:CustomVariablesView;
		
		public function CustomVariablesMediator()
		{
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.add, MouseEvent.CLICK, addCustomVariable);
		}
		
		private function addCustomVariable(e:MouseEvent):void
		{
			
		}
	}
}