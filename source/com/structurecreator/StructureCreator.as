package com.structurecreator 
{
	import com.structurecreator.customvars.CustomVariables;
	import com.structurecreator.customvars.CustomVarsHolder;
	import com.structurecreator.db.Database;
	import com.structurecreator.events.DatabaseEvent;
	import com.structurecreator.profiles.SaveProfile;
	import com.structurecreator.schemas.XMLSchema;
	import fl.containers.ScrollPane;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.TextInput;
	import fl.data.DataProvider;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class StructureCreator extends Sprite 
	{
		private var _cvh:CustomVarsHolder;
		private var _db:Database;
		internal var directory:File = File.documentsDirectory;
		internal var schema_file:File = new File();
		
		public function StructureCreator() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function init(e:Event):void 
		{
			title_txt.text = 'StructureCreator ' + Version.CURRENT_VERSION;
			
			project_folder_btn.addEventListener(MouseEvent.CLICK, handleClicks);
			schema_btn.addEventListener(MouseEvent.CLICK, handleClicks);
			create_btn.addEventListener(MouseEvent.CLICK, handleClicks);
			save_profile_btn.addEventListener(MouseEvent.CLICK, handleClicks);
			
			var tf:TextFormat = new TextFormat();
			tf.color = 0xffffff;
			(schema_file_cb as CheckBox).setStyle("textFormat", tf);
			(schema_file_cb as CheckBox).addEventListener(MouseEvent.CLICK, handleClicks);
			
			_cvh = new CustomVarsHolder();
			_cvh.x = 0;
			_cvh.y = 0;
			//var mc:MovieClip = new MovieClip();
			addChild(_cvh);
			custom_vars_scroll.source = _cvh;
			custom_vars_scroll.refreshPane();
			custom_vars_scroll.verticalScrollPosition = custom_vars_scroll.maxVerticalScrollPosition;
			//mc.addChild(_cvh);
			
			add_btn.addEventListener(MouseEvent.CLICK, handleClicks);
			
			initDB();
		}
		
		private function initDB():void 
		{
			trace("Create DB");
			_db = new Database();
			_db.addEventListener(DatabaseEvent.DB_CREATED, onDatabaseCreated);
			_db.addEventListener(DatabaseEvent.PROFILE_ADDED, onProfileAdded);
			_db.addEventListener(DatabaseEvent.GOT_PROFILES, onGotProfiles);
			//_db.addProfile();
			_db.init();
		}
		
		private function onDatabaseCreated(e:DatabaseEvent):void 
		{
			//trace("Add Profile");
			//_db.addProfile("Flash Project");
			_db.getProfiles();
		}
		
		private function onGotProfiles(e:DatabaseEvent):void 
		{
			//TODO update profiles combo
			if (e.result.length > 0)
			{
				var v:Array = [{'label':'', 'data':''}];
				for (var i:int = 0; i < e.result.length; i++) 
				{
					//trace(e.result[i].name, e.result[i].profile_id);
					v.push( {'label':e.result[i].name, 'value':e.result[i].profile_id} );
				}
				(project_profile_cb as ComboBox).dataProvider = new DataProvider(v);
				(project_profile_cb as ComboBox).enabled = true;
			}
		}
		
		private function onProfileAdded(e:DatabaseEvent):void 
		{
			_db.getProfiles();
		}
		
		private function handleClicks(e:MouseEvent):void 
		{
			switch(e.currentTarget.name)
			{
				case 'project_folder_btn' :
					trace("project button clicked");
					browseForProjectFolder();
					break;
				case 'schema_btn' :
					trace("schema button clicked");
					selectSchemaFile();
					break;
				case 'schema_file_cb' :
					if ((schema_file_cb as CheckBox).selected) 
					{
						schema_btn.enabled = false;
						schema_txt.enabled = true;
						schema_txt.editable = true;
						schema_file = new File();;
					}
					else 
					{
						schema_btn.enabled = true;
						schema_txt.enabled = false;
						schema_txt.editable = false;
					}
					schema_txt.text = '';
					enableCreateButton();
					break;
				case 'add_btn' :
					_cvh.add();
					//(custom_vars_scroll as ScrollPane).invalidate();
					//(custom_vars_scroll as ScrollPane).update();
					(custom_vars_scroll as ScrollPane).refreshPane();
					custom_vars_scroll.verticalScrollPosition = custom_vars_scroll.maxVerticalScrollPosition;
					break;
				case 'save_profile_btn' :
					var saveProfileBox:SaveProfile = new SaveProfile(_db);
					addChild(saveProfileBox);
					break;
				case 'create_btn' :
					createProjectStructure();
					break;
			}
		}
		
		//Open browse for project folder
		private function browseForProjectFolder():void 
		{
			try
			{
				directory.browseForDirectory("Select Directory");
				directory.addEventListener(Event.SELECT, onDirectorySelected);
			}
			catch (error:Error)
			{
				trace("Failed : " + error.message);
				//CaptainsLog.getInstance().addToLog('Failed: ' + error.message);
			}
		}
		
		//Project Directory Selected
		private function onDirectorySelected(e:Event):void 
		{
			directory = e.target as File;
			project_folder_txt.text = directory.nativePath;
			
			enableCreateButton();
		}
		
		private function selectSchemaFile():void
		{
			try
			{
				schema_file.browseForOpen("Select Schema", [new FileFilter("Schema XML/ZIP (*.xml, *.zip)", "*.xml; *.zip")]);
				schema_file.addEventListener(Event.SELECT, onSchemaSelected);
			}
			catch (error:Error)
			{
				trace('Failed: ' + error.message);
			}
		}
		
		//Schema is selected
		private function onSchemaSelected(e:Event):void 
		{
			schema_file = e.target as File;
			schema_txt.text = schema_file.nativePath;
			
			enableCreateButton();
		}
		
		private function enableCreateButton():void
		{
			if (schema_txt.text != "" && project_folder_txt.text != "")
				create_btn.enabled = true;
			else
				create_btn.enabled = false;
		}
		
		private function createProjectStructure():void
		{
			var schemaFileType:String = schema_file.nativePath.substr(schema_file.nativePath.lastIndexOf('.') + 1);
			CustomVariables.getInstance().variables = _cvh.getFullData();
			
			switch (schemaFileType.toLowerCase())
			{
				case 'xml':
					var schema:XMLSchema;
					if (!(schema_file_cb as CheckBox).selected) 
						schema = new XMLSchema(schema_file.url, directory.url);
					else
						schema = new XMLSchema(schema_txt.text, directory.url);
					break;
				case 'zip' :
					break;
			}
		}
		
		/**
		 * On Stage Resize
		 * @param	e
		 */
		private function onResize(e:Event):void 
		{
			project_profile_cb.width = stage.stageWidth - 20;
			
			project_folder_btn.x = stage.stageWidth - project_folder_btn.width - 10;
			project_folder_txt.width = project_folder_btn.x - 20;
			
			schema_btn.x = stage.stageWidth - schema_btn.width - 10;
			schema_txt.width = schema_btn.x - 20;
			
			create_btn.width = stage.stageWidth - 20;
			create_btn.y = stage.stageHeight - create_btn.height - 10;
			
			custom_vars_scroll.width = stage.stageWidth - 20;
			custom_vars_scroll.height = create_btn.y - custom_vars_scroll.y - add_btn.height - 10;
			
			add_btn.y = custom_vars_scroll.y + custom_vars_scroll.height;
			add_btn.x = stage.stageWidth - add_btn.width - 10;
			
			((custom_vars_scroll as ScrollPane).content as CustomVarsHolder).onResize();
		}
		
	}

}