package com.structurecreator.view
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CreateButtonMediator extends Mediator
	{
		[Inject]
		public var view:CreateButton;
		
		public function CreateButtonMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			trace("Clicked");
		}
	}
}