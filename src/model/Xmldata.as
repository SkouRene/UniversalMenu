/**
 * base class for loading all xml files for the UniversalMenu
 * 
 * 
 * @author René Skou
 * @version 0.2
 */
/*
 * Licensed under the MIT License
 * 
 * Copyright (c) 2010-2011 René Skou
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * https://github.com/SkouRene/UniversalMenu
 * http://www.opensource.org/licenses/mit-license.php
 *    
 */
package model 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	

	public class Xmldata extends EventDispatcher
	{
		private var baseloader:BulkLoader;
		public var defaultXml:XML;
		
		public static const DEFAULTXML_LOADED:String = "dafaultxmlLoaded";
		
		//contructor not in use
		public function Xmldata() 
		{
			
		}
		//starting the load process of the xml
		public function init ():void
		{
			// create the loader object and defind the vituel string name, must be unik.
			baseloader = new BulkLoader("main-site");
			
			/**
			 * Variable for allowing debugging when testting/debug 
			 * offline set it to false when ready for production site
			 */
			var allowDebug:Boolean = true;
			
			if (allowDebug)
			{
				var baseUrl:String = "http://udvikling.cyberhus.dk/";
				var startxml:String = "fmitems/1053";
				var defaultxml:String = "fmblandet/alle";
				
			}else {
				//catch error event if there is no javascript variable defined
				try {
					baseUrl = ExternalInterface.call("baseurl");
					startxml = ExternalInterface.call("startxml");
					defaultxml = ExternalInterface.call("defaultxml");
					
				}catch (e:Error) {
					trace(e.errorID + e.message);
				}
				
			}
			//end of debug stament
			
			/**
			 * Adding objects to the loader and start loading them
			 * track the progress and the complete event when all objects
			 * is loaded.
			 */
			baseloader.add(baseUrl + defaultxml, { id:"mediabox-default", type:"xml" } );
			baseloader.add(baseUrl + startxml, { id:"startxml", type:"xml" } );
			baseloader.addEventListener(BulkProgressEvent.PROGRESS, xmlfilesProgress);
			baseloader.addEventListener(BulkProgressEvent.COMPLETE, xmlfilesLoaded);
			baseloader.addEventListener(BulkLoader.ERROR, xmlfilesError);
			baseloader.start();
			
		}
		/**
		 * Fires a event when defaultxml is defind and not null.
		 */
		 
		private function xmlfilesLoaded(e:Event):void
		{
			defaultXml = baseloader.getXML("mediabox-default");
			if (defaultXml != null)
			{
				dispatchEvent(new Event(Xmldata.DEFAULTXML_LOADED));
			}
			
		}
		private function xmlfilesProgress(e:BulkProgressEvent):void
		{
			
		}
		private function xmlfilesError(e:ErrorEvent):void
		{
			
		}
		//end of loading process.
		
		
	}

}