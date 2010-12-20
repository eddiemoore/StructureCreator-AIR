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
package com.asfug.form 
{
	import com.asfug.components.Checkbox;
	import com.asfug.components.Dropdown;
	import com.asfug.components.RadioButtonGroup;
	import com.asfug.events.FormEvent;
	import com.asfug.utils.StringUtil;
	import com.asfug.validation.DateTime;
	import com.asfug.validation.Email;
	import com.asfug.validation.NumberVal;
	import com.asfug.validation.SingaporeNRIC;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	//import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Form extends EventDispatcher
	{
		private var _submitURL:String;
		private var _requestMethod:String;
		
		//private var _fields:Dictionary;
		private var _fields:Array;
		protected var _formVars:URLVariables;
		
		/**
		 * New Form
		 * @param	submit_url	Url to submit to
		 * @param	method	URL Request Method 'post' or 'get'
		 */
		public function Form(submit_url:String, method:String = URLRequestMethod.POST) 
		{
			//_fields = new Dictionary();
			_fields = new Array();
			_submitURL = submit_url;
			_requestMethod = method;
			_formVars = new URLVariables();
		}
		
		/**
		 * Add Text Field
		 * @param	field		Text field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	restrict	Characters to restrict in textfield
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addTextField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', restrict:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.TEXT_FIELD, restrict:restrict, error:error_text, min:minChar, max:maxChar });
			
			if (restrict.length > 0)
				field.restrict = restrict;
			initField(field, maxChar);
		}
		/**
		 * Adds Text Aread
		 * @param	field		Text field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	restrict	Characters to restrict in textfield
		 * @param	error_text	Error message to display
		 * @param	max_words	Maximum word allowed in text field
		 */
		public function addTextArea(field:TextField, variable:String, manditory:Boolean = true, restrict:String = '', error_text:String = '', max_words:int = 0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.TEXT_AREA, restrict:restrict, error:error_text, maxWords:max_words });
			
			if (restrict.length > 0)
				field.restrict = restrict;
			initField(field, 0);
		}
		
		/**
		 * Add Email Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addEmailField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.EMAIL_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = 'a-zA-Z0-9@_\\-\.';
			initField(field, maxChar);
		}
		
		/**
		 * Add Number Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addNumberField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.NUMBER_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = '0-9';
			initField(field, maxChar);
		}
		/**
		 * Add NRIC/FIN Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addNRICField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.NRIC_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = 'a-zA-Z0-9';
			initField(field, maxChar);
		}
		/**
		 * Add Date Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addDateField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.DATE_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = '0-9\\-';
			initField(field, maxChar);
		}
		/**
		 * Add Birthday Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addBirthdayField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.BIRTHDAY_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = '0-9\\-';
			initField(field, maxChar);
		}
		
		/**
		 * Add Password Field
		 * @param	field		Text field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	restrict	Characters to restrict in textfield
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addPasswordField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', restrict:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.PASSWORD_FIELD, restrict:restrict, error:error_text, min:minChar, max:maxChar });
			
			if (restrict.length > 0)
				field.restrict = restrict;
			initField(field, maxChar);
		}
		
		/**
		 * Add Confirm Password Field
		 * @param	field		Text field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	restrict	Characters to restrict in textfield
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addConfirmPasswordField(field:TextField, check_against:TextField, variable:String, manditory:Boolean = true, error_text:String = '', restrict:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, check_against:check_against, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.CONFIRM_PASSWORD_FIELD, restrict:restrict, error:error_text, min:minChar, max:maxChar });
			
			if (restrict.length > 0)
				field.restrict = restrict;
			initField(field, maxChar);
		}
		/**
		 * Initialises Fields
		 * @param	field	Field to initialise
		 * @param	maxChar	Maximum characters in field
		 */
		private function initField(field:TextField, maxChar:int = 0):void
		{
			field.type = TextFieldType.INPUT;
			if (maxChar > 0)
				field.maxChars = maxChar;
			field.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			field.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
		}
		/**
		 * Add Checkbox
		 * @param	cb			Checkbox to add.
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addCheckBox(cb:Checkbox, variable:String, manditory:Boolean = true, error_text:String = ''):void 
		{
			//_fields[cb.name] = { field:cb, manditory:manditory, type:'checkbox', error:error_text};
			_fields.push({ field:cb, variable:variable, manditory:manditory, type:FormFieldTypes.CHECKBOX, error:error_text});
		}
		/**
		 * Add Radio Button Group
		 * @param	rbg			Radio button group to add
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addRadioButtonGroup(rbg:RadioButtonGroup, variable:String, manditory:Boolean = true, error_text:String = ''):void
		{
			_fields.push({ field:rbg, variable:variable, manditory:manditory, type:FormFieldTypes.RADIO_BUTTON_GROUP, error:error_text});
		}
		/**
		 * Add Dropdown
		 * @param	dropdown	Dropdown to add
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addDropdown(dropdown:Dropdown, variable, manditory:Boolean = true, error_text:String = ''):void 
		{
			_fields.push({ field:dropdown, variable:variable, manditory:manditory, type:FormFieldTypes.DROPDOWN, error:error_text});
		}
		/**
		 * Add Additional Variable
		 * @param	data		Data to send
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addAdditionalVariable(data:String, variable:String, manditory:Boolean = true, type:String = FormFieldTypes.TEXT_FIELD, error_text:String = '' ):void 
		{
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (_fields[i].variable == variable)
					_fields.splice(i, 1);
			}
			var t:TextField = new TextField();
			t.text = data == null ? '' : data;
			_fields.push({ field:t, variable:variable, manditory:manditory, type:type, error:error_text});
		}
		/**
		 * Add Additional Variable at given position in fields array
		 * @param	data		Data to send
		 * @param	variable	Variable name to send to server.
		 * @param	position	Position in array to add field at. Starts from 0
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addAdditionalVariableAt(data:String, variable:String, position:int, manditory:Boolean = true, type:String = FormFieldTypes.TEXT_FIELD, error_text:String = '' ):void 
		{
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (_fields[i].variable == variable)
					_fields.splice(i, 1);
			}
			var t:TextField = new TextField();
			t.text = data == null ? '' : data;
			if (position > _fields.length)
				_fields.push( { field:t, variable:variable, manditory:manditory, type:type, error:error_text } );
			else
				_fields.splice(position,0,{ field:t, variable:variable, manditory:manditory, type:type, error:error_text});
		}
		
		/**
		 * Submit Form
		 * First validates and then submits the form
		 */
		public function submit():void
		{
			if (validate())
			{
				trace(_formVars);
				sendForm();
			}
		}
		/**
		 * Validates Form
		 * @return	Boolean value
		 */
		public function validate():Boolean
		{
			var valid:Boolean = true;
			_formVars = new URLVariables();
			for (var i:int = 0; i < _fields.length; ++i)
			{
				var currentObj:Object = _fields[i] as Object;
				switch (currentObj.type)
				{
					case FormFieldTypes.TEXT_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						if (currentObj.field.text == currentObj.defaultText)
							_formVars[currentObj.variable] = '';
						else
							_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.TEXT_AREA :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.maxWords > 0)
							{
								var count:int = StringUtil.trim(StringUtil.removeDoubleSpaceing(currentObj.field.text), ' ').split(' ').length;
								trace("count : " + count);
								if (count > currentObj.maxWords)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						if (currentObj.field.text == currentObj.defaultText)
							_formVars[currentObj.variable] = '';
						else
							_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.EMAIL_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !Email.isEmail(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.NUMBER_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !NumberVal.isNumber(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.NRIC_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !SingaporeNRIC.isNRIC(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.DATE_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !DateTime.isDateTime(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.BIRTHDAY_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !DateTime.isDateTime(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							else if (int((currentObj.field.text as String).split('-')[2]) > new Date().getFullYear())
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
								return false;
							}
							else if (int((currentObj.field.text as String).split('-')[2]) == new Date().getFullYear() && 
									int((currentObj.field.text as String).split('-')[1]) + 1 > new Date().getMonth())
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
								return false;
							}
							else if (int((currentObj.field.text as String).split('-')[2]) == new Date().getFullYear() && 
									int((currentObj.field.text as String).split('-')[1]) + 1 == new Date().getMonth() &&
									int((currentObj.field.text as String).split('-')[0]) > new Date().getDate())
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
								return false;
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.PASSWORD_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						if (currentObj.field.text == currentObj.defaultText)
							_formVars[currentObj.variable] = '';
						else
							_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.CONFIRM_PASSWORD_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.field.text != currentObj.check_against.text)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						if (currentObj.field.text == currentObj.defaultText)
							_formVars[currentObj.variable] = '';
						else
							_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.CHECKBOX :
						var c:Checkbox = currentObj.field as Checkbox;
						if (currentObj.manditory)
						{
							if (!c.isChecked)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error));
								return false;
							}
						}
						if (c.isChecked)
							_formVars[currentObj.variable] = 'Y';
						else
							_formVars[currentObj.variable] = 'N';
					break;
					case FormFieldTypes.RADIO_BUTTON_GROUP :
						var rbg:RadioButtonGroup = currentObj.field as RadioButtonGroup;
						if (currentObj.manditory)
						{
							if (rbg.currentIndex == -1)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error));
								return false;
							}
						}
						if (rbg.currentIndex == -1)
							_formVars[currentObj.variable] = '';
						else
							_formVars[currentObj.variable] = rbg.radioButtons[rbg.currentIndex].data;
					break;
					case FormFieldTypes.DROPDOWN :
						var d:Dropdown = currentObj.field as Dropdown;
						if (currentObj.manditory)
						{
							if ((d.getSelectedIndex() == 0 && d.getDisplayDefault() == true) || d.getSelectedLabel() == d.getDefaultText())
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error));
								return false;
							}
						}
						_formVars[currentObj.variable] = d.getSelectedData();
					break;
				}
			}
			
			if (valid) 
				dispatchEvent(new FormEvent(FormEvent.FORM_VALID));
			return valid;
		}
		/**
		 * Sends form to server
		 */
		private function sendForm():void
		{
			var l:URLLoader = new URLLoader();
			l.addEventListener(Event.COMPLETE, formSubmitComplete, false, 0, true);
			l.addEventListener(IOErrorEvent.IO_ERROR, formSubmitError, false, 0, true);
			
			var req:URLRequest = new URLRequest();
			req.method = _requestMethod;
			req.data = _formVars;
			req.url = _submitURL;
			
			l.load(req);
		}
		/**
		 * On form submit complete, dispatch event that form has been sent.
		 * @param	e
		 */
		private function formSubmitComplete(e:Event):void 
		{
			dispatchEvent(new FormEvent(FormEvent.FORM_SUBMITTED, false, false, e.currentTarget.data));
		}
		/**
		 * If there is an error in the form, dispach error event
		 * @param	e
		 */
		private function formSubmitError(e:IOErrorEvent):void 
		{
			dispatchEvent(new FormEvent(FormEvent.FORM_ERROR));
		}
		/**
		 * On text field focus in, hide default text
		 * @param	e
		 */
		private function focusIn(e:FocusEvent):void 
		{
			var f:TextField = e.currentTarget as TextField;
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (f == _fields[i].field)
				{
					if (f.text == _fields[i].defaultText)
						f.text = '';
					break;
				}
			}
		}
		/**
		 * On text field focus out, show default text field if text is blank
		 * @param	e
		 */
		private function focusOut(e:FocusEvent):void 
		{
			var f:TextField = e.currentTarget as TextField;
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (f == _fields[i].field)
				{
					if (f.text == '')
						f.text = _fields[i].defaultText;
					break;
				}
			}
		}
		/**
		 * Resets the form back to default values
		 */
		public function reset():void 
		{
			for (var i:int = 0; i < _fields.length; ++i)
			{
				var currentObj:Object = _fields[i] as Object;
				switch (currentObj.type)
				{
					case FormFieldTypes.TEXT_FIELD :
					case FormFieldTypes.TEXT_AREA :
					case FormFieldTypes.EMAIL_FIELD :
					case FormFieldTypes.NUMBER_FIELD :
					case FormFieldTypes.NRIC_FIELD :
					case FormFieldTypes.DATE_FIELD :
					case FormFieldTypes.BIRTHDAY_FIELD :
					case FormFieldTypes.PASSWORD_FIELD :
					case FormFieldTypes.CONFIRM_PASSWORD_FIELD :
						currentObj.field.text = currentObj.defaultText == null ? '' : currentObj.defaultText;
					break;
					case FormFieldTypes.CHECKBOX :
						var c:Checkbox = currentObj.field as Checkbox;
						c.defaultChecked ? c.check() : c.uncheck();
					break;
					case FormFieldTypes.RADIO_BUTTON_GROUP :
						var rbg:RadioButtonGroup = currentObj.field as RadioButtonGroup;
						rbg.reset();
					break;
					case FormFieldTypes.DROPDOWN :
						var d:Dropdown = currentObj.field as Dropdown;
						d.setSelectedIndex(0);
					break;
				}
			}
		}
		
	}

}