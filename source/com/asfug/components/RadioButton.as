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
package com.asfug.components 
{
	import com.asfug.events.ToggleButtonEvent;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class RadioButton extends EventDispatcher
	{
		private var _mc:MovieClip;
		public var defaultChecked:Boolean;
		public var isChecked:Boolean;
		internal var name:String;
		private var _uncheckedFrame:String;
		private var _checkedFrame:String;
		
		/**
		 * Radio Button
		 * @param	mc				Movie Clip to be the radio Button
		 * @param	checked			Sets if radio button should be selected by default
		 * @param	checkedFrame	Frame label for checked frame. DEFAULT : 'checked'
		 * @param	uncheckedFrame	Frame label for unchecked frame. DEFAULT : 'unchecked'
		 */
		public function RadioButton(mc:MovieClip, checked:Boolean = false, checkedFrame:String = 'checked', uncheckedFrame:String = 'unchecked') 
		{
			_mc = mc;
			defaultChecked = checked;
			isChecked = checked;
			name = _mc.name;
			_checkedFrame = checkedFrame;
			_uncheckedFrame = uncheckedFrame;
			
			/* if (isChecked)	check();
			else			uncheck(); */
			isChecked ? check() : uncheck();
			
			_mc.addEventListener(MouseEvent.CLICK, hClick);
			_mc.mouseChildren = false;
			_mc.buttonMode = true;
		}
		/**
		 * On click, check the Toggle Button
		 * @param	e
		 */
		protected function hClick(e:MouseEvent):void 
		{
			if (!isChecked) check();
		}
		/**
		 * Check the Toggle button
		 */
		public function check():void
		{
			_mc.gotoAndStop(_checkedFrame);
			isChecked = true;
			dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE_BUTTON_CHECKED));
		}
		/**
		 * Uncheck the Toggle button
		 */
		public function uncheck():void
		{
			_mc.gotoAndStop(_uncheckedFrame);
			isChecked = false;
			dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE_BUTTON_UNCHECKED));
		}
		
	}

}