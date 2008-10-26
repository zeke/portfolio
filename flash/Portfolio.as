package {
	import flash.display.*;
	import flash.events.*;
  import com.sikelianos.*
  import com.sikelianos.nav.*
  import com.sikelianos.utils.*
  import de.popforge.events.*

	public class Portfolio extends MovieClip {
		
		public var _padding = 30;
		public var _pageWidth = 500;
			
		public function Portfolio() {
      saveFlashVarsToGlobals()      
      configureStage()
      configureMouseHandlers()
      		  		  
			addChild(new Logo());
			addChild(new Nav());
			addChild(new Page());
			addChild(new Wheel());
		}
		
	  private function configureMouseHandlers() {
			SimpleMouseEventHandler.register(stage);
			stage.addEventListener(SimpleMouseEvent.PRESS, pressHandler);
			// stage.addEventListener(SimpleMouseEvent.RELEASE, releaseHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandler)
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
			// var page = MovieClip(parent).getChildByName("page");
			// _pageOffsetWhenActivated = page._offset;
			
      // addEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
		private function releaseHandler(event:MouseEvent):void {
			var wheel = MovieClip(getChildByName("wheel"));
			wheel.releaseHandler();
			trace ("no")
      // removeEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
    private function saveFlashVarsToGlobals() {
      var flash_vars = FlashVars.process(LoaderInfo(this.root.loaderInfo).parameters)
      for (var k in flash_vars) Globals.vars[k] = flash_vars[k]
    }
    
		private function configureStage() {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
	}
}