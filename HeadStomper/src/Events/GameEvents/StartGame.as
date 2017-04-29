package Events.GameEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class StartGame extends Event
	{
		public static const START_GAME:String = "START_GAME";
		
		public function StartGame(type:String) 
		{
			super(type, false, false);
		}		
	}
}