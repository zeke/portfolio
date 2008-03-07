package com.sikelianos {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;
	import com.sikelianos.*
	import flash.text.*

	public class Logo extends MovieClip {
				
		public function Logo() {
		  name = "logo"
			addEventListener(Event.ADDED_TO_STAGE, init)
			
      // Font
      var din:Font = new Din();
			var format:TextFormat = new TextFormat();
      format.font = din.fontName;
			format.color = 0x000000;
			format.size = 60;
			format.leading = 0;
			
      // Text
      var txt = new TextField();
      txt.autoSize = TextFieldAutoSize.LEFT;
      txt.selectable = false;
      txt.embedFonts = true;
			txt.defaultTextFormat = format;

			txt.text = "ZEKE SIKELIANOS";
			addChild(txt);
		}
		
		function init(e:Event) {
		  adaptToScale();
		}
		
		public function adaptToScale() {
			var padding = MovieClip(parent)._padding;
			var meatWidth = MovieClip(parent)._meatWidth;
			var right_edge_of_meat = meatWidth + padding*2;
			x = right_edge_of_meat;
			y = 30 + height/2;
		}
		
	}
}