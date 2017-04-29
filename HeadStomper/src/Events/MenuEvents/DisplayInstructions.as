package Events.MenuEvents {
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class DisplayInstructions extends Event
	{
		public static const DISPLAY_INSTRUCTIONS:String = "DISPLAY_INSTRUCTIONS";
		
		public function DisplayInstructions(type:String):void
		{
			super(type, false, false);
		}
	}

}