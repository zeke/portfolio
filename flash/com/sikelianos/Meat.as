package com.sikelianos {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;
	import com.sikelianos.*;
	import caurina.transitions.*;

	import com.abdulqabiz.crypto.Base64;
	



	public class Meat extends MovieClip {
	  
	  var _spaceBetweenPosts:Number = 30;
		var _y_init:Number = 30;
		var _offset:Number = 0;
		
		var _belongings:XMLList;
		var _notes:XMLList;
		var _galleries:XMLList;
			
		public function Meat() {
		  name = "meat";
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		function init(e:Event) {
			adaptToScale(true);

			addEventListener(Event.ENTER_FRAME, enterFrameHandler)
			
			// Loader stuff
			var urlRequest:URLRequest = new URLRequest();
			// urlRequest.url = "http://zeke.sikelianos.com/portfolio/backpack_to_xml.php";
			urlRequest.url = "test.xml";
			urlRequest.method = URLRequestMethod.GET;

			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, buildContent);
			urlLoader.load(urlRequest);			
		}
				

		function buildContent(e:Event):void {
			var xml_data = new XML(e.target.data);
			
			_belongings:XMLList = xml_data.page.belongings.belonging
			_notes:XMLList = xml_data.page.notes.note
			_galleries:XMLList = xml_data.page.galleries.gallery
			
			for each (var postData:XML in _belongings) {
				var post:Post = new Post(postData)
				addChild(post);
			}
		}
		
		public function positionPosts() {
		  var top_edge = 0;
		  var post = null;
		  for (var i=0; i<numChildren; i++) {
		    post = getChildAt(i);
		    post.y = top_edge;
		    top_edge += (post.height>0) ? (post.height + _spaceBetweenPosts) : 0;
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