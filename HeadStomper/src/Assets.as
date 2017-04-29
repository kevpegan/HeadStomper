package  
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Assets 
	{
		trace("Hi");
		[Embed(source="loaded_images/221394__jalastram__fx056.mp3")]
		public static const player1_Jump_Sound:Class;
		[Embed(source = "loaded_images/220994__jalastram__fx017.mp3")]
		public static const stomped:Class;
		[Embed(source = "loaded_images/t-PORT - Shuric Scan (Keygen music).mp3")]
		public static const bgm:Class;
		[Embed(source = "loaded_images/Steven Universe - The Crystal Gems (Chiptune).mp3")]
		public static const titleMusic:Class;
		[Embed(source="loaded_images/infoScreen.png")]
		public static var instrucScreen:Class;
		[Embed(source = "loaded_images/Randomize4.mp3")]
		public static const boostSound:Class;
		[Embed(source = "loaded_images/Randomize19.mp3")]
		public static const slamSound:Class;
	}

}