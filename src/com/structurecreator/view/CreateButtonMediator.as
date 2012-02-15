package com.structurecreator.view
{
	import com.structurecreator.model.StructureCreatorModel;
	import com.structurecreator.model.SchemaModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CreateButtonMediator extends Mediator
	{
		[Inject]
		public var view:CreateButton;
		
		[Inject]
		public var model:StructureCreatorModel;
		
		public function CreateButtonMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			trace("Clicked");
			model.startCreation();
		}
	}
}