package model 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author René Skou
	 * base class for loading all xml files for the Flashmenu
	 */
	public class Xmldata 
	{
		private var baseloader:BulkLoader;
		private var defaultxml:XML;
		
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
				var baseUrl:String = "udvikling.cyberhus.dk/";
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
		private function xmlfilesLoaded(e:Event):void
		{
			defaultxml = baseloader.getXML("mediabox-default");
		}
		private function xmlfilesProgress(e:BulkProgressEvent):void
		{
			
		}
		private function xmlfilesError(e:ErrorEvent):void
		{
			
		}
		//end of loading process.
		
		//get function to retrive data to populate mediabox with default text.
		public function getDefaultxml():XML
		{
			return defaultxml;
		}
	}

}