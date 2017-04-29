package Events.MovementBlocks {
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class SendLeft extends Event
	{
		public static const SEND_LEFT:String = "SEND_LEFT";
		
		public function SendLeft(type:String) 
		{
			super(type, false, false);
		}		
	}
}