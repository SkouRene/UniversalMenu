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
		
		public function Main():void 
		{
			var ob:Xmldata = new Xmldata();
			ob.init();
			trace(ob.getDefaultxml());
		}
		

		
	}
	
}