package com.structurecreator.model.vo
{
	public class CustomVariableVO
	{
		private var _variable:String;
		private var _value:String;
		
		public function CustomVariableVO()
		{
			_variable = "variable";
			_value = "value";
		}

		public function get variable():String
		{
			return _variable;
		}
		
		public function set variable(value:String):void
		{
			_variable = value;
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}


	}
}