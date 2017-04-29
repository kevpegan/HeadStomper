package Events.GameEvents {
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class EndGame extends Event
	{
		public static const END_GAME:String = "END_GAME";
		
		public function EndGame(type:String):void
		{
			super(type, false, false);
		}			
	}
}