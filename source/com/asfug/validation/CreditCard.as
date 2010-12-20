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
	public class CreditCard
	{
		/**
		 * Checks is string is a Visa Card
		 * @param	str	Card Number without spaces
		 * @return	true or false
		 */
		public static function isVisa(str:String):Boolean
		{
			var regEx:RegExp = /^4[0-9]{12}(?:[0-9]{3})?$/;
			return regEx.test(str);
		}
		/**
		 * Checks is string is a Master Card
		 * @param	str	Card Number without spaces
		 * @return	true or false
		 */
		public static function isMasterCard(str:String):Boolean
		{
			var regEx:RegExp = /^5[1-5][0-9]{14}$/;
			return regEx.test(str);
		}
		/**
		 * Checks is string is an American Express Card
		 * @param	str	Card Number without spaces
		 * @return	true or false
		 */
		public static function isAmericanExpress(str:String):Boolean
		{
			var regEx:RegExp = /^3[47][0-9]{13}$/;
			return regEx.test(str);
		}
		/**
		 * Checks is string is a Diners Card
		 * @param	str	Card Number without spaces
		 * @return	true or false
		 */
		public static function isDinersClub(str:String):Boolean
		{
			var regEx:RegExp = /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/;
			return regEx.test(str);
		}
		/**
		 * Checks is string is a Discover Card
		 * @param	str	Card Number without spaces
		 * @return	true or false
		 */
		public static function isDiscover(str:String):Boolean
		{
			var regEx:RegExp = /^6(?:011|5[0-9]{2})[0-9]{12}$/;
			return regEx.test(str);
		}
		/**
		 * Checks is string is a JCB Card
		 * @param	str	Card Number without spaces
		 * @return	true or false
		 */
		public static function isJCB(str:String):Boolean
		{
			var regEx:RegExp = /^(?:2131|1800|35\d{3})\d{11}$/;
			return regEx.test(str);
		}
	}
}