package 
{
	import assets.GameOver;
	import com.adobe.tvsdk.mediacore.ABRControlParameters;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	[SWF(width="1280", height="720", backgroundColor="0x000000", frameRate="30")]
	public class Document extends Sprite {
		private var _assets:Assets;
		private var _currentState:IState;
		
		public function Document() 
		{
			if (stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Key.init(stage);
			changeState(Config.GAME_STATE_MENU);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true); 
			addEventListener(Event.DEACTIVATE, onDeactive, false, 0, true); 
		}
		
		public function changeState(newState:Number):void{
			if (_currentState != null){
				_currentState.destroy();
				removeChild(Sprite(_currentState));
			}
			
			switch(newState){
				case Config.GAME_STATE_PLAY:
					_currentState = new Game(this);
					break;
				case Config.GAME_STATE_GAMEOVER:
					_currentState = new GameOver(this);
					break;
				case Config.GAME_STATE_INSTRUCTIONS:
					_currentState = new Instructions(this);
					break;
				default:
					_currentState = new MainMenu(this);
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