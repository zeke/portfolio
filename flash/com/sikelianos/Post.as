package com.sikelianos {
	import flash.display.*;
	import flash.events.*;
	import flash.xml.*;
	import com.tumblr.types.*

	public class Post extends MovieClip {
			
		public var _data:XML;
		var _prevPost = null;
		var _nextPost = null;
		
		public function Post(postData:XML) {
		  _data = postData;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event) {
		  setPrevPost();
		  
		  var guts = null;
		  var postType:String = _data.widget.attribute("type");
			trace ("postType: " + postType);
			switch(postType) {
				case "note":
			          guts = new Note();
					break;
				// case "gallery":
				// 	guts = new Gallery();
				// 	break;
				default:
					trace("unknown post type");
			}
			
			if (guts) {
			  guts.name = "guts";
        addChild(guts);
        guts.init();
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