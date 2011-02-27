package ssp {
	
	// Custom classes:
	import net.slideshowpro.slideshowpro.*;
	import me.hulse.util.FireTrace;
	
	/**
	* Props
	*        About: Setup SSP properties.
	*/
	public class Props {
		
		// Private:
		private var _ft:FireTrace;
		private var _mySsp:SlideShowPro;
		
		/**
		* Props()
		*        About: Class constructor.
		*      Returns: Nothing.
		*       @param: SlideShowPro object.
		*/
		public function Props(ssp:SlideShowPro) {
			
			_ft = new FireTrace();
			
			_ft.log('Props() instantiated...');
			
			_mySsp = ssp;
			
			init();
			
		};
		
		/**
		* init()
		*        About: Setup SSP properties.
		*      Returns: Nothing.
		*/
		private function init():void {
			
			/*
			** 
			** AS3: http://wiki.slideshowpro.net/SSPfl/API-ParameterList
			** Defaults: http://forums.slideshowpro.net/viewtopic.php?pid=64464#p64464
			** 
			** Notes: 
			**        * See "Params.as" class for variables set at runtime.
			**        * The SSP component has NOT been altered via the Component Inspector.
			** 
			*/
			
			_mySsp.directorLargeQuality = 100;                // Default: 80
			_mySsp.startup = "Load Album";                    // Default: "Open Gallery"
			_mySsp.albumPreviewStyle = "Banner";              // Default: "Inline Left"
			_mySsp.albumPreviewScale =  "Crop to Fit";        // Default: "Proportional"
			_mySsp.albumBackgroundAlpha = .75;                // Default: 1
			_mySsp.albumDescSize = 10;                        // Default: 9
			_mySsp.albumTitleSize = 12;                       // Default: 10
			_mySsp.albumPadding = 10;                         // Default: 8
			_mySsp.captionTextColor = 0x999999;               // Default: 0xEEEEEE
			_mySsp.captionHeaderBackgroundAlpha = .9;         // Default: .75
			_mySsp.captionTextSize = 12;                      // Default: 9
			_mySsp.contentFrameColor = 0x000000;              // Default: 0x262626
			_mySsp.contentFrameStrokeColor = 0x000000;        // Default: 0x333333
			_mySsp.contentAreaBackgroundColor = 0x000000;     // Default: 0x303030
			_mySsp.feedbackTimerAppearance = "Hidden";        // Default: "Visible"
			_mySsp.feedbackBackgroundAlpha = .1;              // Default: .4
			_mySsp.feedbackHighlightAlpha = .8;               // Default: 1
			_mySsp.galleryBackgroundAlpha = .9;               // Default: 1
			_mySsp.navAppearance = "Visible on Rollover";     // Default: "Always Visible"
			_mySsp.navGradientAppearance = "Hidden";          // Default: "Glass Dark"
			_mySsp.navThumbLinkSize = [30,30];                // Default: [20,20]
			_mySsp.cacheContent = "All";                      // Default: "None"
			_mySsp.fullScreenTakeOver = "Off";                // Default: "On"
			_mySsp.videoAutoStart = "Off";                    // Default: "On"
			_mySsp.videoBufferTime = 20;                      // Default: 5
			
		};
		
	};
	
};