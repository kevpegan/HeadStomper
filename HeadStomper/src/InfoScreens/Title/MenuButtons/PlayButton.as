package InfoScreens.Title.MenuButtons 
{
	import Events.MenuEvents.StartGame;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class PlayButton extends Sprite
	{
		//parts
		private var m_Button:Sprite;
		private var m_Text:TextField;
	
		//references
		private var stageWidth:int;
		private var stageHeight:int;
		
		public function PlayButton(sX:int, sY:int) 
		{
			stageHeight = sX;
			stageWidth = sY;
		}
		
		//public
		
		public function init():void
		{
			drawButton();
			addText();
			addListener();
		}
		
		public function Update():void
		{
		}
		
		public function erase():void
		{
			removeChild(m_Button);
			removeChild(m_Text);
		}
		
		//private
		
		private function drawButton():void
		{
			m_Button = new Sprite();
			
			m_Button.graphics.beginFill(0x1a1b13);
			m_Button.graphics.drawRect(0, 0, 400, 100 );
			m_Button.graphics.endFill();
			
			addChild(m_Button);
		}
		
		private function addText():void
		{
			m_Text = new TextField();
			
			m_Text.selectable = false;
			m_Text.width = 75;
			m_Text.height = 25;
			
			m_Text.text = "Play";
			m_Text.x = m_Button.x + m_Button.width / 2 - 40;
			m_Text.y = m_Button.y + m_Button.height / 2 - 15;
			
			m_Text.textColor = 0xFFFFFF;
			
			addChild(m_Text);
		}
		
		private function addListener():void
		{
			m_Button.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			m_Button.addEventListener(MouseEvent.MOUSE_OUT, deselect);
			m_Button.addEventListener(MouseEvent.CLICK, play);
		}
		
		private function play(e:MouseEvent):void 
		{
			GameApp.eventDispatcher.dispatchEvent(new StartGame(StartGame.START_GAME));
		}
		
		private function deselect(e:MouseEvent):void 
		{
			m_Button.alpha = 1;
			m_Text.alpha = 1;
		}
		
		private function highlight(e:MouseEvent):void 
		{
			m_Button.alpha = .5;
			m_Text.alpha = .5;
		}
		
	}

}