package ssp {
	
	// Imports:
	import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	
	// Custom classes:
	import net.slideshowpro.slideshowpro.*;
	
	/**
	* Params
	*        About: Setup SSP parameters.
	*/
	public class Params {
		
		private var _this:DisplayObject;
		private var _mySsp:SlideShowPro;
		
		/**
		* Params()
		*        About: Class constructor.
		*      Returns: Nothing.
		*       @param: Reference to "this".
		*       @param: SlideShowPro object.
		*/
		public function Params(t:DisplayObject, ssp:SlideShowPro) {
			
			_this = t;
			_mySsp = ssp;
			
			init();
			
		};
		
		/**
		* init()
		*        About: Determine SSP parameters passed via embed code.
		*      Returns: Nothing.
		*/
		private function init():void {
			
			var paramObj:Object = LoaderInfo(_this.root.loaderInfo).parameters;
			
			if (paramObj.xmlFilePath) {
				_mySsp.xmlFilePath = paramObj.xmlFilePath;
			} else {
				// Testing:
				//_mySsp.xmlFilePath = 'http://mhulse.slideshowpro.com/images.php?album=65105';
				//_mySsp.xmlFilePath = 'http://mhulse.slideshowpro.com/images.php?album=86696';
				//_mySsp.xmlFilePath = 'http://mhulse.slideshowpro.com/images.php?album=87810' // Video.
				//_mySsp.xmlFilePath = 'http://rgweb.slideshowpro.com/images.php?album=164579';
				//_mySsp.xmlFilePath = 'http://mhulse.slideshowpro.com/images.php?album=164194';
			}
			if (paramObj.xmlFileType) {
				_mySsp.xmlFileType = paramObj.xmlFileType; // Default, Director, Media RSS, OPML
			} else {
				_mySsp.xmlFileType = 'Director';
			}
			if (paramObj.transitionPause) {
				_mySsp.transitionPause = paramObj.transitionPause;
			} else {
				_mySsp.transitionPause = 10; // In seconds.
			}
			if (paramObj.transitionLength) {
				_mySsp.transitionLength = paramObj.transitionLength;
			} else {
				_mySsp.transitionLength = 2; // In seconds.
			}
			if (paramObj.transitionStyle) {
				_mySsp.transitionStyle = paramObj.transitionStyle;
			} else {
				_mySsp.transitionStyle = "Cross Fade";
			}
			if (paramObj.albumPreviewSize) {
				var array:Array = paramObj.albumPreviewSize.split(','); // Convert param string to array.
				_mySsp.albumPreviewSize = array;
			} else {
				_mySsp.albumPreviewSize = [120,120];
			}
			if (paramObj.galleryColumns) {
				_mySsp.galleryColumns = paramObj.galleryColumns;
			} else {
				_mySsp.galleryColumns = 2;
			}
			if (paramObj.galleryRows) {
				_mySsp.galleryRows = paramObj.galleryRows;
			} else {
				_mySsp.galleryRows = 2;
			}
			if (paramObj.navLinkAppearance) {
				_mySsp.navLinkAppearance = paramObj.navLinkAppearance; // Thumbnails, Numbers.
			} else {
				_mySsp.navLinkAppearance = "Thumbnails";
			}
			if (paramObj.contentFramePadding) {
				_mySsp.contentFramePadding = paramObj.contentFramePadding;
			} else {
				_mySsp.contentFramePadding = 50;
			}
			
		};
		
	};
	
};