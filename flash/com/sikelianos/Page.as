package com.sikelianos {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;
	import com.sikelianos.*;
	import com.sikelianos.utils.*;
	import caurina.transitions.*;
	import com.rxr.currents.util.Inflector

	public class Page extends MovieClip {
	  
	  var _spaceBetweenBelongings:Number = 30;
		var _y_init:Number = 30;
		var _offset:Number = 0;
		
		var _belongings:XMLList;
		var _notes:XMLList;
		var _galleries:XMLList;
			
		public function Page() {
		  name = "page";
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		function init(e:Event) {
			adaptToScale(true);

			addEventListener(Event.ENTER_FRAME, enterFrameHandler)
			
			// Loader stuff
			var urlRequest:URLRequest = new URLRequest();
      urlRequest.url = Globals.vars.backpack_xml_url
			urlRequest.method = URLRequestMethod.GET;

			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, buildContent);
			urlLoader.load(urlRequest);			
		}
		

		function buildContent(e:Event):void {
		  // See sample.xml for example backpack XML structure
			var xml_data = new XML(e.target.data);
			_belongings = xml_data.page.belongings.belonging
      _notes = xml_data.page.notes.note
      _galleries = xml_data.page.galleries.gallery
      
      for each (var belonging:XML in _belongings) {
        var belonging_type = belonging.widget.@type.toLowerCase();
        var belonging_id = belonging.widget.@id;
        var belonging_parent = this["_" + Inflector.pluralize(belonging_type)] // e.g. this._notes, or this._galleries

        // Cycle through the _notes (or _galleries, etc) looking for the current note (or gallery, etc) by id
        for each (var belonging_data:XML in belonging_parent)  { 
          if (belonging_data.@id == belonging_id) {
            addChild(new Belonging(belonging_id, belonging_type, belonging_data));
          }
        }
      }
		}
		
		public function positionBelongings() {
		  var top_edge = 0;
		  var belonging = null;
		  for (var i=0; i<numChildren; i++) {
		    belonging = getChildAt(i);
		    belonging.y = top_edge;
		    top_edge += (belonging.height>0) ? (belonging.height + _spaceBetweenBelongings) : 0;
		  }
		}
		
		// public function seekOffset(offset:Number=0) {
		// 	if (offset != _offset) {
		// 		trace("seek offset: " + offset);
		// 		_offset = offset;
		// 		var child = getChildAt(offset);
		// 		var x_target = _y_init - child.x;
		// 		Tweener.addTween(this, {x:x_target, time:.5, transition:"easeInCubic"});
		// 	}
		// }

		function easeToY(y_target:Number) {
			var speed = 4;
			var delta = y - y_target;
			if (delta != 0) {
				y = y - (delta/speed);
				delta = y - y_target;
				if (delta < .25 && delta > -.25) {
					y = y_target;
					delta = 0;
				}
			}
		}
		
		private function enterFrameHandler(event:Event):void {
			if (numChildren > 0) {
				var child = getChildAt(_offset);
				var y_target = _y_init - child.y;
				easeToY(y_target);
			}
		}
		
		public function adaptToScale(firstRun:Boolean=false) {
			if (firstRun) {
				x = y = MovieClip(parent)._padding;
			}
		}
	}
}