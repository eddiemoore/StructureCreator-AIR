package com.asfug.components 
{
	import com.asfug.events.DropdownEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class DropDownScroll extends Dropdown
	{
		private var _scrollbox:ScrollBox;
		private var _mc:MovieClip;
		private var _dropdownItem:Class;
		private var _mcHeight:Number;
		
		public function DropDownScroll(mc:MovieClip, items:Array, dropdownItem:Class, scrollbox:ScrollBox, defaultText:String = 'Please Select', displayDefaultInDropdown:Boolean = true, direction:String = Dropdown.DOWN, maskHeight:int = 0) 
		{
			_mc = mc;
			_mcHeight = _mc.height;
			_scrollbox = scrollbox;
			_scrollbox.instance.name = 'sb';
			_dropdownItem = dropdownItem;
			super(mc, items, dropdownItem, defaultText, displayDefaultInDropdown, direction, maskHeight);
			
			addEventListener(DropdownEvent.ITEM_CHANGED, itemChanged);
		}
		
		private function itemChanged(e:DropdownEvent):void 
		{
			closeDropDown();
		}
		
		override internal function dropDownClicked(e:MouseEvent):void 
		{
			if (dropdownOpen)
			{
				if (_mc.mouseY <= _mcHeight)
				{
					closeDropDown();
				}
			}
			else
			{
				if (_mc.mouseY <= _mcHeight)
				{
					openDropDown();
				}
			}
		}
		
		override public function openDropDown():void 
		{
			if (direction == Dropdown.DOWN)
			{
				var b:MovieClip = _scrollbox.instance;
				b.y = _mc.height;
				
				var yPos:Number = 0;
				var item:MovieClip;
				var title:TextField;
				for (var i:int = 0; i < itemArray.length; i++) 
				{
					item = new _dropdownItem();
					item.y = yPos;
					item.name = 'item_' + i;
					item.mouseEnabled = true;
					
					title = item.getChildByName('title_txt') as TextField;
					title.mouseEnabled = false;
					title.text = (typeof (itemArray[i]) == "string" ? itemArray[i] : itemArray[i].label );
					
					item.addEventListener(MouseEvent.CLICK, itemSelected, false, 0, true);
					
					_scrollbox.content.addChild(item);
					yPos += item.height;
				}
				
				_mc.addChild(_scrollbox.instance);
			}
			dropdownOpen = true;
			dispatchEvent(new DropdownEvent(DropdownEvent.OPENED_DROP_DOWN));
		}
		
		override public function closeDropDown():void
		{
			if (_mc.getChildByName('sb'))
			{
				while (_scrollbox.content.numChildren > 0)
				{
					var item:DisplayObject = _scrollbox.content.getChildAt(0);
					item.removeEventListener(MouseEvent.CLICK, itemSelected);
					_scrollbox.content.removeChildAt(0);
				}
				_mc.removeChild(_scrollbox.instance);
			}
			dropdownOpen = false;
			dispatchEvent(new DropdownEvent(DropdownEvent.CLOSED_DROP_DOWN));
		}
		
	}

}