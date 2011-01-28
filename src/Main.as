package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import model.Xmldata;
	
	/**
	 * ...
	 * @author René Skou
	 */
	public class Main extends Sprite 
	{
		private var ob:Xmldata;
		
		public function Main():void 
		{
			ob = new Xmldata();
			ob.init();
			ob.addEventListener(Xmldata.DEFAULTXML_LOADED, objloaded);
		}
		private function objloaded (e:Event):void
		{
			trace(ob.defaultXml);
		}
		

		
	}
	
}