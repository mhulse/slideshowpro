## About:

Custom AS3 classes I wrote for use with [SlideShowPro](http://slideshowpro.com/).

Use at your own risk! :)

Please give me some credit if you use all or parts of the code in your own projects.

-----

## Usage:

All of my SSP classes depend on my utility classes:
[me.hulse.util.*](https://github.com/mhulse/me.hulse.util)

Put somewhere on your HDD and link to them from the flash publish settings.

In your publish settings, point to custom classes:
Publish Settings >> Flash >> Script >> Settings... >> Source Path: Click on folder and locate folder housing cutom classes.

I like to put my custom classes in my [Dropbox](http://dropbox.com) folder so I can share the classes between computers.

A more standard spot for custom classes:
~/Applications/Adobe Flash CS5/Common/First Run/Classes/Custom/

IIRC, you won't have to set a source path to custom classes if you put them in the above Classes folder.

__ssp.fla:__ Open in CS5, drag/drop the SSP component to the stage and then delete it from the stage.
Right-click on the SSP component in your library, get properties, and then choose "Export for ActionScript".

When upgrading to a new release of SSP, follow the same steps as above minus the right-click stuff. Too easy!

__ssp/standard.as:__ This is the document class for ssp.fla.

If you use this class as-is, you should take not of line 103:

    new Meta(mySsp);

Feel free to comment this line out if you prefer not to tinker with any of the GPS stuff.

If you do want to play with geo tagged photos...

Be sure to download and install [jp.shichiseki.exif](http://code.shichiseki.jp/as3/ExifInfo/); __meta.as__ depends on these classes, so put them in your "custom" class path.

__map.js:__ Link to this JS file if you want show your photos as markers on a Google Map.

I put this code at the bottom of my SSP pages:

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://assets.hulse.me/js/map.js"></script>
    $(window).load(function() {
    	$('#map').width(854).height(500).show();
    	sspGpsMap.init();
    });

Feel free to use your own techniques.

-----

That's all I can think of for now. Feel free to [contact me](http://hulse.me) if you have any questions.

-----

## Changelog:

* __2011/02/26__
	* Initial public release: Uploaded to GitHub.
