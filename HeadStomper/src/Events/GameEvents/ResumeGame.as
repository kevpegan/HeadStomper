package Events.GameEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class ResumeGame extends Event
	{
		public static const RESUME_GAME:String = "RESUME_GAME";
		
		public function ResumeGame(type:String) 
		{
			super(type, false, false);
		}		
	}
}