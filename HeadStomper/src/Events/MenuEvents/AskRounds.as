package Events.MenuEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class AskRounds extends Event
	{
		public static const ASK_ROUNDS:String = "ASK_ROUNDS";
		
		public function AskRounds(type:String) 
		{
			super(type, false, false);
		}
	}
}