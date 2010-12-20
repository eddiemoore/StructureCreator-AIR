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
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	/**
	 * Utilities for MovieClips
	 * @author Ed Moore
	 */
	public class MCUtil 
	{
		/**
		 * Adds script at frame given frame label
		 * @param	mc			Movie Clip to add script to
		 * @param	frameLabel	Frame label to add script to
		 * @param	func		Function to add to frame
		 */
		public static function addFrameAction(mc:MovieClip, frameLabel:String, func:Function):void
		{
			for (var i:int = 0; i < mc.currentLabels.length; i++) 
			{
				if (mc.currentLabels[i].name == frameLabel)
					mc.addFrameScript(mc.currentLabels[i].frame-1, func);
			}
		}
		/**
		 * check whether the movieclip has a perticular frame 
		 * @param	mc					movieclip to check
		 * @param	labelName		label name ( frame name, as normally called )
		 * @return								whether the frame is found in the button movieclip
		 */
		public static function hasLabel(mc:MovieClip, labelName:String):Boolean 
		{
			var labels:Array = mc.currentLabels;
			for (var i:int = 0; i < labels.length; i++) {
				var la:FrameLabel = labels[i] as FrameLabel;
				if (la.name == labelName) {
					return true;
				}
			}
			return false;
		}
		/**
		 * Remove all children in a DisplayObjectContainer
		 * @param	mc
		 */
		public static function removeAllChildren(doc:DisplayObjectContainer):void
		{
			while (doc.numChildren > 0)	doc.removeChildAt(0);
		}
	}
	
}