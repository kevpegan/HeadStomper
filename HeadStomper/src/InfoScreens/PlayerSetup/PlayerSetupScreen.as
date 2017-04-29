package InfoScreens.PlayerSetup 
{
	import Events.MenuEvents.AskRounds;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import Levels.First.Stage.Level;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class PlayerSetupScreen extends Sprite
	{
		//consts
		private const size:int = 50;
		
		//backing
		private var m_Backing:Sprite;
		private var m_Title:TextField;
		
		//texts
		private var titleText:String;
		
		//avatars
		private var m_Player1_avatar:Sprite;
		private var m_Player2_avatar:Sprite;
		
		//colors
		private var m_Fire:Sprite;
		private var m_Water:Sprite;
		private var m_Earth:Sprite;
		private var m_Air:Sprite;
		
		//color codes
		private var fire_color:uint;
		private var water_color:uint;
		private var earth_color:uint;
		private var air_color:uint;
		
		//checks
		private var player1_is_selecting:Boolean;
		private var player2_is_selecting:Boolean;
		
		//theColors
		public var player1_Color:uint;
		public var player2_Color:uint;
		
		//references
		private var stageWidth:int;
		private var stageHeight:int;
		
		public function PlayerSetupScreen(sX:int, sY:int) 
		{
			stageWidth = sX;
			stageHeight = sY;
			
			fire_color = 0xB12E32;
			water_color = 0x355894;
			earth_color = 0x575938;
			air_color = 0xD2EDF3;
			
			player1_is_selecting = true;
			player2_is_selecting = false;
			
			titleText = "Player 1 choose your color!";
		}
		
		//public
		public function init():void
		{
			theBackingTho();
			letThereBeColor();
			avatarState();
			heyLookListen();
		}
		
		public function erase():void
		{
			//colors
			if (contains(m_Air))
			{
				removeChild(m_Air);
			}
			if (contains(m_Water))
			{
				removeChild(m_Water);				
			}
			if (contains(m_Earth))
			{
				removeChild(m_Earth);				
			}
			if (contains(m_Fire))
			{
				removeChild(m_Fire);				
			}
			//avatars
			if (contains(m_Player1_avatar))
			{
				removeChild(m_Player1_avatar);				
			}
			if (contains(m_Player2_avatar))
			{
				removeChild(m_Player2_avatar);
			}
			//etc
			if (contains(m_Title))
			{
				removeChild(m_Title);
			}
			if (contains(m_Backing))
			{
				removeChild(m_Backing);
			}
		}
		//private
		
		private function theBackingTho():void 
		{
			m_Backing = new Sprite();
			
			m_Backing.graphics.beginFill(0x000000);
			m_Backing.graphics.drawRect(0, 0, stageWidth, stageHeight);
			m_Backing.graphics.endFill();
			
			addChild(m_Backing);	
			
			m_Title = new TextField();
			
			m_Title.selectable = false;
			m_Title.width = 150;
			m_Title.height = 25;
			m_Title.text = titleText;
			m_Title.textColor = (0xFFFFFF);
			m_Title.x = stageWidth / 2 - 50;
			m_Title.y = 150;
			
			addChild(m_Title);
		}
		
		private function heyLookListen():void 
		{
			m_Fire.addEventListener(MouseEvent.ROLL_OVER, eh_MouseOver_Fire);
			m_Fire.addEventListener(MouseEvent.CLICK, eh_setFire);
			m_Fire.addEventListener(MouseEvent.ROLL_OUT, eh_MouseOut_Fire);
			
			m_Water.addEventListener(MouseEvent.ROLL_OVER, eh_MouseOver_Water);
			m_Water.addEventListener(MouseEvent.CLICK, eh_setWater);
			m_Water.addEventListener(MouseEvent.ROLL_OUT, eh_MouseOut_Water); 
			
			m_Earth.addEventListener(MouseEvent.ROLL_OVER, eh_MouseOver_Earth);
			m_Earth.addEventListener(MouseEvent.CLICK, eh_setEarth);
			m_Earth.addEventListener(MouseEvent.ROLL_OUT, eh_MouseOut_Earth); 
			
			m_Air.addEventListener(MouseEvent.ROLL_OVER, eh_MouseOver_Air);			
			m_Air.addEventListener(MouseEvent.CLICK, eh_setAir);
			m_Air.addEventListener(MouseEvent.ROLL_OUT, eh_MouseOut_Air); 
		}
		
		private function eh_setAir(e:MouseEvent):void 
		{
			if (player2_is_selecting)
			{
				removeChild(m_Player2_avatar);
				
				m_Player2_avatar = new Sprite();
				
				m_Player2_avatar.graphics.beginFill(air_color);
				m_Player2_avatar.graphics.drawRect(250, 400, size, size);
				m_Player2_avatar.graphics.endFill();
			
				addChild(m_Player2_avatar);	
				
				player2_is_selecting = false;
				
				player2_Color = air_color;
				
				Level.eventDispatcher.dispatchEvent(new AskRounds(AskRounds.ASK_ROUNDS));
			}
			if (player1_is_selecting)
			{
				removeChild(m_Player1_avatar);
				
				m_Player1_avatar = new Sprite();
				
				m_Player1_avatar.graphics.beginFill(air_color);
				m_Player1_avatar.graphics.drawRect(700, 400, size, size);
				m_Player1_avatar.graphics.endFill();
			
				addChild(m_Player1_avatar);	
				
				player1_is_selecting = false;
				player2_is_selecting = true;
				
				titleText = "Player 2 choose your color!";
				
				m_Title.text = titleText;
				player1_Color = air_color;
			}
		}
		
		private function eh_setEarth(e:MouseEvent):void 
		{
			if (player2_is_selecting)
			{
				removeChild(m_Player2_avatar);
				
				m_Player2_avatar = new Sprite();
				
				m_Player2_avatar.graphics.beginFill(earth_color);
				m_Player2_avatar.graphics.drawRect(250, 400, size, size);
				m_Player2_avatar.graphics.endFill();
			
				addChild(m_Player2_avatar);	
				player2_is_selecting = false;
				
				player2_Color = earth_color;
				
				Level.eventDispatcher.dispatchEvent(new AskRounds(AskRounds.ASK_ROUNDS));
			}
			if (player1_is_selecting)
			{
				removeChild(m_Player1_avatar);
				
				m_Player1_avatar = new Sprite();
				
				m_Player1_avatar.graphics.beginFill(earth_color);
				m_Player1_avatar.graphics.drawRect(700, 400, size, size);
				m_Player1_avatar.graphics.endFill();
			
				addChild(m_Player1_avatar);	
				
				player1_is_selecting = false;
				player2_is_selecting = true;
				
				titleText = "Player 2 choose your color!";
				m_Title.text = titleText;
				
				player1_Color = earth_color;
			}
		}
		
		private function eh_setWater(e:MouseEvent):void 
		{
			if (player2_is_selecting)
			{
				removeChild(m_Player2_avatar);
				
				m_Player2_avatar = new Sprite();
				
				m_Player2_avatar.graphics.beginFill(water_color);
				m_Player2_avatar.graphics.drawRect(250, 400, size, size);
				m_Player2_avatar.graphics.endFill();
			
				addChild(m_Player2_avatar);	
				player2_is_selecting = false;
				
				player2_Color = water_color;
				
				Level.eventDispatcher.dispatchEvent(new AskRounds(AskRounds.ASK_ROUNDS));
			}
			if (player1_is_selecting)
			{
				removeChild(m_Player1_avatar);
				
				m_Player1_avatar = new Sprite();
				
				m_Player1_avatar.graphics.beginFill(water_color);
				m_Player1_avatar.graphics.drawRect(700, 400, size, size);
				m_Player1_avatar.graphics.endFill();
			
				addChild(m_Player1_avatar);	
				
				player1_is_selecting = false;
				player2_is_selecting = true;
				
				titleText = "Player 2 choose your color!";
				m_Title.text = titleText;
				
				player1_Color = water_color;
			}
		}
		
		private function eh_setFire(e:MouseEvent):void 
		{
			if (player2_is_selecting)
			{
				removeChild(m_Player2_avatar);
				
				m_Player2_avatar = new Sprite();
				
				m_Player2_avatar.graphics.beginFill(fire_color);
				m_Player2_avatar.graphics.drawRect(250, 400, size, size);
				m_Player2_avatar.graphics.endFill();
			
				addChild(m_Player2_avatar);	
				player2_is_selecting = false;
				
				player2_Color = fire_color;
				
				Level.eventDispatcher.dispatchEvent(new AskRounds(AskRounds.ASK_ROUNDS));
			}
			if (player1_is_selecting)
			{
				removeChild(m_Player1_avatar);
				
				m_Player1_avatar = new Sprite();
				
				m_Player1_avatar.graphics.beginFill(fire_color);
				m_Player1_avatar.graphics.drawRect(700, 400, size, size);
				m_Player1_avatar.graphics.endFill();
			
				addChild(m_Player1_avatar);	
				
				player1_is_selecting = false;
				player2_is_selecting = true;
				
				titleText = "Player 2 choose your color!";
				m_Title.text = titleText;
				
				player1_Color = fire_color;
			}
		}
		
		private function eh_MouseOut_Fire(e:MouseEvent):void 
		{
			m_Fire.alpha = 1;
		}
		
		private function eh_MouseOver_Fire(e:MouseEvent):void 
		{
			m_Fire.alpha = .5;
		}
		
		private function eh_MouseOut_Water(e:MouseEvent):void 
		{
			m_Water.alpha = 1;
		}
		
		private function eh_MouseOver_Water(e:MouseEvent):void 
		{
			m_Water.alpha = .5;
		}
		
		private function eh_MouseOut_Earth(e:MouseEvent):void 
		{
			m_Earth.alpha = 1;
		}
		
		private function eh_MouseOver_Earth(e:MouseEvent):void 
		{
			m_Earth.alpha = .5;
		}
		
		private function eh_MouseOut_Air(e:MouseEvent):void 
		{
			m_Air.alpha = 1;
		}
		
		private function eh_MouseOver_Air(e:MouseEvent):void 
		{
			m_Air.alpha = .5;
		}
		
		private function avatarState():void 
		{
			m_Player1_avatar = new Sprite();
			
			m_Player1_avatar.graphics.beginFill(0xFFFFFF);
			m_Player1_avatar.graphics.drawRect(700, 400, size, size);
			m_Player1_avatar.graphics.endFill();
			
			addChild(m_Player1_avatar);	
			
			m_Player2_avatar = new Sprite();
			
			m_Player2_avatar.graphics.beginFill(0xFFFFFF);
			m_Player2_avatar.graphics.drawRect(250, 400, size, size);
			m_Player2_avatar.graphics.endFill();
			
			addChild(m_Player2_avatar);	
		}
		
		private function letThereBeColor():void 
		{
			letThereBeFire();
			letThereBeWater();
			letThereBeEarth();
			letThereBeAir();
		}
		
		private function letThereBeFire():void 
		{
			m_Fire = new Sprite();
			
			m_Fire.graphics.beginFill(fire_color);
			m_Fire.graphics.drawRect(575, 200, size, size);
			m_Fire.graphics.endFill();
			
			addChild(m_Fire);			
		}
		
		private function letThereBeWater():void 
		{
			m_Water = new Sprite();
			
			m_Water.graphics.beginFill(water_color);
			m_Water.graphics.drawRect(500, 200, size, size);
			m_Water.graphics.endFill();
			
			addChild(m_Water);			
		}
		
		private function letThereBeEarth():void 
		{
			m_Earth = new Sprite();
			
			m_Earth.graphics.beginFill(earth_color);
			m_Earth.graphics.drawRect(425, 200, size, size);
			m_Earth.graphics.endFill();
			
			addChild(m_Earth);
		}
		
		private function letThereBeAir():void 
		{
			m_Air = new Sprite();
			
			m_Air.graphics.beginFill(air_color);
			m_Air.graphics.drawRect(350, 200, size, size);
			m_Air.graphics.endFill();
			
			addChild(m_Air);
		}
	}

}