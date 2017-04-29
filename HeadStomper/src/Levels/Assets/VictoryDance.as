package Levels.Assets 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class VictoryDance extends Sprite
	{
		private var which:String;
		private var theField:TextField;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		public function VictoryDance(sX:int, sY:int, player:int) 
		{			
			stageWidth = sX;
			stageHeight = sY;
			
			if (player == 1)
			{
				which = "Player 2 Wins!";
			}
			if (player == 2)
			{
				which = "Player 1 Wins!";
			}
		}
		
		public function init():void
		{
			write();
		}
		
		public function erase():void
		{
			if (contains(theField))
			{
				removeChild(theField);
			}
		}
		
		private function write():void 
		{
			theField = new TextField();
			
			theField.selectable = false;
			theField.text = which;
			theField.textColor = 0xFFFFFF;
			theField.x = stageWidth / 2;
			theField.y = stageHeight / 2;
			
			addChild(theField);
		}		
	}
}