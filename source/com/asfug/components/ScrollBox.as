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
	import com.asfug.events.ScrollBarEvent;
	import flash.display.*;
	import flash.events.*;
	import caurina.transitions.*;
	
	/**
	 *	Based on code by Lee Brimelow (http://theflashblog.com) (http://www.gotoandlearn.com)
	 */
	public class ScrollBox extends EventDispatcher
	{
		private var _instance:MovieClip;
		private var _scrollbar:ScrollBar;
		private var _sb:MovieClip;
		private var _mask:MovieClip;
		private var _content:MovieClip;
		
		public function ScrollBox(mc:MovieClip, stage:Stage):void 
		{
			_instance = mc;
			_content = _instance.getChildByName("content") as MovieClip;
			_mask = _instance.getChildByName("masker") as MovieClip;
			
			_content.mask = _mask;
			
			_sb = _instance.getChildByName("sb") as MovieClip;
			_scrollbar = new ScrollBar(_sb, stage);
			_scrollbar._thumb.buttonMode = true;
			_scrollbar.addEventListener(ScrollBarEvent.VALUE_CHANGED, sbChange);
			_instance.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent, true);
		}

		private function sbChange(e:ScrollBarEvent)
		{
			var scrollPercent = e.getScrollPercent();
			scrollbar.scroll(scrollPercent);
			Tweener.addTween(_content, { y:( -scrollPercent * (_content.height - _mask.height)) + _mask.y, time: 1 } );
			
		}
		
		public function scroll(scroll_to:Number):void
		{
			if (scroll_to > 1) scroll_to = 1;
			_scrollbar.dispatchEvent(new ScrollBarEvent(scroll_to));
		}
		
		public function scrollamt(scroll_to:Number):void{
			var curamt = -((_content.y - _sb.y) / (_content.height - _mask.height));
			curamt -= (scroll_to / 10);
			if(curamt>1){
				curamt=1;
			}
			else if(curamt<0){
				curamt=0;
			}
			scroll(curamt)
			_scrollbar.scroll(curamt)
		}
		
		public function validate():void
		{
			if (_content.height > _mask.height)	_scrollbar.show();
			else								_scrollbar.hide();
			
			if (_content.height > _mask.height)
			{
				if ((_content.y + _content.height) < _mask.height)
				{
					var diff:Number = this._mask.height - (this._content.y + this._content.height);
					Tweener.addTween(this._content, { y: this._content.y + diff, time: .5, transition: 'easeOutQuart' } );
				}
				else
				{
					var percentScrolled:Number = (_mask.y - _content.y) / (_content.height - _mask.height);
					_scrollbar.scroll(percentScrolled);
				}
			}
			else if (_content.height < _mask.height && _content.y < _mask.y)
			{
				scroll(0);
				_scrollbar.reset();
			}
		}
		
		function onMouseWheelEvent(event:MouseEvent):void
		{
			if (_content.height > _mask.height )
			{
				var d=event.delta;
				scrollamt(d);
			}
		}
		
		public function get scrollbar():ScrollBar { return _scrollbar; }
		
		public function get content():MovieClip { return _content; }
		
		public function get mask():MovieClip { return _mask; }
		
		public function get instance():MovieClip { return _instance; }
	}
}