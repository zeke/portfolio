package com.sikelianos {
	import flash.display.*;
	import flash.events.*;
	import flash.xml.*;
	import com.tumblr.types.*
	import com.backpackit.*

	public class Post extends MovieClip {
			
		public var _type:String
		public var _data:XML
		var _prevPost = null
		var _nextPost = null
		
		public function Post(type:String, data:XML) {
      _type = type
		  _data = data
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		public function init(e:Event) {
		  setPrevPost();
		  
		  var guts = null;
			switch(_type) {
				case "note":
          guts = new Note();
					break;
				// case "gallery":
				// 	guts = new Gallery();
				// 	break;
				default:
					trace("unknown post type: " _type);
			}
			
			if (guts != null) {
			  trace("add gut child")
			  guts.name = "guts";
        addChild(guts);
			}
			
		}
		
		function setPrevPost() {
		  var i = parent.getChildIndex(this)
		  if (i>0) {
  		  _prevPost = parent.getChildAt(i-1)
  		  _prevPost.setNextPost();
		  }
		}
		
		function setNextPost() {
		  var i = parent.getChildIndex(this)
  		_nextPost = parent.getChildAt(i+1)
		}
					
	}
}