package Events.MovementBlocks 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Unblock extends Event
	{
		public static const UNBLOCK_MOVEMENT:String = "UNBLOCK_MOVEMENT";
		
		public function Unblock(type:String) 
		{
			super(type, false, false);
		}		
	}
}