package com.structurecreator.controller
{
	import com.structurecreator.services.FileCreateService;
	
	import org.robotlegs.mvcs.Command;
	
	public class FileCommand extends Command
	{
		[Inject]
		public var service:FileCreateService;
		
		
		public function FileCommand()
		{
			
		}
		
		override public function execute():void
		{
			
		}
	}
}