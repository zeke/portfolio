package com.sikelianos.nav {
	import flash.display.*;
	import flash.events.*;
	import flash.xml.*;
	import com.sikelianos.nav.*

	public class Nav extends MovieClip {
		
		public var _item_spacing = 6;
		
		public function Nav() {
		  name = "nav"
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		function init(e:Event) {
		  adaptToScale();
      attachNavItems();		  
		}
		
		function attachNavItems() {
		  var item = null
		  var item_names:Array = new Array("MANIFESTO", "PORTFOLIO", "ACCOLADES", "RANDOM")
		  for (var i=0; i<item_names.length; i++) {
        item = new NavItem(item_names[i]);
		    addChild(item);
		  }
		}
		
		public function adaptToScale() {
			var logo = MovieClip(parent.getChildByName("logo"));
      x = logo.x;
      y = logo.y + 60;
		}
		
	}
}