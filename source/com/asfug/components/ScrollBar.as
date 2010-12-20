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
	import caurina.transitions.Tweener;
	import com.asfug.events.ScrollBarEvent;
	import flash.display.*;
	import flash.events.*;
	
	public class ScrollBar extends EventDispatcher
	{
		private var _stage:Stage;
		private var _mc:MovieClip;
		public var _thumb:MovieClip;
		public var _track:MovieClip;
		
		public var _hitArea:MovieClip;
		
		private var yOffset:Number;
		private var yMin:Number;
		private var yMax:Number;
		
		public function ScrollBar(mc:MovieClip, stage:Stage):void 
		{
			_stage = stage;
			_mc = mc;
			_thumb = _mc.getChildByName('thumb') as MovieClip;
			_track = _mc.getChildByName('track') as MovieClip;
			
			_hitArea = new MovieClip();
			_hitArea.graphics.beginFill(0x00ff00);
			_hitArea.graphics.drawRect(0, 0, _thumb.width + 10, _thumb.height);
			_hitArea.graphics.endFill();
			
			_hitArea.x = _hitArea.y = 0;
			_hitArea.x = _thumb.width / 2 - _hitArea.width / 2;
			_hitArea.alpha = 0;
			
			_thumb.addChild(_hitArea);
			
			_thumb.height = 25;
			
			yMin = 0;
			yMax = _track.height - _thumb.height;
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			
		}
		
		private function thumbDown(e:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			yOffset = _stage.mouseY - _mc.thumb.y;
			_stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
		}
		
		private function thumbUp(e:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);
		}
		
		private function thumbMove(e:MouseEvent):void
		{
			_thumb.y = _stage.mouseY - yOffset;
			if(_thumb.y <= yMin)	_thumb.y = yMin;
			if(_thumb.y >= yMax)	_thumb.y = yMax;
			dispatchEvent(new ScrollBarEvent(_thumb.y / yMax));
			e.updateAfterEvent();
		}
		
		public function reset():void
		{
			_thumb.y = _track.y;
		}
		
		public function scroll(scrollPercent:Number):void
		{
			Tweener.addTween(_thumb, { y: scrollPercent * yMax, time: .5, transition: 'easeOutQuart' } );
		}
		
		public function hide():void
		{
			_mc.visible = false;
		}
		
		public function show():void
		{
			_mc.visible = true;
		}
	}
}
