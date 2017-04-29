package Levels 
{
	import Events.GameEvents.Stomped;
	import Events.MovementBlocks.SendLeft;
	import Events.MovementBlocks.SendRight;
	import Events.MovementBlocks.Unblock;
	import Events.MovementBlocks.Spiderman;
	import Events.GameEvents.Stomped;
	import Events.MovementBlocks.Unstuck;
	import Events.MovementBlocks.Unstuck;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import Levels.First.Stage.Level;
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class CollisionManager 
	{
		//the objects
		private var m_player1:Sprite;
		private var m_player2:Sprite;
		private var m_pillar:Sprite;
		
		//sound
		private var stomp_sound:Sound;
		
		//other things
		private var player1Vert:int;
		private var player2Vert:int;
		
		//checks
		public var which:int;
		private var stuck:Boolean;
		private var stuck2:Boolean;
		private var prevHit:Boolean;
		
		public function CollisionManager() 
		{
			m_player1 = new Sprite();
			m_player2 = new Sprite();
			m_pillar = new Sprite();
			
			prevHit = false;
		}
		
		public function Update(p1:Sprite, p1_V:int,  p2:Sprite, p2_V:int, pillar:Sprite):void
		{
			player1Vert = p1_V;
			player2Vert = p2_V;
			locationUpdate(p1, p2, pillar);
			checkCollisions();
		}
		
		private function locationUpdate(p1:Sprite, p2:Sprite, pillar:Sprite):void 
		{
			m_player1 = p1;
			m_player2 = p2;
			m_pillar = pillar;
		}
		
		private function checkCollisions():void
		{
			var playerhit:Boolean = m_player1.hitTestObject(m_player2);
			var pillarhit:Boolean = m_player1.hitTestObject(m_pillar);
			var pillarhit2:Boolean = m_player2.hitTestObject(m_pillar);
			
			//player collision
			if (playerhit)
			{
				if (m_player1.x > m_player2.x + 910)
				{		
					//left					
					Level.eventDispatcher.dispatchEvent(new SendLeft(SendLeft.SEND_LEFT));
				}
				if (m_player1.x <= m_player2.x + 910)
				{
					//right					
					Level.eventDispatcher.dispatchEvent(new SendRight(SendRight.SEND_RIGHT));
				}
				if (m_player1.y <= m_player2.y + 30 && m_player1.x + 25 > m_player2.x + 910 && m_player1.x + 25 < m_player2.x + 960)
				{
					if (player1Vert <= -20)
					{
						//player 2 got stomped
						which = 2;
						
						Level.eventDispatcher.dispatchEvent(new Stomped(Stomped.STOMPED));	
						stomp_sound = new Assets.stomped() as Sound;
						stomp_sound.play();
					}
				}
				if (m_player2.y <= m_player1.y + 30 && m_player2.x + 935 > m_player1.x && m_player2.x + 935 < m_player1.x + 50)
				{
					if (player2Vert <= -20)
					{
						//player 1 got stomped
						which = 1;
					
						Level.eventDispatcher.dispatchEvent(new Stomped(Stomped.STOMPED));	
						stomp_sound = new Assets.stomped() as Sound;
						stomp_sound.play();
					}					
				}
			}
			if (!playerhit)
			{
				//unblock
				Level.eventDispatcher.dispatchEvent(new Unblock(Unblock.UNBLOCK_MOVEMENT));
			}
			
			//pillar collision
			if (pillarhit)
			{
				if (m_player1.y < 0)
				{
					if (!stuck)
					{
						stuck = true;
						which = 1;
						Level.eventDispatcher.dispatchEvent(new Spiderman(Spiderman.STICKY));
					}
				}
			}
			if (!pillarhit)
			{
				stuck = false;
				which = 1;
				Level.eventDispatcher.dispatchEvent(new Unstuck(Unstuck.UNSTUCK));
			}
			if (pillarhit2)
			{
				if (m_player2.y < 0)
				{
					if (!stuck2)
					{
						stuck2 = true;
						which = 2;
						Level.eventDispatcher.dispatchEvent(new Spiderman(Spiderman.STICKY));
					}
				}
			}
			if (!pillarhit2)
			{
				stuck2 = false;
				which = 2;
				Level.eventDispatcher.dispatchEvent(new Unstuck(Unstuck.UNSTUCK));
			}
			if (m_player1.x <= 0)
			{
				m_player1.x = 0;
			}
			if (m_player2.x <= -910)
			{
				m_player2.x = -910;
			}
			if (m_player1.x >= 910)
			{
				m_player1.x = 910;
			}
			if (m_player2.x >= 0)
			{
				m_player2.x = 0;
			}
		}
	}

}