package core 
{
	import com.adobe.tvsdk.mediacore.ABRControlParameters;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.net.URLRequest;
	import states.Play;
	
	
	[SWF(width="1280", height="720", backgroundColor="0x111111", frameRate = "50")]
	public class Game extends Sprite {
		private var _currentState:State;
		
		public function Game() 
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
			changeState(core.Config.GAME_STATE_PLAY);
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true); 
			addEventListener(Event.DEACTIVATE, onDeactive, false, 0, true);
		}
		
		public function changeState(newState:Number):void{
			if (_currentState != null){
				_currentState.destroy();
				removeChild(Sprite(_currentState));
			}
			
			switch(newState){
				case core.Config.GAME_STATE_PLAY:
					_currentState = new Play(this);
					break;
				default:
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