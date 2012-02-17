package com.structurecreator.controller
{
	import com.structurecreator.events.StructureCreatorEvent;
	import com.structurecreator.services.DatabaseService;
	
	import org.robotlegs.mvcs.Command;
	
	public class DatabaseCommand extends Command
	{
		[Inject]
		public var event:StructureCreatorEvent;
		
		[Inject]
		public var service:DatabaseService;
		
		public function DatabaseCommand()
		{
			
		}
		
		override public function execute():void
		{
			service.createDB();
		}
	}
}