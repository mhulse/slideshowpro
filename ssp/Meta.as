package ssp {
	
	// Imports:
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	
	// Custom classes/dependancies:
	import me.hulse.util.FireTrace;
	import jp.shichiseki.exif.*; // http://code.shichiseki.jp/as3/ExifInfo/
	import net.slideshowpro.slideshowpro.*;
	
	/**
	* Props
	*        About: Setup SSP GPS class.
	*/
	public class Meta {
		
		// Private:
		private var _ft:FireTrace;
		private var _loader:ExifLoader;
		private var _mySsp:SlideShowPro;
		
		/**
		* Meta()
		*        About: Class constructor.
		*      Returns: Nothing.
		*/
		public function Meta(ssp:SlideShowPro) {
			
			_ft = new FireTrace();
			
			_ft.log("Meta() instantiated...");
			
			_mySsp = ssp;
			
			init();
			
		};
		
		/**
		* init()
		*        About: Determine if gallery or album is being loaded.
		*      Returns: Nothing.
		*/
		private function init():void {
			
			if (ExternalInterface.available) {
				
				// Check if the javascript "sspGpsMap" object exists:
				var isJs:String = ExternalInterface.call("function isJs() { if (typeof sspGpsMap === 'object') { return 'yes'; } }") as String;
				
				if (isJs == "yes") {
					
					// Yes, "exifGps" is there, so let's continue:
					_mySsp.addEventListener(SSPDataEvent.IMAGE_DATA, onSlideShowData);
					
				} else {
					
					_ft.log("We're sorry, but the javascript function \"sspGpsMap\" object not exist.");
					
				}
				
			}
			
		};
		
		/**
		* onSlideShowData()
		*        About: Dispatched immediately after slideshow content (video or image) is requested. Contains data about the content being loaded.
		*      Returns: Nothing.
		*       @param: An object containing data for the currently loaded image or video.
		*/
		private function onSlideShowData(e:SSPDataEvent):void {
			
			if (e.type == "imageData") {
				
				// Get uri:
				var uri = e.data.link;
				
				// Debug:
				_ft.log(e.data.link);
				
				// Test for link:
				if (uri != undefined) {
					
					// Determine if URI has a "q" parameter:
					if (uri.indexOf("?") >= 0) {
						
						// In SSP Director, set link to "Show location on map (requires GPS data)".
						
						var loc = uri.split("&q=loc:")[1].split(" "); // lat/lon.
						
						// Debug:
						_ft.log(loc[0] + ", " + loc[1]);
						
						// Call javascript function "sspGpsMap.gps()":
						ExternalInterface.call("sspGpsMap.gps", this.trim(loc[1]), this.trim(loc[0]));
						
					} else {
						
						// Default is image URI.
						// In SSP Director, set link to "Download original image".
						
						this.loadImage(uri);
						
					}
					
				}
				
			}
			
		};
		
		/**
		* loadImage()
		*        About: Image loader for Exif class.
		*      Returns: Nothing.
		*       @param: URI to SSP-Director source image.
		*/
		private function loadImage(uri:String):void {
			
			_loader = new ExifLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			_loader.load(new URLRequest(uri));
			
		};
		
		/**
		* onComplete()
		*        About: Event method for Exif image loading.
		*      Returns: Nothing.
		*       @param: Event data.
		*/
		private function onComplete(e:Event):void {
			
			// Garbage collection:
			_loader.removeEventListener(Event.COMPLETE, onComplete);
			
			// Check for GPS data:
			if (_loader.exif.ifds.gps) {
				
				// Return gps data:
				this.displayIfdGps(_loader.exif.ifds.gps);
				
			}
			
		};
		
		/**
		* displayIfdGps()
		*        About: Calculates GPS data and calls "exifGps" javascript function.
		*      Returns: Nothing.
		*       @param: GPS object.
		*/
		private function displayIfdGps(ifd):void {
			
			/*
			** 
			** http://www.gpsdiscussion.com/general-gps-discussion/6180-need-help-translating-gps-info.html
			** Example data:
			** 
			** GPSVersionID: 2,2,0,0
			** GPSLongitude: 122,42,47.79
			** GPSLongitudeRef: W
			** GPSTimeStamp: 21,57,9
			** GPSLatitude: 45,30,30.390001198897014
			** GPSMapDatum: WGS-84
			** GPSLatitudeRef: N
			** GPSDateStamp: 2009:09:26
			** 
			*/
			
			var d01:Number;
			var d02:Number = -1;
			var d03:Number;
			var d04:Number;
			var d05:String = String(ifd["GPSVersionID"]);
			var d06:String = String(ifd["GPSLongitude"]);
			var d07:String = String(ifd["GPSLongitudeRef"]);
			var d08:String = String(ifd["GPSTimeStamp"]);
			var d09:String = String(ifd["GPSLatitude"]);
			var d10:String = String(ifd["GPSMapDatum"]);
			var d11:String = String(ifd["GPSLatitudeRef"]);
			var d12:String = String(ifd["GPSDateStamp"]);
			
			// Convert degree/minute/seconds to decimal degree:
			d03 = this.degreeMinuteSecond2DecimalDegree(d06);
			
			// If West longitude, make negative:
			if (d07.toUpperCase() == "W") {
				d03 = d03 * d02;
			}
			
			// Convert degree/minute/seconds to decimal degree:
			d04 = degreeMinuteSecond2DecimalDegree(d09);
			
			// If South latitude, make negative:
			if (d11.toUpperCase() == "S") {
				
				d04 = d04 * d02;
				
			}
			
			_ft.log(d03 + ', ' + d04 + ', ' + d05 + ', ' + d06 + ', ' + d07 + ', ' + d08 + ', ' + d09 + ', ' + d10 + ', ' + d11 + ', ' + d12)
			
			// Call javascript function "sspGpsMap.gps()":
			ExternalInterface.call("sspGpsMap.gps", d03, d04, d05, d06, d07, d08, d09, d10, d11, d12);
			
		};
		
		/**
		* degreeMinuteSecond2DecimalDegree()
		*        About: Converts degree-minute-second (DMS) form to decimal degree (DD) form.
		*      Returns: Decimal degree (DD) form.
		*       @param: String.
		*/
		private function degreeMinuteSecond2DecimalDegree(s:String):Number {
			
			// http://www.ehow.com/how_2363249_form-decimal-degree-dd-form.html
			
			var n1:Array;
			var n2:Number = 1/60;
			var n3:Number;
			var n4:Number;
			var n5:Number;
			
			n1 = s.split(",");
			n3 = Number(n1[0]);
			n4 = Number(n1[1]);
			n5 = Number(n1[2]);
			
			return n3 + ((n4 * n2) + (n5 * n2 * n2));
			
		};
		
		/**
		* trim()
		*        About: Trims a string.
		*      Returns: Trimmed string.
		*       @param: String.
		*/
		private function trim(s:String):String {
			
			return s ? s.replace(/^\s+|\s+$/gs, '') : "";
			
		};
		
	};
	
};