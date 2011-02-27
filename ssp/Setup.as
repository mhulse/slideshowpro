package ssp {
	
	// Imports:
	import flash.display.DisplayObject;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	
	// Custom classes:
	import net.slideshowpro.slideshowpro.*;
	import me.hulse.util.FireTrace;
	import me.hulse.util.Stager;
	
	/**
	* Setup
	*        About: SSP setups.
	*/
	public class Setup {
		
		// Private:
		private var _this:DisplayObject;
		private var _fdb:FireTrace;
		private var _mySsp:SlideShowPro;
		private var _xPad:int = 0;
		private var _yPad:int = 0;
		
		/**
		* Setup()
		*        About: Class constructor.
		*      Returns: Nothing.
		*/
		public function Setup(t:DisplayObject, ssp:SlideShowPro) {
			
			_fdb = new FireTrace();
			
			_fdb.log('Setup() instantiated...');
			
			_this = t;
			_mySsp = ssp;
			
			init();
			
		};
		
		/**
		* init()
		*        About: Hangles stage and player resizing.
		*      Returns: Nothing.
		*/
		private function init():void {
			
			new Stager(_this, "NO_SCALE", "TOP_LEFT"); // Setup stage.
			sizer();
			events();
			
		};
		
		/**
		* sizer()
		*        About: Resizes SSP instance to fit stage width and height.
		*      Returns: Nothing.
		*/
		private function sizer():void {
			
			_fdb.log('sizer()...');
			
			// http://forums.slideshowpro.net/viewtopic.php?pid=59472#p59472
			var sw:int = Math.ceil(_this.stage.stageWidth);
			var sh:int = Math.ceil(_this.stage.stageHeight);
			var ssp_w:int = Math.round(sw - (_xPad*2));
			var ssp_h:int = Math.round(sh - (_yPad*2));
			_mySsp.x = _xPad;
			_mySsp.y = _yPad;
			_mySsp.setSize(ssp_w, ssp_h);
			
		};
		
		/**
		* events()
		*        About: Event Listener setups.
		*      Returns: Nothing.
		*/
		private function events():void {
			
			_this.stage.addEventListener(Event.RESIZE, onResizeStage); // Do not add the extra parameters for this listener.
			_this.stage.dispatchEvent(new Event(Event.RESIZE));
			
			_mySsp.stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreenRedraw, false, 0, true);
			
		};
		
		/**
		* onFullScreenRedraw()
		*        About: Event Listener method.
		*      Returns: Nothing.
		*       @param: FullScreen event.
		*/
		private function onFullScreenRedraw(e:FullScreenEvent):void {
			
			if (e.fullScreen) {
				
				trace('Full screen mode enabled.');
				
			} else {
				
				trace('Full screen mode disabled');
				
				sizer();
				
			}
			
		};
		
		/**
		* onResize()
		*        About: Event Listener method.
		*      Returns: Nothing.
		*       @param: Resize event.
		*/
		private function onResizeStage(e:Event):void {
			
			sizer();
			
		};
		
	};
	
};