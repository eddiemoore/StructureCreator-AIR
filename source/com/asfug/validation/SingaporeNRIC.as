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
	 * Based off javascript code by Samuel Liew (http://www.samliew.com)
	 */
	public class SingaporeNRIC
	{
		/**
		 * Checks if string is a Singapore NRIC or FIN number
		 * Format: SXXXXXXXA
		 * Where # is a number, and the first letter is either S,T,F,G.
		 * @param	str	String to check
		 * @return	true or false
		 */
		public static function isNRIC(str:String):Boolean
		{
			if (str.length != 9) 
				return false;
			
			str = str.toUpperCase();
			
			var icArray:Array = [];
			for(var i:int = 0; i < 9; ++i) 
				icArray[i] = str.charAt(i);
			
			icArray[1] = int(icArray[1]) * 2;
			icArray[2] = int(icArray[2]) * 7;
			icArray[3] = int(icArray[3]) * 6;
			icArray[4] = int(icArray[4]) * 5;
			icArray[5] = int(icArray[5]) * 4;
			icArray[6] = int(icArray[6]) * 3;
			icArray[7] = int(icArray[7]) * 2;
			
			var weight:int = 0;
			for(i = 1; i < 8; i++)
				weight += int(icArray[i]);
			
			var offset:int = (icArray[0] == "T" || icArray[0] == "G") ? 4:0;
			var temp:Number = (offset + weight) % 11;
			
			var st:Array = ["J","Z","I","H","G","F","E","D","C","B","A"];
			var fg:Array = ["X","W","U","T","R","Q","P","N","M","L","K"];
			
			var theAlpha:String;
			if		(icArray[0] == "S" || icArray[0] == "T") { theAlpha = st[temp]; }
			else if	(icArray[0] == "F" || icArray[0] == "G") { theAlpha = fg[temp]; }
			
			
			return icArray[8] != theAlpha ? false : true;
		}
		
	}
}