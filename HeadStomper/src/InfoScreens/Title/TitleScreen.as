package InfoScreens.Title
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import InfoScreens.Title.MenuButtons.InstructionsButton;
	import InfoScreens.Title.MenuButtons.PlayButton;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class TitleScreen extends Sprite
	{
		//references
		private var stageWidth:int;
		private var stageHeight:int;
		
		//parts
		private var m_Backing:Sprite;
		private var m_Title:TextField;
		
		//buttons
		private var m_Start_PvP:PlayButton;
		private var m_Instructions:InstructionsButton;
		
		//checks
		private var menuSelection:int;
		
		public function TitleScreen(sX:int, sY:int) 
		{
			stageWidth = sX;
			stageHeight = sY;
			
			menuSelection = 0;
		}
		
		//public 
		
		public function init():void
		{
			drawBacking();
			drawTitle();
			drawMenu();
		}	
		
		public function Update():void
		{
			
		}
		
		public function erase():void
		{	
		}
		
		//private
		
		private function drawBacking():void
		{
			m_Backing = new Sprite();
			
			m_Backing.graphics.beginFill(0x445447);
			m_Backing.graphics.drawRect(0, 0, stageWidth, stageHeight);
			m_Backing.graphics.endFill();
			
			addChild(m_Backing);
		}
		
		private function drawTitle():void
		{
			m_Title = new TextField();
			
			m_Title.selectable = false;
			m_Title.text = "Head Stomp!";
			m_Title.textColor = 0xFFFFFF;
			m_Title.x = stageWidth / 2 ;
			m_Title.y = 100;
			
			addChild(m_Title);
		}
		
		private function drawMenu():void
		{
			addPlayButton();
			addInstructionsButton();
		}							
		
		private function addInstructionsButton():void 
		{
			m_Instructions = new InstructionsButton(stageWidth, stageHeight);
			
			m_Instructions.init();
			
			m_Instructions.x = m_Start_PvP.x;
			m_Instructions.y = m_Start_PvP.y + 150;
			
			addChild(m_Instructions);
		}
		
		private function addPlayButton():void 
		{
			m_Start_PvP = new PlayButton(stageWidth, stageHeight);
			
			m_Start_PvP.init();
			
			m_Start_PvP.x = stageWidth / 3;
			m_Start_PvP.y = 150;
			
			addChild(m_Start_PvP);
		}
	}
}