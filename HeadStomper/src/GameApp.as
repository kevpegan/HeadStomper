package
{
	import Events.MenuEvents.DisplayInstructions;
	import Events.GameEvents.EndGame;
	import Events.MovementBlocks.SendLeft;
	import Events.MenuEvents.StartGame;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.ui.Keyboard;
	import InfoScreens.Title.TitleScreen;
	import Levels.First.Stage.Level;
	import Utils.InputContent.Input;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class GameApp extends Sprite
	{
		//Events
		private static var ms_EventDispatcher:IEventDispatcher = new EventDispatcher();	
		
		//Screens
		private var m_TitleScreen:TitleScreen;
		private var m_Info:Sprite;
		private var theImage:Bitmap = new Assets.instrucScreen() as Bitmap;
		
		//the jamz
		private var songChannel:SoundChannel = new SoundChannel();
		private var song:Sound = new Sound();
		private var muter:SoundTransform = new SoundTransform();
		
		//Levels
		private var m_Level:Level;
		
		//Check
		private var helping:Boolean;
		
		//Vars
		private var stageX:int;
		private var stageY:int;
		
		private var playing:Boolean;
		private var restart:Boolean;
		
		//public
		public function GameApp(referenceX:int, referenceY:int) 
		{
			stageX = referenceX;
			stageY = referenceY;
			
			playing = false;
			restart = false;
			helping = false;
		}
		
		public function init():void
		{
			pumpUpTheJamz();
			drawTitle();
			listen();
		}
		
		public function Update():void
		{
			if (!playing)
			{
				m_TitleScreen.Update();
			}
			if (playing)
			{
				m_Level.Update();
			}
			if (helping)
			{
				if (Input.Down(Keyboard.ESCAPE))
				{
					helping = false;
					removeChild(m_Info);
					m_TitleScreen.init();
					addChild(m_TitleScreen);
				}
			}
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return ms_EventDispatcher;
		}
		
		//private
		private function drawTitle():void
		{
			m_TitleScreen = new TitleScreen(stageX, stageY);
			
			m_TitleScreen.init();
			
			addChild(m_TitleScreen);
		}
		
		private function listen():void 
		{
			eventDispatcher.addEventListener(StartGame.START_GAME, start);
			eventDispatcher.addEventListener(DisplayInstructions.DISPLAY_INSTRUCTIONS, eh_instructions);		
			eventDispatcher.addEventListener(EndGame.END_GAME, eh_End);
		}
		
		private function eh_End(e:EndGame):void 
		{
			pumpUpTheJamz();
			m_TitleScreen.init();
			addChild(m_TitleScreen);
			
			m_Level.erase();
			removeChild(m_Level);			
			
			playing = false;
		}		
		
		private function eh_instructions(e:DisplayInstructions):void 
		{
			m_TitleScreen.erase();
			removeChild(m_TitleScreen);
			m_Info = new Sprite;
			
			m_Info.addChild(theImage);
			addChild(m_Info);
			helping = true;
		}
		
		private function start(e:StartGame):void 
		{
			songChannel.stop();
			m_TitleScreen.erase();
			removeChild(m_TitleScreen);
			
			trace("remove");
			m_Level = new Level(stageX, stageY);
			m_Level.init();
			addChild(m_Level);
			
			playing = true;
		}
		
		private function pumpUpTheJamz():void 
		{
			muter.volume = .1;
			song = new (Assets.titleMusic) as Sound;
			songChannel = song.play(10250, 999);
			songChannel.soundTransform = muter;
		}
	}

}