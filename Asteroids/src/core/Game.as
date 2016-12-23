package core 
{
	import com.adobe.tvsdk.mediacore.ABRControlParameters;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.net.URLRequest;
	import states.GameOver;
	import states.Menu;
	import states.Play;
	import Assets;
	
	
	[SWF(width="1280", height="720", backgroundColor="0x111111", frameRate = "30")]
	public class Game extends Sprite {
		public static const ASSETS:Assets = new Assets();
		private var _currentState:State;
		private var _soundManager:SoundManager;
		
		public static const GAME_STATE_MENU:Number = 0;
		public static const GAME_STATE_PLAY:Number = 1;
		public static const GAME_STATE_GAMEOVER:Number = 2;
		
		public function Game() {
			Config.addEventListener(Event.COMPLETE, init, false, 0, true);
			Config.loadConfig();
		}
		
		private function init(e:Event = null):void{
			if (!stage){
				addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
				return;
			}
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Key.init(stage);
			changeState(GAME_STATE_MENU);
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true); 
			addEventListener(Event.DEACTIVATE, onDeactive, false, 0, true);
			_soundManager = new SoundManager();
			_soundManager.playBackground();
		}
		
		public function changeState(newState:Number, score:Number = 0):void{
			if (_currentState != null){
				_currentState.destroy();
				removeChild(Sprite(_currentState));
			}
			
			switch(newState){
				case GAME_STATE_PLAY:
					_currentState = new Play(this, _soundManager);
					break;
				case GAME_STATE_GAMEOVER:
					_currentState = new GameOver(this, _soundManager, score);
					break;
				default:
					_currentState = new Menu(this, _soundManager);
					break;
			}
			
			addChild(Sprite(_currentState));
		}
		
		private function onDeactive(e:Event):void{
			removeEventListener(Event.DEACTIVATE, onDeactive);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ACTIVATE, onActivate, false, 0, true);
		}
		
		private function onActivate(e:Event):void{
			removeEventListener(Event.ACTIVATE, onActivate);
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			addEventListener(Event.DEACTIVATE, onDeactive, false, 0, true);
		}
		
		private function onEnterFrame(e:Event):void{
			if(_currentState != null)
				_currentState.update();
		}
		
	}

}