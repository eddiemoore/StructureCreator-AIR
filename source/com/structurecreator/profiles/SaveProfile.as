package com.structurecreator.profiles 
{
	import com.structurecreator.db.Database;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class SaveProfile extends Sprite 
	{
		private var _db:Database;
		
		public function SaveProfile(db:Database) 
		{
			_db = db;
			
		}
		
	}

}