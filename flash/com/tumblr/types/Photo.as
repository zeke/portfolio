package com.tumblr.types {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*
	import flash.xml.*;
	import flash.net.*;

	public class Photo extends MovieClip {
	  
	  var _borderThickness = 8;
    
		public function Photo() {			
		}
		
		public function init() {
			var url:String = MovieClip(parent)._data["photo-url"][0];
			var loader:Loader = new Loader();
      configureListeners(loader.contentLoaderInfo);
			loader.load(new URLRequest(url));
      
      addChild(loader);
		}
		
    private function configureListeners(dispatcher:IEventDispatcher):void {
        dispatcher.addEventListener(Event.COMPLETE, completeHandler);
/*        dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, completeHandler);*/
/*        dispatcher.addEventListener(Event.INIT, completeHandler);*/
/*        dispatcher.addEventListener(IOErrorEvent.IO_ERROR, completeHandler);*/
/*        dispatcher.addEventListener(Event.OPEN, completeHandler);*/
/*        dispatcher.addEventListener(ProgressEvent.PROGRESS, completeHandler);*/
/*        dispatcher.addEventListener(Event.UNLOAD, completeHandler);*/
    }

  	function completeHandler(event:Event):void {
  	  var img = event.target
      // trace("image loaded: " + img.width)
      // draw_border_around_image();
      MovieClip(this.parent.parent).positionPosts();
  	}
  	
  	function draw_border_around_image() {
  	  var img = getChildAt(0)
      var w = img.width + _borderThickness*2;
      var h = img.height + _borderThickness*2;

      graphics.beginFill(0x00FF00);
      graphics.drawRect(0, 0, w, h);
      graphics.endFill();
      
      img.x = img.y = _borderThickness;
  	}


				
	}
}