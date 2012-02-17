package com.structurecreator.services
{
	import com.structurecreator.model.CustomVariableModel;
	import com.structurecreator.model.vo.CustomVariableVO;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DatabaseService extends Actor
	{
		private var _dbFile:File;
		private var _connection:SQLConnection;
		private var _statement:SQLStatement;
		
		private var _statements:Array = [];
		public var currentProfileId:int = 1;
		
		[Inject]
		public var customVariableModel:CustomVariableModel;
		
		public function DatabaseService()
		{
			
		}
		
		public function createDB():void
		{
			_dbFile = File.documentsDirectory.resolvePath('StructureCreator.db');
			//_dbFile = File.applicationStorageDirectory.resolvePath('StructureCreator.db');
			
			_connection = new SQLConnection();
			_statement = new SQLStatement();
			
			_statement.addEventListener(SQLEvent.RESULT, onDatabaseReady);
			
			_connection.open(_dbFile);
			
			_statement.sqlConnection = _connection;
			
			addStatement("CREATE TABLE IF NOT EXISTS profiles(profile_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, schema_file TEXT, isDefault INTEGER DEFAULT 0);");
			addStatement("CREATE TABLE IF NOT EXISTS customvars(cvar_id INTEGER PRIMARY KEY AUTOINCREMENT, variable TEXT, value TEXT, profile_id INTEGER, FOREIGN KEY (profile_id) REFERENCES profiles(profile_id));");
			
			execute();
		}
		
		public function addProfile(name:String = ''):void
		{
			addStatement("INSERT INTO profiles (name) SELECT '" + name +"' WHERE NOT EXISTS (SELECT 1 FROM profiles WHERE name = '" + name + "');");
			execute();
		}
		
		public function updateProfile(id:int, schema_file:String = ''):void
		{
			currentProfileId = id;
			addStatement("UPDATE profiles SET schema_file='" + schema_file + "' WHERE profile_id='" + id + "';");
			execute();
		}
		
		public function selectProfile(id:int):Array
		{
			currentProfileId = id;
			addStatement("SELECT * from profiles WHERE profile_id='" + id + "' LIMIT 1;");
			execute();
			return _statement.getResult().data;
		}
		
		public function selectAllProfiles():Array
		{
			addStatement("SELECT * from profiles");
			execute();
			return _statement.getResult().data;
		}
		
		public function addCustomVars(profile_id:int):void
		{
			var item:CustomVariableVO;
			var customVars:Vector.<CustomVariableVO> = customVariableModel.customVars;
			for (var i:int = 0; i < customVars.length; i++) 
			{
				item = customVars[i];
				trace(item.variable);
				addStatement("INSERT INTO customvars (variable, value, profile_id) VALUES ('" + item.variable + "', '" + item.value + "', " + profile_id + ");");
			}
			
			execute();
		}
		
		public function selectAllCustomVars(profile_id:int):Array
		{
			addStatement("SELECT * from customvars WHERE profile_id='" + profile_id + "';");
			execute();
			return _statement.getResult().data;
		}
		
		private function execute():void 
		{
			if (_statements.length > 0)
			{
				_statement.text = _statements[0];
				_statements.splice(0, 1);
				//trace(_statements);
				_statement.execute();
			}
		}
		
		private function addStatement(statement:String):void
		{
			_statements.push(statement);
		}
		
		private function onDatabaseReady(e:Event):void 
		{
			trace('database ready');
			if (_statements.length > 0)
			{
				execute();
			}
		}
	}
}