package ssp {
	
	// Imports:
	import flash.net.URLVariables;
	
	// Custom classes:
	import net.slideshowpro.slideshowpro.*;
	import me.hulse.util.FireTrace;
	
	/**
	* Kind
	*        About: Used to determine if album or gallery is being requested.
	*/
	public class Kind {
		
		// Private:
		private var _ft:FireTrace;
		private var _mySsp:SlideShowPro;
		
		/**
		* Main()
		*        About: Class constructor.
		*      Returns: Nothing.
		*       @param: SlideShowPro object.
		*/
		public function Kind(ssp:SlideShowPro) {
			
			_ft = new FireTrace();
			
			_ft.log('Kind() instantiated...');
			
			_mySsp = ssp;
			
			init();
			
		};
		
		/**
		* init()
		*        About: Determine if gallery or album is being loaded.
		*      Returns: Nothing.
		*/
		private function init():void {
			
			/*
			** 
			** This method determines if an album or gallery is loaded.
			** If album, we want to skip the gallery view and modify the skin to hide gallery controls.
			** 
			*/
			
			var url:String = _mySsp.xmlFilePath;
			
			var variables:URLVariables = new URLVariables(url.replace(/.+\?/, ''));
			
			for (var key:* in variables) {
				
				// Album?
				if (key == 'album') {
					
					_mySsp.navButtonsAppearance = 'Hide Gallery Control'; // Hide 'gallery' icon:
					_mySsp.galleryAppearance = "Hidden"; // Make sure the gallery is hidden.
					
					if (_mySsp.xmlFileType == 'Default') {
						
						// Custom feed:
						trace('Default, ' + key + '-' + variables[key]);
						
						_mySsp.setStartAlbum(variables[key], 0); // Custom feed sans "album-".
						
					} else {
						
						// SSP Director:
						trace('Director, ' + key + '-' + variables[key]);
						
						_mySsp.setStartAlbum(key + '-' + variables[key], 0); // Director feed with "album-" prepended.
						
					}
					
					break; // Quit the loop.
					
				} else if (key == 'gallery') {
					
					// Turn on keyboard control:
					_mySsp.keyboardControl = 'On'; // On/Off.
					
					break; // Quit the loop.
					
				}
				
			}
			
		};
		
	};
	
};