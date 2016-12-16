package states 
{
	import core.Game;
	import core.Config;
	import core.SoundManager;
	import core.State;
	import ui.Label;
	import core.Key;
	import flash.events.KeyboardEvent;
	import flash.utils.setInterval;
	
	public class GameOver extends State{
		
		private var _lblYourScore:Label;
		private var _lblStartOver:Label;
		private var _restartDelay:Number = 100;
		private var _isRestartAvalible:Boolean = false;
		
		public function GameOver(fsm:Game, soundManager:SoundManager, score:Number){
			super(fsm, soundManager);	
			_lblYourScore = new Label("YOUR SCORE WAS: "+score, 70, Config.WHITE, "Ostrich", true);
			_lblYourScore.x = Config.WORLD_CENTER_X - _lblYourScore.textWidth * 0.5;
			_lblYourScore.y = 150;	
			
			_lblStartOver = new Label("PRESS ANY KEY TO START OVER", 45, Config.WHITE, "Ostrich", true);
			_lblStartOver.x = Config.WORLD_CENTER_X - _lblStartOver.textWidth * 0.5;
			_lblStartOver.y = Config.WORLD_HEIGHT - _lblStartOver.textHeight - 50;
			
			addChild(_lblYourScore);
			Key.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
		}
		
		override public function update():void{
			_restartDelay--;
			if (_restartDelay < 0 && !_isRestartAvalible){
				_isRestartAvalible = true;
				addChild(_lblStartOver);
			}
			super.update();
		}
		
		private function onKeyDown(e:KeyboardEvent):void{
			if (_isRestartAvalible){
				_fsm.changeState(Game.GAME_STATE_MENU);
			}
		}
		
		override public function destroy():void{
			removeChild(_lblYourScore);
			_lblYourScore = null;
			removeChild(_lblStartOver);
			_lblYourScore = null;
			trace("s");
			Key.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			super.destroy();
		}
		
	}

}