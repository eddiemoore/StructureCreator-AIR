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
package com.asfug.utils 
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class DateUtil
	{
		
		public static function getDateTime():String
		{
			var d:Date = new Date();
			var year:String = d.getFullYear().toString();
			var month:String = d.getMonth() + 1 < 10 ? StringUtil.addLeadingZero(d.getMonth() + 1) : int(d.getMonth() + 1).toString();	
			var day:String = d.getDate() < 10 ? StringUtil.addLeadingZero(d.getDate()) : d.getDate().toString();	
			var hours:String = d.getHours() + 1 < 10 ? StringUtil.addLeadingZero(d.getHours() + 1) : int(d.getHours() + 1).toString();	
			var min:String = d.getMinutes() < 10 ? StringUtil.addLeadingZero(d.getMinutes()) : d.getMinutes().toString();	
			var sec:String = d.getSeconds() < 10 ? StringUtil.addLeadingZero(d.getSeconds()) : d.getSeconds().toString();	
			return year + month + day + hours + min + sec;
		}
		
	}

}