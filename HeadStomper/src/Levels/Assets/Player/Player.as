package Levels.Assets.Player 
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getTimer;
	import Utils.GameTime;
	import Utils.InputContent.Input;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Player extends Sprite
	{
		//player
		private var m_Player:Sprite;		
		private var size:int;
		private var airbourne:Boolean;
		public var sticking:Boolean;
		public var currentTime:Number;
		public var timeToStop:Number;
		public var duration:Number;
		public var vert_velocity:int;
		private var horiz_velocity:int;
		private var spawnLoc:int;
		private var skin:int;
		private var playerNumber:int;
		
		//sound
		private var jumpSound:Sound;
		
		//references
		private var stageWidth:int;
		private var stageHeight:int;
		
		//controls
		public var upKey:int;
		public var downKey:int;
		public var leftKey:int;
		public var rightKey:int;
		public var l_DashKey:int;
		public var r_DashKey:int;
		
		//constant forces
		private const gravity:int = 2;
		private const speed:int = 400;
		
		//maxes
		private static const MAX_SPEED:int = 30;
		private static const MAX_DASHES:int = 1;
		
		//checks
		public var ableLeft:Boolean;
		public var ableRight:Boolean;
		private var dashCount:int;
		
		//events
		private static var ms_EventDispatcher:IEventDispatcher = new EventDispatcher();	
		
		
		public function Player(sX:int, sY:int, up:int, down:int, left:int, right:int, r_Dash:int, l_Dash:int, locX:int, skin_color:uint) 
		{
			stageWidth = sX;
			stageHeight  = sY;
			spawnLoc = locX;
			
			if (spawnLoc == 0)
			{
				playerNumber = 2;
			}
			else
			{
				playerNumber = 2;
			}
			
			upKey = up;
			downKey = down;
			leftKey = left;
			rightKey = right;
			l_DashKey = l_Dash;
			r_DashKey = r_Dash;
			
			skin = skin_color;
			
			dashCount = 1;
			
			ableLeft = true;
			ableRight = true;
			
			airbourne = false;
			sticking = false;
			vert_velocity = 0;
			horiz_velocity = 0;
			size = 50;
		}
		
		//public
		
		public function init():void
		{
			draw();
		}
		
		public function set h_Velocity(temp:int):void
		{
			horiz_velocity = temp;
		}
		
		public function Update():void
		{
			checkStatus();
			checkInput();
			move();
		}
		
		public function erase():void
		{
			if (contains(m_Player))
			{
				removeChild(m_Player);
			}			
		}
		
		//accessor
		
		public function get location():Sprite
		{  
			return m_Player;
		}
		
		public function get coordinates():int
		{
			return m_Player.x;
		}
		
		//private
		
		private function draw():void
		{
			m_Player = new Sprite();
			
			m_Player.graphics.beginFill(skin);
			m_Player.graphics.drawRect(spawnLoc, 490, size, size);
			m_Player.graphics.endFill();
			
			addChild(m_Player);
		}
		
		private function checkInput():void
		{
			groundMovement();
			airMovement();
		
			
			//gliding
			if (Input.Up(leftKey) && Input.Up(rightKey))
			{
				if (horiz_velocity > 0)
				{
					horiz_velocity--;
				}
				if (horiz_velocity < 0)
				{
					horiz_velocity++;
				}
			}
		}
		
		private function airMovement():void 
		{
			//ground slam
			if (Input.Down(downKey) && airbourne)
			{
				if (!sticking)
				{
					if (vert_velocity >= -30)
					{
						var booster:Sound = new (Assets.slamSound) as Sound;
						var player_sound:SoundChannel = new SoundChannel();
						var muter:SoundTransform = new SoundTransform();
						muter.volume = .3;
						player_sound = booster.play();
						player_sound.soundTransform = muter;
						
						vert_velocity -= 20;
						horiz_velocity = 0;
						ableLeft = false;
						ableRight = false;
					}					
				}
			}
			if (airbourne)
			{
				if (Input.Pressed(l_DashKey))
				{
					if (dashCount > 0)
					{
						var booster:Sound = new (Assets.boostSound) as Sound;
						var player_sound:SoundChannel = new SoundChannel();
						var muter:SoundTransform = new SoundTransform();
						muter.volume = .5;
						player_sound = booster.play();
						player_sound.soundTransform = muter;
						
						h_Velocity = -MAX_SPEED;
						dashCount--;
					}					
				}
				if (Input.Pressed(r_DashKey)) 
				{
					if (dashCount > 0)
					{
						var booster:Sound = new (Assets.boostSound) as Sound;
						var player_sound:SoundChannel = new SoundChannel();
						var muter:SoundTransform = new SoundTransform();
						muter.volume = .5;
						player_sound = booster.play();
						player_sound.soundTransform = muter;
						
						h_Velocity = MAX_SPEED;
						dashCount--;
					}	
				}
			}
			if (!airbourne)
			{
				dashCount = MAX_DASHES;
			}
		}
		
		private function groundMovement():void 
		{
			//moving right
			if (ableRight)
			{				
				if (Input.Down(rightKey))
				{
					if (!sticking)
					{						
						if (horiz_velocity < (speed * GameTime.ElapsedGameTimeSeconds))
						{
							horiz_velocity ++;
						}				
					}
					if (sticking)
					{
						if (Input.Down(rightKey))
						{
							sticking = false;
							horiz_velocity = 5;							
						}
					}
				}
			}
			
			//moving left
			if (ableLeft)
			{
				if (Input.Down(leftKey))
				{	
					if (!sticking)
					{
						if (horiz_velocity > -(speed * GameTime.ElapsedGameTimeSeconds))
						{
							horiz_velocity --;
						}						
					}
					if (sticking)
					{
						if (Input.Down(leftKey))
						{
							sticking = false;
							horiz_velocity = -5;							
						}
					}
				}				
			}
			
			//jumping
			if (Input.Down(upKey) && !airbourne)
			{
				if (!sticking)
				{
					var player_sound:SoundChannel = new SoundChannel();
					var muter:SoundTransform = new SoundTransform();
					muter.volume = .3;
					jumpSound = new (Assets.player1_Jump_Sound) as Sound;
					player_sound = jumpSound.play();
					player_sound.soundTransform = muter;
					vert_velocity = 30;
					airbourne = true;
				}		
				if (sticking)
				{
					if (Input.Down(leftKey))
					{
						sticking = false;
						vert_velocity = 20;
						horiz_velocity = -5;
						airbourne = true;
					}
					if (Input.Down(rightKey))
					{
						sticking = false;
						vert_velocity = 20;
						horiz_velocity = 5;
						airbourne = true;
					}					
				}
			}
		}
		
		private function checkStatus():void 
		{
			if (!sticking)
			{
				if (m_Player.y < 0)
				{
					airbourne = true;			
				}
				if (m_Player.y > 0)
				{
					airbourne = false;
					m_Player.y = 0;	
				}
			}
			if (sticking)
			{
				airbourne = false;
				vert_velocity = 0;
				horiz_velocity = 0;
				countdown();
			}
		}
		
		private function countdown():void 
		{
			if (getTimer() / 1000 >= timeToStop)
			{
				sticking = false;
			}
		}
		
		private function move():void
		{
			if (airbourne && vert_velocity > -20)
			{
				vert_velocity -= gravity;
			}
			if (!airbourne)
			{
				vert_velocity = 0;
			}
			m_Player.x += horiz_velocity;
			m_Player.y -= vert_velocity;
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return ms_EventDispatcher;
		}
	}
}