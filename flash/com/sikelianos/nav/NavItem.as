package com.sikelianos.nav {
	import flash.display.*;
	import flash.events.*;
	import de.popforge.events.*;
	import flash.xml.*;
	import com.sikelianos.nav.*
	import flash.text.*
	import caurina.transitions.*;

	public class NavItem extends MovieClip {
		
		var _lbl = null;		
		var _defaultColor = 0xCCCCCC;
		var _hoverColor = 0xCC0000;
		
		public function NavItem(lbl:String) {
		  name = "nav_item"
		  _lbl = lbl;
			addEventListener(Event.ADDED_TO_STAGE, init)
			
			// Button setup
			buttonMode = true; 
      mouseChildren = false;
			SimpleMouseEventHandler.register(this);
			addEventListener( SimpleMouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener( SimpleMouseEvent.ROLL_OUT, rollOutHandler);
			addEventListener( SimpleMouseEvent.PRESS, pressHandler);
			addEventListener( SimpleMouseEvent.RELEASE, releaseHandler);
			addEventListener( SimpleMouseEvent.RELEASE_OUTSIDE, releaseOutsideHandler);
		}
		
		function init(e:Event) {  
		  makeLabel();
			makeHitArea();
			setPos();
		}

		function makeLabel() {
      // Font
      var din:Font = new Din();
			var format:TextFormat = new TextFormat();
      format.font = din.fontName;
			format.color = _defaultColor;
			format.size = 23;
			
      // Text
      var txt = new TextField();
      txt.autoSize = TextFieldAutoSize.LEFT;
      txt.selectable = false;
      txt.embedFonts = true;
			txt.defaultTextFormat = format;

			txt.text = _lbl;
			addChild(txt);
		}
		
		function makeHitArea() {
  	  var txt = getChildAt(0);
      graphics.beginFill(0x00FF00, 0);
      graphics.drawRect(0, 0, width, height);
      graphics.endFill();
		}
		
		function setPos() {
		  var prev_item;
		  var i = parent.getChildIndex(this)
		  if (i>0) {
  		  prev_item = parent.getChildAt(i-1)
  		  x = prev_item.x + prev_item.width + MovieClip(parent)._item_spacing;
		  }
		}

		private function rollOverHandler(event:SimpleMouseEvent):void {
			Tweener.addTween(this, {_color:_hoverColor, time:.25, transition:"linear"});
		}
		
		private function rollOutHandler(event:SimpleMouseEvent):void {
			Tweener.addTween(this, {_color:_defaultColor, time:.25, transition:"linear"});
		}

		private function pressHandler(event:SimpleMouseEvent):void {
			// Click
		}
		
		private function releaseHandler(event:SimpleMouseEvent):void {	
      // Release
		}

		private function releaseOutsideHandler(event:SimpleMouseEvent):void {	
			releaseOutsideHandler(event);
      rollOutHandler(event);
		}
		
	}
}