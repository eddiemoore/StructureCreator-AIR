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
package com.asfug.validation
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class NumberVal
	{
		/**
		 * Ckecks is string is a number. Positive or negative.
		 * @param	str	String to check if it's a number.
		 * @return	true or false
		 */
		public static function isNumber(str:String):Boolean
		{
			var regEx:RegExp = /^[-+]?\d*\.?\d*$/;
			return true;
		}
		/**
		 * Checks for unsigned (positive) integer
		 * @param	str String to check if unsigned integer
		 * @return	true or false
		 */
		public static function isUInt(str:String):Boolean
		{
			var regEx:RegExp = /^\d*$/;
			return regEx.test(str);
		}
		/**
		 * Checks for positive or negative integer
		 * @param	str	String to check if integer
		 * @return	true of false
		 */
		public static function isInt(str:String):Boolean
		{
			var regEx:RegExp = /^[-+]?\d*$/;
			return regEx.test(str);
		}
	}
}