package com.schemacreator.view
{
	import com.schemacreator.model.SchemaModel;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CreateSchemaBtnMediator extends Mediator
	{
		[Inject]
		public var view:CreateSchemaBtnView;
		
		[Inject]
		public var model:SchemaModel;
		
		public function CreateSchemaBtnMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.createBtn, MouseEvent.CLICK, onCreateBtnClick);
		}
		
		private function onCreateBtnClick(e:MouseEvent):void
		{
			model.browseForFile();
		}
	}
}