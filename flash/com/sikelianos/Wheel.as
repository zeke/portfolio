package com.sikelianos {
	import flash.display.*;
	import flash.events.*;
  import de.popforge.events.*
  import com.sikelianos.*

	public class Wheel extends MovieClip {
		
		var _rotationChangeSinceActivated = null;
		var _meatOffsetWhenActivated;
		var _lastAngle = null;
		
		public function Wheel() {
		  name = "wheel"

			// Button setup
			buttonMode = true; 
      mouseChildren = false;
			SimpleMouseEventHandler.register(this);
			addEventListener( SimpleMouseEvent.PRESS, pressHandler);
			addEventListener( SimpleMouseEvent.RELEASE, releaseHandler);
			addEventListener( SimpleMouseEvent.RELEASE_OUTSIDE, releaseHandler);
			
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		function init(e:Event) {
		  drawWheel();
		  adaptToScale();
		}
		
	  // This is the visual component of the wheel. It is contained as a child so
	  // it can rotate freely without changing the rotation of the "conceptual" wheel
		private function drawWheel() {
      var w:Shape = new Shape();    		
		  w.name = "wheel_display"
		  
		  var r_outer:Number = 60;
			var r_inner:Number = 30;

      // Draw outer circle
      w.graphics.beginFill(0x000000, .1);
      w.graphics.drawCircle(0, 0, r_outer);
      w.graphics.endFill();

			// Draw inner circle
      w.graphics.beginFill(0xFFFFFF);
      w.graphics.drawCircle(0, 0, r_inner);
      w.graphics.endFill();

      // Draw 'pointer' circle
      w.graphics.beginFill(0x000000, .1);      
      w.graphics.drawCircle(0, -r_outer, 5);
      w.graphics.endFill();
      
      // Draw Lines through circle
      w.graphics.lineStyle(2, 0xFFFFFF, 1);
      w.graphics.moveTo(-r_outer, 0)
      w.graphics.lineTo(r_outer, 0);
      w.graphics.moveTo(0, -r_outer);
      w.graphics.lineTo(0, r_outer);

			var br_x = r_outer * Math.cos(45 * Math.PI/180)      
			var br_y = r_outer * Math.sin(45 * Math.PI/180)
			
			var tl_x = -br_x;
			var tl_y = -br_y; 
			
			var tr_x = br_x;
			var tr_y = -br_y;
			
			var bl_x = -br_x
			var bl_y = br_y
			w.graphics.moveTo(tl_x, tl_y)
			w.graphics.lineTo(br_x, br_y);
			
			w.graphics.moveTo(tr_x, tr_y)
			w.graphics.lineTo(bl_x, bl_y)

      this.addChild(w);
    }
		
/*		
		private function pressHandler(event:SimpleMouseEvent):void {
      _rotationChangeSinceActivated = 0;
			var meat = MovieClip(parent).getChildByName("meat");
			_meatOffsetWhenActivated = meat._offset;
			
      addEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
		private function releaseHandler(event:SimpleMouseEvent):void {	
      removeEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
	*/
	
		public function pressHandler():void {
	    _rotationChangeSinceActivated = 0;
			var meat = MovieClip(parent).getChildByName("meat");
			_meatOffsetWhenActivated = meat._offset;
	    addEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
	
		public function releaseHandler():void {	
	    removeEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
		private function enterFrameHandler(event:Event):void {
		  
      // Tricky rotation/positioning code put together with help from...
      // http://www.bezzmedia.com/swfspot/samples/advanced/iPod_Style_Wheel_Slider
  		
  		// Calculate the angle from the center of the wheel to the mouse
      var angle:Number = Math.round(Math.atan(mouseY/mouseX)/(Math.PI/180));
      angle += (mouseX<0) ? 180 : 0;
      angle += (mouseX>=0 && mouseY<0) ? 360 : 0;
  
		  // Check if the wheel was active on the last enterframe
			// If so, account for when the angle crosses from 0 to 360 or 360 to 0
			_rotationChangeSinceActivated += (_lastAngle!=null && Math.abs(_lastAngle-angle) < 180) ? (_lastAngle - angle) : 0;

  		// if the angle has changed since the last enterframe, store the current angle
 			// so it can be compared to the angle in the next frame
  		if (_lastAngle != angle) {
  		  _lastAngle = angle;
  		  getChildByName("wheel_display").rotation = _lastAngle;
				
				moveTheMeat();
  		}
		}
		
		function moveTheMeat() {
			var meat = MovieClip(parent).getChildByName("meat");

			// 1 offset unit per 45 degrees of wheel rotation..
			var offset_change = _rotationChangeSinceActivated/45;
			
			// round the offset up or down (depending on sign)
			offset_change = (_rotationChangeSinceActivated > 0) ? Math.floor(offset_change) : Math.ceil(offset_change);
			
			
			var offset = _meatOffsetWhenActivated - offset_change;
			
			// Keep offset within meat's bounds..
			offset = (offset < 0) ? 0 : offset;
			offset = (offset >= meat.numChildren) ? meat.numChildren - 1 : offset;
			
			// Tell the meat to move!
			if (offset != meat._offset) {
				// meat.seekOffset(offset);
				meat._offset = offset;
			}
		}
		
		public function adaptToScale() {
			var logo = MovieClip(parent.getChildByName("logo"));
      x = logo.x + logo.width/2;
      y = logo.y + 250;
		}
		
	}
}