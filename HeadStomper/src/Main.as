package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import Utils.GameTime;
	import Utils.InputContent.Input;	
	
	
	/**
	 * ...
	 * @author Kevin Egan
	 */
	public class Main extends Sprite 
	{
		private var m_GameApp:GameApp;
		private static var ms_EventDispatcher:IEventDispatcher = new EventDispatcher();	
	
		public function Main():void 
		{
			init();
		}
		
		private function init(e:Event = null):void 
		{
			initGameApp();
			initEventListeners();			
		}
		
		private function initGameApp():void 
		{
			m_GameApp = new GameApp(stage.stageWidth, stage.stageHeight);
			
			m_GameApp.init();
			
			addChild(m_GameApp);
		}
		
		private function initEventListeners():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function keyDownListener(e:KeyboardEvent):void
		{
			Input.KeyDownListener(e);
		}
		
		private function keyUpListener(e:KeyboardEvent):void
		{
			Input.KeyUpListener(e);
		}
		
		private function update(e:Event):void
		{
			GameTime.Update();	
			
			m_GameApp.Update();
			
			Input.Update();
		}		
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return ms_EventDispatcher;
		}
	}
	
}