package com.structurecreator.view
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SchemaSelectMediator extends Mediator
	{
		[Inject]
		public var view:SchemaSelectView;
		
		public function SchemaSelectMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.browse, MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			
		}
	}
}