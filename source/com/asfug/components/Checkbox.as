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
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Checkbox extends RadioButton
	{	
		/**
		 * Check Box
		 * @param	mc				Movie Clip to be the check box
		 * @param	checked			Sets if check box should be selected by default
		 * @param	checkedFrame	Frame label for checked frame. DEFAULT : 'checked'
		 * @param	uncheckedFrame	Frame label for unchecked frame. DEFAULT : 'unchecked'
		 */
		public function Checkbox(mc:MovieClip, checked:Boolean = false, checkedFrame:String = 'checked', uncheckedFrame:String = 'unchecked') 
		{
			super(mc, checked, checkedFrame, uncheckedFrame);
		}
		/**
		 * If checkbox is checked, uncheck it.
		 * If checkbox is uncheckes, check it.
		 * @param	e
		 */
		override protected function hClick(e:MouseEvent):void 
		{
			/*if (isChecked)
				uncheck();
			else
				check();*/
			isChecked ? uncheck() : check();
		}
		
	}

}