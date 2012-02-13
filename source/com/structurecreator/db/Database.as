package com.structurecreator.db 
{
	import com.structurecreator.events.DatabaseEvent;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.data.*;	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Database extends EventDispatcher
	{
		private var _sqlConnection:SQLConnection;
		private var _sqlStatement:SQLStatement;
		private var _customVars:Array;
		private var _db:File;
		
		public function Database() 
		{
			_db = File.applicationStorageDirectory.resolvePath("structurecreator.db");
			
			_sqlConnection = new SQLConnection();			
			
			_sqlConnection.addEventListener(SQLEvent.OPEN, sqlConnection_open);
			_sqlConnection.addEventListener(SQLErrorEvent.ERROR, sqlConnection_error);
			
			_sqlConnection.open(_db);
		}
		
		public function init():void
		{
			createDBSchema();
		}
		
		private function createDBSchema():void 
		{
			trace("create db schema");
			_sqlStatement = new SQLStatement();
			_sqlStatement.sqlConnection = _sqlConnection;
			_sqlStatement.text = "CREATE TABLE IF NOT EXISTS profiles (profile_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
			_sqlStatement.addEventListener(SQLEvent.RESULT, onDBCreated);
			_sqlStatement.execute();
		}
		
		private function onDBCreated(e:SQLEvent):void 
		{
			_sqlStatement.removeEventListener(SQLEvent.RESULT, onDBCreated);
			dispatchEvent(new DatabaseEvent(DatabaseEvent.DB_CREATED));
		}
		
		private function sqlConnection_error(e:SQLErrorEvent):void 
		{
			trace("Error connecting to the database");
		}
		
		private function sqlConnection_open(e:SQLEvent):void 
		{
			_sqlConnection.removeEventListener(SQLEvent.OPEN, sqlConnection_open);
			_sqlConnection.removeEventListener(SQLErrorEvent.ERROR, sqlConnection_error);
			if (e.type == "open")
			{
				
				trace("Database connection is open");
				//getProfiles();
				
			}
		}
		
		public function getProfiles():void 
		{
			_sqlStatement = new SQLStatement();
			_sqlStatement.sqlConnection = _sqlConnection;
			_sqlStatement.text = "SELECT * FROM profiles";
			_sqlStatement.addEventListener(SQLEvent.RESULT, onGetProfiles);
			_sqlStatement.execute();
		}
		
		private function onGetProfiles(e:SQLEvent):void 
		{
			_sqlStatement.removeEventListener(SQLEvent.RESULT, onGetProfiles);
			var result:SQLResult = _sqlStatement.getResult();
			dispatchEvent(new DatabaseEvent(DatabaseEvent.GOT_PROFILES, result.data));
		}
		
		/**
		 * To insert a new profile into the db.
		 * @param	name		Name for the label in the combo box
		 * @param	customVars	Array of objects that contain variable name and values
		 */
		public function addProfile(name:String="HTML5 Boilerplate", customVars:Array=null):void
		{
			_customVars = customVars;
			//TODO Check if name exists
			_sqlStatement = new SQLStatement();
			_sqlStatement.sqlConnection = _sqlConnection;
			_sqlStatement.text = "INSERT INTO profiles (name) VALUES (?)";
			_sqlStatement.parameters[0] = name;
			_sqlStatement.addEventListener(SQLEvent.RESULT, onProfileAdded);
			_sqlStatement.execute();
		}
		
		private function onProfileAdded(e:SQLEvent):void 
		{
			_sqlStatement.removeEventListener(SQLEvent.RESULT, onProfileAdded);
			var result:SQLResult = _sqlStatement.getResult();
			
			if (_customVars) 
			{
				var rowID:int = int(result.lastInsertRowID);
				var o:Object;
				for (var i:int = 0; i < _customVars.length; i++) 
				{
					o = _customVars[i];
					_sqlStatement = new SQLStatement();
					_sqlStatement.sqlConnection = _sqlConnection;
					_sqlStatement.text = "INSERT INTO customvars (variable, value) VALUES (?, ?)";
					_sqlStatement.parameters[0] = o.variable;
					_sqlStatement.parameters[1] = o.value;
					//_sqlStatement.addEventListener(SQLEvent.RESULT, onProfileAdded);
					_sqlStatement.execute();
				}
			}
			//result.lastInsertRowID
			dispatchEvent(new DatabaseEvent(DatabaseEvent.PROFILE_ADDED, result.data));
		}
		
	}

}