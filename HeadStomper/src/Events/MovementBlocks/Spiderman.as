package Events.MovementBlocks {
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Spiderman extends Event
	{
		public static const STICKY:String = "STICKY";
		
		public function Spiderman(type:String) 
		{
			super(type, false, false);
		}		
	}
}