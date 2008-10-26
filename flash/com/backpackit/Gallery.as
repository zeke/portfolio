// For the time being, gallery doesn't function as a gallery per se.
// It uses the first image in the gallery.

package com.backpackit {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*
	import flash.xml.*;
	import flash.net.*;
	import com.sikelianos.utils.*;

	public class Gallery extends MovieClip {
	  
	  var _borderThickness = 8;
    var _id:String
    var _file_name:String
    var _extension:String
    var _url:String
    
		public function Gallery() {
      addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event) {
		  constructImageUrl()			
      loadImage()
		}
		
		private function constructImageUrl() {
		  var image_xml = MovieClip(parent)._data.images.image
		  _id = image_xml.@id[0]
		  _file_name = image_xml.@file_name[0]
		  _extension = _file_name.split(".").pop()
      
      // ID needs to be broken into 4-character pieces, no more no less.
      // This is done to accomodate the lameness of AWS S3's lame-ass 'directory' structure.
		  var zeros_to_add = 8 - _id.length
		  var s3_id_string = _id
		  var i=0
		  while (i < zeros_to_add) {
		    s3_id_string = "0" + s3_id_string
		    i++
		  }
      s3_id_string = s3_id_string.substr(0, 4) + "/" + s3_id_string.substr(-4) // e.g. 0196/2057
      
		  // Example URL: http://sikelianos.backpackit.com/images/0196/2057/original.jpg/as/zeke_500.jpg      
		  _url = Globals.vars.base_image_url + s3_id_string + "/original." + _extension + "/as/" + _file_name
		}
		
    private function loadImage() {
			var loader:Loader = new Loader();
      configureListeners(loader.contentLoaderInfo);
			loader.load(new URLRequest(_url));
      addChild(loader);
    }
		
    private function configureListeners(dispatcher:IEventDispatcher):void {
      dispatcher.addEventListener(Event.COMPLETE, completeHandler);
      // dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, completeHandler);
      // dispatcher.addEventListener(Event.INIT, completeHandler);
      // dispatcher.addEventListener(IOErrorEvent.IO_ERROR, completeHandler);
      // dispatcher.addEventListener(Event.OPEN, completeHandler);
      // dispatcher.addEventListener(ProgressEvent.PROGRESS, completeHandler);
      // dispatcher.addEventListener(Event.UNLOAD, completeHandler);
    }

  	function completeHandler(event:Event):void {
  	  var img = event.target
      // trace("image loaded: " + img.width)
      // draw_border_around_image();
      MovieClip(this.parent.parent).positionBelongings();
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