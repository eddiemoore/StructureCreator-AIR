package com.structurecreator.profiles
{
	import com.structurecreator.db.Database;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class SaveProfile extends Sprite
	{
		private var _db:Database;
		private var _customVars:Array
		private var _schemaURL:String;;
		
		public function SaveProfile(db:Database, customVars:Array, schema_url:String = '')
		{
			_db = db;
			_customVars = customVars;
			_schemaURL = schema_url;
			
			save_btn.addEventListener(MouseEvent.CLICK, save_btn_click);
		}
		
		private function save_btn_click(e:MouseEvent):void
		{
			if (name_txt.text != "")
			{
				_db.addProfile(name_txt.text, _customVars, _schemaURL);
			}
		}
	
	}

}