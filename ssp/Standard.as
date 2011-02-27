package ssp {
	
	// Imports:
	import flash.display.*;
	import flash.events.*;
	
	// Custom classes:
	import net.slideshowpro.slideshowpro.*;
	import me.hulse.util.*;
	
	/**
	* Document class
	* This is a work in progress.
	* 
	* @package       ssp
	* @author        Micky Hulse
	* @copyright     Copyright (c) 2011, Micky Hulse
	* @link          http://hulse.me/
	*/
	
	public class Standard extends MovieClip {
		
		// Meta:
		private static const APP_NAME:String = 'SSP';
		private static const APP_VERSION:String = '1.9.8.5';
		private static const APP_MODIFIED:String = '2010/11/24';
		private static const APP_AUTHOR:String = 'Micky Hulse <micky@hulse.me>';
		
		// Private constants:
		private static const ALLOWED_DOMAINS:Array = ['hulse.me', 'registerguard.com'];
		
		// Private:
		private var _ft:FireTrace;
		private var _lockDown:LockDown2;
		
		/**
		* Constructor
		* 
		* @access     public
		* @return     
		*/
		
		public function Standard() {
			
			// Boilerplate:
			this.addEventListener(Event.ADDED_TO_STAGE, ready, false, 0, true);
			
		};
		
		/**
		* Called once the stage is ready
		* 
		* @access     private
		* @return     void
		*/
		
		private function ready(e:Event):void {
			
			// Garbage collection:
			this.removeEventListener(Event.ADDED_TO_STAGE, ready);
			
			// Logging:
			_ft = new FireTrace();
			
			// Who, what, when, where and why:
			_ft.log('Name: ' + APP_NAME + '; Version: ' + APP_VERSION + '; Modified: ' + APP_MODIFIED + '; Author: ' + APP_AUTHOR);
			
			// "Security" check:
			_lockDown = new LockDown2(ALLOWED_DOMAINS);
			
			if (_lockDown.unlocked) { init(); }
			
		};
		
		/**
		* Initialize
		* 
		* @access     private
		* @return     void
		*/
		
		private function init():void {
			
			/*
			** 
			** Instanciate and setup SlideShowPro:
			** http://wiki.slideshowpro.net/SSPfl/API-SlideShowPro
			** 
			*/
			
			var mySsp:SlideShowPro = new SlideShowPro(this);
			
			/*
			** 
			** Configure and display:
			** 
			*/
			
			new Setup(this, mySsp);
			new Props(mySsp);
			new Params(this, mySsp);
			new Kind(mySsp);
			new Meta(mySsp);
			
		};
		
	};
	
};