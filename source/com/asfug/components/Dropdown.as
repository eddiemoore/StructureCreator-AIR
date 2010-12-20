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
	import com.asfug.events.DropdownEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Dropdown extends EventDispatcher
	{
		public static const DOWN:String = 'down';
		public static const UP:String = 'up';
		
		private var _mc:MovieClip;
		private var _itemArray:Array;
		private var _dropdownItem:Class;
		private var _direction:String;
		private var _dropdownOpen:Boolean;
		private var _title:TextField;
		private var _selectedIndex:int;
		private var _maskHeight:int;
		
		private var _itemsMc:Sprite;
		private var _mask:Shape;
		private var _barHeight:Number;
		private var _displayDefault:Boolean;
		private var _defaultText:String;
		/**
		 * Creates a Drop Down
		 * @param	mc				Movie Clip that will be the dropdown.
		 * @param	items			Array of items that will be in the drop down. Can be array of strings ["item 1", "item 2"] etc. or an array of objects [{label:"item 1", data:"1"},{label:"item 2", data:"2"}].
		 * @param	dropdownItem	Class that handles each item in the drop down. Must be the linkage from the library.
		 * @param	defaultText		Text that will display in the drop down by default.
		 * @param	displayDefaultInDropdown	Change if you want the default text is to be displayed in the dropdown or not.
		 * @param	direction		If the direction of the dropdown should be down or up.
		 * @param	maskHeight		If the dropdown requires a mask, set the mask height. If mask height is 0, full dropdown list will display.
		 */
		public function Dropdown(mc:MovieClip, items:Array, dropdownItem:Class, defaultText:String = 'Please Select', displayDefaultInDropdown:Boolean = true, direction:String = Dropdown.DOWN, maskHeight:int = 0 ) 
		{
			_mc = mc;
			_barHeight = _mc.height;
			
			_displayDefault = displayDefaultInDropdown;
			_defaultText = defaultText;
			if (_displayDefault)
			{
				items.unshift( { label:defaultText, data:'' } );
				_selectedIndex = 0;
			}
			else
			{
				_selectedIndex = -1;
			}
			_itemArray = items;
			_dropdownItem = dropdownItem;
			_direction = direction;
			_maskHeight = maskHeight;
			
			
			_dropdownOpen = false;
			
			_title = _mc.getChildByName('title_txt') as TextField;
			_title.mouseEnabled = false;
			_title.text = defaultText;
			
			enable();
		}
		
		public function disable():void
		{
			_mc.removeEventListener(MouseEvent.CLICK, dropDownClicked);
			_mc.buttonMode = false;
		}
		
		public function enable():void
		{
			_mc.addEventListener(MouseEvent.CLICK, dropDownClicked, false, 0, true);
			_mc.buttonMode = true;
		}
		/**
		 * When dropdown is clicked, open or close the dropdown.
		 * @param	e
		 */
		internal function dropDownClicked(e:MouseEvent):void 
		{
			if (_dropdownOpen)
				closeDropDown();
			else
				openDropDown();
		}
		
		/**
		 * Opens drop down menu
		 */
		public function openDropDown():void
		{
			_itemsMc = new Sprite();
			_itemsMc.name = 'dropdownItems_mc';
			if (_direction == Dropdown.DOWN)
			{
				_itemsMc.y = _mc.height;
				
				var yPos:Number = 0;
				for (var i:int = 0; i < _itemArray.length; ++i) 
				{
					var item:MovieClip = new _dropdownItem();
					item.y = yPos;
					item.name = 'item_' + i;
					item.mouseEnabled = true;
					
					var title:TextField = item.getChildByName('title_txt') as TextField;
					title.mouseEnabled = false;
					title.text = (typeof (_itemArray[i]) == "string" ? _itemArray[i] : _itemArray[i].label );
					
					item.addEventListener(MouseEvent.CLICK, itemSelected, false, 0, true);
					
					_itemsMc.addChild(item);
					yPos += item.height;
				}
				
				if (_maskHeight > 0 )
					createMask();
				
				_mc.addChild(_itemsMc);
			}
			_dropdownOpen = true;
			dispatchEvent(new DropdownEvent(DropdownEvent.OPENED_DROP_DOWN));
		}
		/**
		 * Creates mask for drop down items.
		 * Initialises scrolling
		 */
		private function createMask():void
		{
			_mask = new Shape();
			_mask.name = 'masker';
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, _itemsMc.width, _maskHeight);
			_mask.graphics.endFill();
			
			_mask.x = _itemsMc.x;
			_mask.y = _itemsMc.y;
			_mc.addChild(_mask);
			
			_itemsMc.mask = _mask;
			
			_itemsMc.addEventListener(Event.ENTER_FRAME, moveItems);
		}
		/**
		 * If there is a mask on the dropdown move items up and down depending on mouse position.
		 * @param	e
		 */
		private function moveItems(e:Event):void 
		{
			if (_mask.mouseY > _maskHeight * 0.5)
			{
				if (_itemsMc.y <= (_mask.y - _itemsMc.height) + _maskHeight + 2)
					_itemsMc.y = (_mask.y - _itemsMc.height) + _maskHeight;
				else
					_itemsMc.y += 0.2 * -(_mask.mouseY - _maskHeight * .5);
			}
			else if (_mask.mouseY < _maskHeight * 0.5)
			{
				if (_itemsMc.y >= _barHeight)
					_itemsMc.y = _barHeight;
				else
					_itemsMc.y += 0.2 * -(_mask.mouseY - _maskHeight * .5);
			}
		}
		/**
		 * On selection of item set the current selected index and set label
		 * @param	e
		 */
		internal function itemSelected(e:MouseEvent):void 
		{
			var name:String = e.currentTarget.name;
			var si:int = int(name.split('_')[1]);
			if (_selectedIndex != si)
			{
				_selectedIndex = si;
				dispatchEvent(new DropdownEvent(DropdownEvent.ITEM_CHANGED));
			}
			_title.text = getSelectedLabel();
		}
		/**
		 * Closes the drop down menu
		 */
		public function closeDropDown():void
		{
			trace('calsld');
			if (_mc.getChildByName('masker') as Shape)
			{
				_itemsMc.removeEventListener(Event.ENTER_FRAME, moveItems);
				_mc.removeChild(_mc.getChildByName('masker') as Shape);
			}
				
			if (_itemsMc)
			{
				while (_itemsMc.numChildren > 0)
				{
					var item:DisplayObject = _itemsMc.getChildAt(0);
					item.removeEventListener(MouseEvent.CLICK, itemSelected);
					_itemsMc.removeChildAt(0);
				}
				_mc.removeChild(_itemsMc);
				_itemsMc = undefined;
			}
			
			_dropdownOpen = false;
			dispatchEvent(new DropdownEvent(DropdownEvent.CLOSED_DROP_DOWN));
		}
		/**
		 * Gets the currently selected items index
		 * @return	Selected item index value
		 */
		public function getSelectedIndex():int { return _selectedIndex; }
		/**
		 * Gets the currently selected items name
		 * @return	Selected item name
		 */
		public function getSelectedLabel():String 
		{ 
			if (_selectedIndex > -1)
			{
				if (typeof (_itemArray[_selectedIndex]) == "string")
					return _itemArray[_selectedIndex]; 
				else
					return _itemArray[_selectedIndex].label;
			}
			else
			{
				return _title.text;
			}
		}
		/**
		 * Gets currently selected items data
		 * @return	Selected item data
		 */
		public function getSelectedData():String 
		{ 
			if (typeof (_itemArray[_selectedIndex]) == "string")
				return _itemArray[_selectedIndex]; 
			else
				return _itemArray[_selectedIndex].data;
		}
		/**
		 * Sets the selected item to specific value in item array
		 * @param	index	Index value of item in item array
		 */
		public function setSelectedIndex(index:int):void 
		{
			_selectedIndex = index;
			dispatchEvent(new DropdownEvent(DropdownEvent.ITEM_CHANGED));
			_title.text = getSelectedLabel();
		}
		
		public function getDisplayDefault():Boolean { return _displayDefault; }
		
		public function getDefaultText():String { return _defaultText; }
		
		public function get direction():String { return _direction; }
		
		public function get itemArray():Array { return _itemArray; }
		
		public function get dropdownOpen():Boolean { return _dropdownOpen; }
		
		public function set dropdownOpen(value:Boolean):void 
		{
			_dropdownOpen = value;
		}
		
	}

}