package Events.MovementBlocks
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Unstuck extends Event
	{
		public static const UNSTUCK:String = "UNSTUCK";
		
		public function Unstuck(type:String) 
		{
			super(type, false, false);
		}		
	}
}