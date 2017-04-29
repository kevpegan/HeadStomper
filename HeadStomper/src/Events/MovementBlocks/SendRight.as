package Events.MovementBlocks 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class SendRight extends Event
	{
		public static const SEND_RIGHT:String = "SEND_RIGHT";
		
		public function SendRight(type:String) 
		{
			super(type, false, false);
		}		
	}
}