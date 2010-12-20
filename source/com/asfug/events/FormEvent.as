/**
Copyright (c) 2010 A-SFUG - http://a-sfug.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package com.asfug.events 
{
	import flash.display.DisplayObject;
	import flash.events.DataEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class FormEvent extends DataEvent
	{
		public static const FIELD_ERROR:String = 'fielderror';
		public static const FIELD_OUTOFRANGE:String = 'outOfRange';
		public static const FORM_SUBMITTED:String = 'formSubmitted';
		public static const FORM_ERROR:String = 'formerror';
		public static const FORM_VALID:String = 'formvalid';
		private var _field:TextField;
		private var _errorMessage:String;
		
		public function FormEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:String = "", field:TextField = null)
		{
			_field = field;
			_errorMessage = data;
			super(type, bubbles, cancelable, data);
		}
		
		public function get field():TextField { return _field; }
		
		public function get errorMessage():String { return _errorMessage; }
		
	}

}