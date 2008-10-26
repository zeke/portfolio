package com.sikelianos {
	import flash.display.*;
	import flash.events.*;
	import flash.xml.*;
  // import com.tumblr.types.*
	import com.backpackit.*
	import com.sikelianos.utils.*;

	public class Belonging extends MovieClip {

		public var _id:String			
		public var _type:String
		public var _data
		var _prevBelonging = null
		var _nextBelonging = null
		
		public function Belonging(id:String, type:String, data) {
      _id = id
      _type = type
		  _data = data
			addEventListener(Event.ADDED_TO_STAGE, setPreviousBelonging)
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		public function init(e:Event) {
		  var guts = null;
			switch(_type) {
				case "note":
          guts = new Note();
					break;
        case "gallery":
          guts = new Gallery();
          break;
				default:
					trace("unknown belonging type: " + _type);
			}
			
			if (guts != null) {
			  guts.name = "guts";
        addChild(guts);
			}
			
		}
		
		function setPreviousBelonging(e:Event) {
		  var i = parent.getChildIndex(this)
		  if (i>0) {
  		  _prevBelonging = parent.getChildAt(i-1)
  		  _prevBelonging.setNextBelonging();
		  }
		}
		
		function setNextBelonging() {
		  var i = parent.getChildIndex(this)
  		_nextBelonging = parent.getChildAt(i+1)
		}
					
	}
}