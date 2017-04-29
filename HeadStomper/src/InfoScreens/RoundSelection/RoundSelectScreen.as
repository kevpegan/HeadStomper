package InfoScreens.RoundSelection 
{
	import Events.GameEvents.StartGame;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Levels.First.Stage.Level;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class RoundSelectScreen extends Sprite
	{
		//buttons
		private var incrementButton:Sprite;
		private var decrementButton:Sprite;
		private var confirmButton:Sprite;
		
		//backing
		private var m_Backing:Sprite;
		
		//text
		private var infoText:TextField;
		private var roundDisplay:TextField;
		private var whatToShow:String;
		public var numRounds:int;
		
		//references
		private var stageWidth:int;
		private var stageHeight:int;
		
		public function RoundSelectScreen(sX:int, sY:int) 
		{
			numRounds = 3;
			whatToShow = "Best of: 3";
			
			stageWidth = sX;
			stageHeight = sY;
		}
		
		public function init():void
		{
			drawBacking();
			drawButtons();
			drawTextField();
			heyLookListen();
		}
		
		public function erase():void
		{
			if (contains(m_Backing))
			{
				removeChild(m_Backing);
			}
			if (contains(confirmButton))
			{
				removeChild(confirmButton);
			}
			if (contains(decrementButton))
			{
				removeChild(decrementButton);
			}
			if (contains(incrementButton))
			{
				removeChild(incrementButton);
			}
			if (contains(infoText))
			{
				removeChild(infoText);
			}
			if (contains(roundDisplay))
			{
				removeChild(roundDisplay);
			}			
		}
		
		//private
		
		private function drawBacking():void 
		{
			m_Backing = new Sprite();
			
			m_Backing.graphics.beginFill(0x000000);
			m_Backing.graphics.drawRect(0, 0, stageWidth, stageHeight);
			m_Backing.graphics.endFill();
			
			addChild(m_Backing);	
		}
		
		private function heyLookListen():void 
		{
			incrementButton.addEventListener(MouseEvent.ROLL_OVER, eh_Increment_MouseOver);
			incrementButton.addEventListener(MouseEvent.ROLL_OUT, eh_Increment_MouseOut);
			incrementButton.addEventListener(MouseEvent.CLICK, eh_Increment_Click);
			
			decrementButton.addEventListener(MouseEvent.ROLL_OVER, eh_Decrement_MouseOver);
			decrementButton.addEventListener(MouseEvent.ROLL_OUT, eh_Decrement_MouseOut);
			decrementButton.addEventListener(MouseEvent.CLICK, eh_Decrement_Click);		
			
			confirmButton.addEventListener(MouseEvent.ROLL_OVER, eh_Confirm_MouseOver);
			confirmButton.addEventListener(MouseEvent.ROLL_OUT, eh_Confirm_MouseOut);
			confirmButton.addEventListener(MouseEvent.CLICK, eh_Confirm_Click);		
		}
		
		private function eh_Confirm_Click(e:MouseEvent):void 
		{
			Level.eventDispatcher.dispatchEvent(new StartGame(StartGame.START_GAME));
		}
		
		private function eh_Confirm_MouseOut(e:MouseEvent):void 
		{
			confirmButton.alpha = 1;
		}
		
		private function eh_Confirm_MouseOver(e:MouseEvent):void 
		{
			confirmButton.alpha = .5;
		}
		
		private function eh_Decrement_Click(e:MouseEvent):void 
		{
			if (numRounds > 1)
			{
				numRounds -= 2;
				roundDisplay.text = "Best of: " + numRounds;
			}
		}
		
		private function eh_Decrement_MouseOut(e:MouseEvent):void 
		{
			decrementButton.alpha = 1;
		}
		
		private function eh_Decrement_MouseOver(e:MouseEvent):void 
		{
			decrementButton.alpha = .5;
		}
		
		private function eh_Increment_Click(e:MouseEvent):void 
		{
			if (numRounds < 7)
			{
				numRounds += 2;
				roundDisplay.text = "Best of: " + numRounds;
			}
		}
		
		private function eh_Increment_MouseOut(e:MouseEvent):void 
		{
			incrementButton.alpha = 1;
		}
		
		private function eh_Increment_MouseOver(e:MouseEvent):void 
		{
			incrementButton.alpha = .5;
		}
		
		private function drawTextField():void 
		{
			infoText = new TextField();
			
			infoText.selectable = false;
			infoText.text = "What would you like to play to?";
			infoText.textColor = (0xFFFFFF);
			infoText.width = 175;
			infoText.height = 25;
			
			infoText.x = stageWidth / 2 - 50;
			infoText.y = 200;
			
			addChild(infoText);
			
			roundDisplay = new TextField();
			
			roundDisplay.selectable = false;
			roundDisplay.text = whatToShow;
			roundDisplay.textColor = (0xFFFFFF);
			roundDisplay.width = 75;
			roundDisplay.height = 25;
			roundDisplay.x = infoText.x + 50;
			roundDisplay.y = infoText.y + 50;
			
			addChild(roundDisplay);
		}
		
		private function drawButtons():void 
		{
			incrementButton = new Sprite();
			
			incrementButton.graphics.beginFill(0x00FF00);
			incrementButton.graphics.drawRect(600, stageHeight / 2 - 25, 25, 25);
			incrementButton.graphics.endFill();
			
			addChild(incrementButton);
			
			decrementButton = new Sprite();
			
			decrementButton.graphics.beginFill(0xFF0000);
			decrementButton.graphics.drawRect(400, stageHeight / 2 - 25, 25, 25);
			decrementButton.graphics.endFill();
			
			addChild(decrementButton);
			
			confirmButton = new Sprite();
			
			confirmButton.graphics.beginFill(0x0000FF);
			confirmButton.graphics.drawRect(475, stageHeight / 2 + 50, 75, 25);
			confirmButton.graphics.endFill();
			
			addChild(confirmButton);
		}		
	}
}