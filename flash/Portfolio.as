package {
	import flash.display.*;
	import flash.events.*;
  import com.sikelianos.*
  import com.sikelianos.nav.*
  import de.popforge.events.*

	public class Portfolio extends MovieClip {
		
		public var _padding = 30;
		public var _meatWidth = 500;
			
		public function Portfolio() {

       // Configure stage
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.addEventListener(Event.RESIZE, resizeHandler);

			
			SimpleMouseEventHandler.register(stage);
			stage.addEventListener(SimpleMouseEvent.PRESS, pressHandler);
			// stage.addEventListener(SimpleMouseEvent.RELEASE, releaseHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandler)
		  		  
			addChild(new Logo());
			addChild(new Nav());
			addChild(new Meat());
			addChild(new Wheel());
		}
		
		function resizeHandler(event:Event) {
		  var child = null;
		  for (var i=0; i<numChildren; i++) {
		    child = getChildAt(i);
		    child.adaptToScale();
		  }
		}
		
		private function pressHandler(event:SimpleMouseEvent):void {
			trace ("yes")
			var wheel = MovieClip(getChildByName("wheel"));
			wheel.pressHandler();
      // _rotationChangeSinceActivated = 0;
			// var meat = MovieClip(parent).getChildByName("meat");
			// _meatOffsetWhenActivated = meat._offset;
			
      // addEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
		private function releaseHandler(event:MouseEvent):void {
			var wheel = MovieClip(getChildByName("wheel"));
			wheel.releaseHandler();
			trace ("no")
      // removeEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
	}
}