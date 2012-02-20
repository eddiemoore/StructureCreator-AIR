package com.structurecreator.controller
{
	import com.structurecreator.events.FileEvent;
	import com.structurecreator.services.FileCreateService;
	
	import org.robotlegs.mvcs.Command;
	
	public class FileCommand extends Command
	{
		[Inject]
		public var event:FileEvent;
		
		[Inject]
		public var service:FileCreateService;
		
		public function FileCommand()
		{
			
		}
		
		/**
		 * Initialises the creation of a new file
		 */
		override public function execute():void
		{
			service.init(event.fileDeatailsVO);
		}
	}
}