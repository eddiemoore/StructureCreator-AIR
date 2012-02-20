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
		/**
		 * Initialises creation of the database */
		override public function execute():void
		{
			service.createDB();
		}
	}
}