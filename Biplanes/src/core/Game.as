package core{
	import Assets;
	import manager.SoundManager;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import states.*;
	
	/**
	 * Handles the main gameloop, switch game states.
	 * @author Andreas Appelqvist
	 */
	public class Game extends Sprite {
		public static const ASSETS:Assets = new Assets();
		
		public const GAME_STATE_MENU:Number = 0;
		public const GAME_STATE_INSTRUCTION:Number = 1;
		public const GAME_STATE_PLAY:Number = 2;
		public const GAME_STATE_GAMEOVER:Number = 3;
		
		public var _sm:SoundManager = new SoundManager();
		public var _currentState:State;
		
		public function Game() {
			super();
			this.init();
		}
		
		private function init():void{
			
			if (!stage){
				addEventListener(Event.ADDED_TO_STAGE, init);
				return;
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			Assets.initFFParticleSystem();
			
			_sm.playBackground();			
			changeState(GAME_STATE_MENU);
		}
		
		public function changeState(newState:Number, winner:String = "-1"):void{
			if (_currentState != null){
				_currentState.destroy();
				removeChild(Sprite(_currentState));
			}
			
			switch(newState){
				case GAME_STATE_PLAY:
					_currentState = new Play(this, _sm);
					break;
				case GAME_STATE_GAMEOVER:
					_currentState = new GameOver(this, _sm, winner);
					break;
				case GAME_STATE_INSTRUCTION:
					_currentState = new Instruction(this, _sm);
					break;
				default:
					_currentState = new Menu(this, _sm);
					break;
			}
			addChild(Sprite(_currentState));
		}
		
		/**
		 * The main game loop.
		 */
		private function update(e:EnterFrameEvent):void{
			if (_currentState != null){
				_currentState.update(e.passedTime);
			}
		}
	}
}