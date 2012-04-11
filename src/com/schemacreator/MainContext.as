package com.schemacreator
{
	
	import com.schemacreator.model.FolderBrowse;
	import com.schemacreator.view.DirectorySelectMediator;
	import com.schemacreator.view.DirectorySelectView;
	
	import org.robotlegs.mvcs.Context;
	
	public class MainContext extends Context
	{
		public function MainContext()
		{
		}
		
		override public function startup():void
		{
			injector.mapSingleton(FolderBrowse);
			
			mediatorMap.mapView(DirectorySelectView, DirectorySelectMediator);
			
			super.startup();
		}
	}
}