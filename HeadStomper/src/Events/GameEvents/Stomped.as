package Events.GameEvents
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Stomped extends Event
	{
		public static const STOMPED:String = "STOMPED";
		
		public function Stomped(type:String) 
		{
			super(type, false, false);
		}		
	}
}