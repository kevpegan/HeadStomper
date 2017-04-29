package InfoScreens.Pause 
{
	import Events.GameEvents.EndGame;
	import Events.GameEvents.ResumeGame;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Levels.First.Stage.Level;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class PauseScreen extends Sprite
	{
		private var resumeButton:Sprite;
		private var quitButton:Sprite;
		
		private var resumeText:TextField;
		private var quitText:TextField;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		public function PauseScreen(sX:int, sY:int) 
		{
			stageWidth = sX;
			stageHeight = sY;
		}
		
		public function init():void
		{
			draw();
			title();
			heyLookListen();
		}	
		
		public function erase():void
		{
			removeChild(resumeButton);
			removeChild(quitButton);
			
			removeChild(resumeText);
			removeChild(quitText);
		}
		
		private function heyLookListen():void 
		{
			resumeButton.addEventListener(MouseEvent.ROLL_OVER, eh_Resume_RollOver);
			resumeButton.addEventListener(MouseEvent.ROLL_OUT, eh_Resume_RollOut);
			resumeButton.addEventListener(MouseEvent.CLICK, eh_Resume_Click);
			
			quitButton.addEventListener(MouseEvent.ROLL_OVER, eh_Quit_RollOver);
			quitButton.addEventListener(MouseEvent.ROLL_OUT, eh_Quit_RollOut);
			quitButton.addEventListener(MouseEvent.CLICK, eh_Quit_Click);
		}
		
		private function eh_Quit_Click(e:MouseEvent):void 
		{
			GameApp.eventDispatcher.dispatchEvent(new EndGame(EndGame.END_GAME));
		}
		
		private function eh_Resume_Click(e:MouseEvent):void 
		{
			Level.eventDispatcher.dispatchEvent(new ResumeGame(ResumeGame.RESUME_GAME));
		}
		
		private function eh_Quit_RollOut(e:MouseEvent):void 
		{
			quitButton.alpha = 1;
		}
		
		private function eh_Quit_RollOver(e:MouseEvent):void 
		{
			quitButton.alpha = .5;
		}
		
		private function eh_Resume_RollOut(e:MouseEvent):void 
		{
			resumeButton.alpha = 1;
		}
		
		private function eh_Resume_RollOver(e:MouseEvent):void 
		{
			resumeButton.alpha = .5;
		}
		
		private function draw():void 
		{
			resumeButton = new Sprite();
			
			resumeButton.graphics.beginFill(0xFF80FF);
			resumeButton.graphics.drawRect(stageWidth / 2 - 75, stageHeight / 3, 150, 50);
			resumeButton.graphics.endFill();
			
			addChild(resumeButton);
			
			quitButton = new Sprite();
			
			quitButton.graphics.beginFill(0xFF80FF);
			quitButton.graphics.drawRect(stageWidth / 2 - 75, stageHeight / 3 + 100, 150, 50);
			quitButton.graphics.endFill();
			
			addChild(quitButton);
		}
		
		private function title():void 
		{
			resumeText = new TextField();
			
			resumeText.selectable = false;
			resumeText.text = "Resume";
			resumeText.width = 75;
			resumeText.height = 25;
			
			resumeText.x = stageWidth / 2 - 25;
			resumeText.y = stageHeight / 3 + 12;
			
			addChild(resumeText);
			
			quitText = new TextField();
			
			quitText.selectable = false;
			quitText.text = "Quit Game";
			quitText.width = 75;
			quitText.height = 25;
			
			quitText.x = stageWidth / 2 - 25;
			quitText.y = stageHeight / 3 + 112;
			
			addChild(quitText);
		}
	}

}