/*
** 
** Author: Micky Hulse
** Last modified: 2010/11/25
** This could be better... I am open to suggestions!
** 
*/

var sspGpsMap = {
	
	map : null,
	evictions : [],
	
	init : function(el) {
		
		// Defalt is "#map":
		el = typeof(el) != 'undefined' ? el : 'map';
		
		// Centers on USA:
		var latlng = new google.maps.LatLng(37.0625, -95.677068);
		
		// Options:
		var myOptions = {
			zoom: 4,
			center: latlng,
			mapTypeId: google.maps.MapTypeId.HYBRID
		};
		
		// Instantiate map:
		this.map = new google.maps.Map(document.getElementById(el), myOptions);
		
	},
	
	evict : function() {
		
		// Clear all markers:
		if (this.evictions) {
			for (i in this.evictions) {
				this.evictions[i].setMap(null);
			}
		}
		
		// Reset the eviction array:
		this.evictions = [];
		
	},
	
	gps : function(lonDd, latDd, GPSVersionID, GPSLongitude, GPSLongitudeRef, GPSTimeStamp, GPSLatitude, GPSMapDatum, GPSLatitudeRef, GPSDateStamp) {
		
		/*
		** 
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
		** Note:
		** The above extra data might be available only if the SSP Director link option is set to "Download original image".
		** 
		*/
		
		// Clear markers:
		this.evict();
		
		// Input new latitude and longitude:
		var myLatlng = new google.maps.LatLng(parseFloat(latDd), parseFloat(lonDd));
		
		// Center map:
		this.map.setCenter(myLatlng);
		
		// Zoom:
		this.map.setZoom(19);
		
		// Place marker:
		var marker = new google.maps.Marker({
			position: myLatlng, 
			map: this.map,
			title: lonDd + ', ' + latDd
		}); 
		
		// Add marker to eviction list:
		this.evictions.push(marker);
		
	}
	
}