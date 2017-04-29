package Levels.Assets
{
	import flash.display.Sprite;
	import Utils.GameTime;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Pillars extends Sprite
	{
		//constants
		private const MAX_DURATION:int = 10;
		private const MIN_DURATION:int = 5;
		private const WIDTH:int = 75;
		private const HEIGHT:int = 500;
		private const BOUNDARY_LEFT:int = 200;
		private const BOUNDARY_RIGHT:int = 760;
		
		//references 
		private var stageHeight:int;
		private var stageWidth:int;
		
		//attributes
		public var locX:int;
		public var locY:int;
		public var duration:int;
		private var pillarHeight:int;
		private var pillarWidth:int;
		private var speed:int = 400 * GameTime.ElapsedGameTimeSeconds;
		private var currentTime:int;
		private var timeToStop:int;
		
		//checks
		private var goingUp:Boolean;
		private var holdPosition:Boolean;
		private var goingDown:Boolean;
		private var allTheWayDown:Boolean;
		
		//parts
		private var m_Pillar:Sprite;
		
		public function Pillars(sX:int, sY:int)
		{
			stageWidth = sX;
			stageHeight = sY;
			goingDown = false;
			goingUp = false;
			holdPosition = false
			allTheWayDown = false;
		}
		
		//public 
		
		public function init():void
		{
			decideAttributes();
			draw();
			place();
			goingUp = true;
		}
		
		public function Update():Sprite
		{
			if (goingUp)
			{
				rise();
			}
			if (goingDown)
			{
				fall();
			}
			if (holdPosition)
			{
				countdown();
			}
			if (allTheWayDown)
			{
				reset();
			}
			return m_Pillar;
		}
		
		
		public function erase():void
		{
			removeChild(m_Pillar);
		}
		
		//accessor
		
		public function get location():Sprite
		{
			return m_Pillar;
		}
		
		public function get size():int
		{
			return m_Pillar.height;
		}
		
		//private
		
		private function decideAttributes():void
		{
			decideSize();
			decideLocation();
			decideDuration();
		}
		
		private function draw():void
		{
			drawPillar();
		}
		
		private function drawPillar():void
		{
			m_Pillar = new Sprite();
			
			m_Pillar.graphics.beginFill(0xCCCCCC);
			m_Pillar.graphics.drawRect(0, 0, pillarWidth, pillarHeight);
			m_Pillar.graphics.endFill();
			
			addChild(m_Pillar);
		}
		
		private function place():void
		{
			m_Pillar.x = locX;
			m_Pillar.y = locY;
		}
		
		private function decideSize():void
		{
			//width
			pillarWidth = WIDTH;
			
			//height
			pillarHeight = HEIGHT;
		}
		
		private function decideLocation():void
		{
			locX = (Math.random() * BOUNDARY_RIGHT) + BOUNDARY_LEFT;
			locY = 540 + pillarHeight;
		}
		
		private function decideDuration():void
		{
			duration = (Math.random() * MAX_DURATION - MIN_DURATION) + MIN_DURATION;
			if (duration < MIN_DURATION)
			{
				duration = MIN_DURATION;
			}
		}
		
		private function countdown():void
		{
			if (getTimer() / 1000 >= timeToStop)
			{
				holdPosition = false;
				goingDown = true;
			}
		}
		
		private function fall():void
		{
			if (m_Pillar.y <= stageHeight)
			{
				m_Pillar.y += speed;
			}
			if (m_Pillar.y >= stageHeight)
			{
				goingDown = false;
				allTheWayDown = true;
			}
		}
		
		private function rise():void
		{
			if (m_Pillar.y >= stageHeight - pillarHeight)
			{
				m_Pillar.y -= speed;
			}
			if (m_Pillar.y <= stageHeight - pillarHeight)
			{
				goingUp = false;
				holdPosition = true;
			}
			currentTime = getTimer() / 1000;
			timeToStop = currentTime + duration;
		}
		
		private function reset():void 
		{
			decideLocation();
			m_Pillar.x = locX;
			m_Pillar.y = locY;
			goingUp = true;
			allTheWayDown = false;
		}
	}
}