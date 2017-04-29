package Levels.First.Stage 
{
	import Events.GameEvents.EndGame;
	import Events.GameEvents.ResumeGame;
	import Events.GameEvents.StartGame;
	import Events.MenuEvents.AskRounds;
	import Events.MovementBlocks.SendLeft;
	import Events.MovementBlocks.SendRight;
	import Events.MovementBlocks.Unblock;
	import Events.MovementBlocks.Spiderman;
	import Events.GameEvents.Stomped;
	import Events.MovementBlocks.Unstuck;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.globalization.Collator;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import InfoScreens.Pause.PauseScreen;
	import InfoScreens.PlayerSetup.PlayerSetupScreen;
	import InfoScreens.RoundSelection.RoundSelectScreen;
	import Levels.Assets.Pillars;
	import Levels.Assets.Player.Player;
	import Levels.Assets.VictoryDance;
	import Levels.CollisionManager;
	import Utils.GameTime;
	import Utils.InputContent.Input;
	
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Level extends Sprite
	{
		//references
		private var stageWidth:int;
		private var stageHeight:int;
		
		//parts
		private var m_Backing:Sprite;
		private var playerSelection:PlayerSetupScreen;
		private var roundSelection:RoundSelectScreen;
		private var pillar:Pillars;
		private var player1:Player;
		private var player2:Player;
		private var m_CollisionManager:CollisionManager;
		private var winnerWinnerChickenDinner:VictoryDance;
		private var m_pauseScreen:PauseScreen;
		
		//bgm
		private var backgroundSong:Sound;
		private var bgmChannel:SoundChannel = new SoundChannel();
		private var muter:SoundTransform = new SoundTransform();
		
		//score
		private var winningScore:int;
		private var player1_score:int;
		private var player2_score:int;
		private var player1_scoreField:TextField;
		private var player2_scoreField:TextField;
		
		//time
		private var timeToStop:Number;
		private var currentTime:Number;
		private var duration:int = 3;
		
		//checks
		private var goingUp:Boolean;
		private var holdPosition:Boolean;
		private var goingDown:Boolean;
		private var alive:Boolean;
		private var alive2:Boolean;
		private var ending:Boolean
		private var playing:Boolean;
		private var reset:Boolean;
		private var paused:Boolean;
		
		private static var ms_EventDispatcher:IEventDispatcher = new EventDispatcher();	
		
		public function Level(sX:int, sY:int) 
		{
			stageHeight = sY;;
			stageWidth = sX;
			
			playing = false;
			
			m_CollisionManager = new CollisionManager();
			
			ending = false;
			reset = false;
		}
		
		//public
		
		public function init():void
		{			
			listen();
			playerSetup();
		}
		
		private function playerSetup():void 
		{
			playerSelection = new PlayerSetupScreen(stageWidth, stageHeight);
			
			playerSelection.init();
			
			addChild(playerSelection);
		}
	
		public function Update():void
		{	
			if (playing)
			{
				if (Input.Down(Keyboard.P))
				{
					playing = false;
					paused = true;
					alpha = .5;
					addPauseScreen();
				}
				m_CollisionManager.Update(player1.location, player1.vert_velocity, player2.location, player2.vert_velocity, pillar.location);
				pillar.Update();
				if (alive)
				{
					player1.Update();
				}
				if (alive2)
				{
					player2.Update();
				}	
				if (ending)
				{
					countdown();
				}	
				if (reset)
				{
					countdown();
				}
			}
		}
		
		private function addPauseScreen():void 
		{
			m_pauseScreen = new PauseScreen(stageWidth, stageHeight);
					
			m_pauseScreen.init();
					
			addChild(m_pauseScreen);
		}
		
		public function erase():void
		{
			if (contains(player1))
			{
				player1.erase();
			}
			if (contains(player2))
			{
				player2.erase();
			}
			if (contains(pillar))
			{
				pillar.erase();
			}
			if (winnerWinnerChickenDinner!= null)
			{
				winnerWinnerChickenDinner.erase();
			}			
			
			if (contains(player1))
			{
				trace("removed player 1");
				removeChild(player1);
			}
			if (contains(player2))
			{
				removeChild(player2);
			}
			if (contains(pillar))
			{
				removeChild(pillar);
			}
			if (winnerWinnerChickenDinner != null)
			{
				if (contains(winnerWinnerChickenDinner))
				{
					removeChild(winnerWinnerChickenDinner);
				}
			}
			
			if (contains(playerSelection))
			{
				removeChild(playerSelection);
			}
			if (contains(roundSelection))
			{
				removeChild(roundSelection);
			}		
			if (contains(player1_scoreField))
			{
				removeChild(player1_scoreField);
			}
			if (contains(player2_scoreField))
			{
				removeChild(player2_scoreField);
			}
			bgmChannel.stop();
		}
		
		//private		
		
		private function addPlayers():void 
		{
			player1 = new Player(stageHeight, stageWidth, 104, 101, 100, 102, 105, 103, 0, playerSelection.player1_Color);			
			player1.init();		
			player1.duration = pillar.duration / 4;
			addChild(player1);
			
			player2 = new Player(stageHeight, stageWidth, 87, 83, 65, 68, 69, 81, stageWidth - 50, playerSelection.player2_Color);
			player2.init();
			player2.duration = pillar.duration / 4;
			addChild(player2);
			
			player1_scoreField = new TextField();
			
			player1_scoreField.text = "Player 1: " + player1_score;
			player1_scoreField.textColor = 0xFFFFFF;
			player1_scoreField.selectable = false;
			
			player1_scoreField.x = 200;
			player1_scoreField.y = 50;
			
			addChild(player1_scoreField);
			
			player2_scoreField = new TextField();
			
			player2_scoreField.text = "Player 2: " + player2_score;
			player2_scoreField.textColor = 0xFFFFFF;
			player2_scoreField.selectable = false;
			
			player2_scoreField.x = 700;
			player2_scoreField.y = 50;
			
			addChild(player2_scoreField);
			
			alive = true;
			alive2 = true;
		}
		
		private function addPillar():void 
		{
			pillar = new Pillars(stageWidth, stageHeight);
			pillar.init();
			addChild(pillar);
		}
		
		private function eh_Stomped(e:Stomped):void 
		{
			if (m_CollisionManager.which == 1)
			{
				bgmChannel.stop();
				alive = false;
				player1.x = 1000;
				player1.ableLeft = false;
				player1.ableRight = false;
				
				winnerWinnerChickenDinner = new VictoryDance(stageWidth, stageHeight, m_CollisionManager.which);
				winnerWinnerChickenDinner.init();
				addChild(winnerWinnerChickenDinner);
				
				currentTime = getTimer() / 1000;
				timeToStop = currentTime + duration;
				player2_score += 1;
				
				if (player2_score == winningScore)
				{
					ending = true;
				}		
				if (player2_score < winningScore)
				{
					reset = true;
				}
			}
			if (m_CollisionManager.which == 2)
			{
				bgmChannel.stop();
				alive2 = false;
				player2.x = 1000;
				player2.ableLeft = false;
				player2.ableRight = false;
				
				winnerWinnerChickenDinner = new VictoryDance(stageWidth, stageHeight, m_CollisionManager.which);
				winnerWinnerChickenDinner.init();
				addChild(winnerWinnerChickenDinner);
				
				currentTime = getTimer() / 1000;
				timeToStop = currentTime + duration;
				
				player1_score += 1;
				
				if (player1_score == winningScore)
				{
					ending = true;
				}
				if (player1_score < winningScore)
				{
					reset = true;
				}
			}
		}
		
		private function countdown():void 
		{
			if (getTimer() / 1000 >= timeToStop && ending)
			{
				GameApp.eventDispatcher.dispatchEvent(new EndGame(EndGame.END_GAME));
			}
			if (getTimer() / 1000 >= timeToStop && reset)
			{				
				erase();
				start();
			}
		}
		
		//events
		
		private function listen():void 
		{
			eventDispatcher.addEventListener(SendLeft.SEND_LEFT, eh_SendLeft);
			eventDispatcher.addEventListener(Unblock.UNBLOCK_MOVEMENT, eh_Unblock);
			eventDispatcher.addEventListener(SendRight.SEND_RIGHT, eh_SendRight);
			eventDispatcher.addEventListener(Stomped.STOMPED, eh_Stomped);
			eventDispatcher.addEventListener(Spiderman.STICKY, eh_Spiderman);
			eventDispatcher.addEventListener(Unstuck.UNSTUCK, eh_Unstuck);
			eventDispatcher.addEventListener(AskRounds.ASK_ROUNDS, eh_AskRounds)
			eventDispatcher.addEventListener(StartGame.START_GAME, eh_StartGame);
			eventDispatcher.addEventListener(ResumeGame.RESUME_GAME, eh_Resume);
		}
		
		private function eh_Resume(e:Event):void 
		{
			paused = false;
			playing = true;
			alpha = 1;
			m_pauseScreen.erase();
			removeChild(m_pauseScreen);
		}
		
		private function eh_StartGame(e:Event):void 
		{
			winningScore = ((roundSelection.numRounds + 1) / 2);
			roundSelection.erase();
			start();
		}
		
		private function start():void 
		{
			bgmChannel = new SoundChannel;
			muter = new SoundTransform;
			backgroundSong = new (Assets.bgm) as Sound;
			muter.volume = .4;
			bgmChannel = backgroundSong.play(0, 999);
			bgmChannel.soundTransform = muter;
			drawBacking();
			addPillar();
			addPlayers();
			
			playing = true;
			reset = false;
			ending = false;
		}
		
		private function drawBacking():void 
		{
			m_Backing = new Sprite();
			
			m_Backing.graphics.beginFill(0x000000);
			m_Backing.graphics.drawRect(0, 0, stageWidth, stageHeight);
			m_Backing.graphics.endFill();
			
			addChild(m_Backing);
		}
		
		private function eh_AskRounds(e:AskRounds):void 
		{
			playerSelection.erase();
			
			roundSelection = new RoundSelectScreen(stageWidth, stageHeight);
			
			roundSelection.init()
			
			addChild(roundSelection);
		}
		
		private function eh_Unstuck(e:Unstuck):void 
		{
			if (m_CollisionManager.which == 1)
			{
				player1.sticking = false;
			}
		}
		
		private function eh_Spiderman(e:Spiderman):void 
		{
			if (m_CollisionManager.which == 1)
			{
				player1.sticking = true;
				player1.currentTime = getTimer() / 1000;
				player1.timeToStop = player1.currentTime + player1.duration;
			}
			if (m_CollisionManager.which == 2)
			{
				player2.sticking = true;
				player2.currentTime = getTimer() / 1000;
				player2.timeToStop = player2.currentTime + player2.duration;
			}
		}
		
		private function eh_SendRight(e:Event):void 
		{
			player1.ableRight = false;
			player1.h_Velocity = -5;
			
			player2.ableLeft = false;
			player2.h_Velocity = 5;
		}
		
		private function eh_Unblock(e:Event):void 
		{
			player1.ableLeft = true;
			player1.ableRight = true;

			player2.ableLeft = true;
			player2.ableRight = true;
		}
		
		private function eh_SendLeft(e:Event):void 
		{
			player1.ableLeft = false;
			player1.h_Velocity = 5;
			
			player2.ableRight = false;
			player2.h_Velocity = -5;
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return ms_EventDispatcher;
		}
		
	}	

}