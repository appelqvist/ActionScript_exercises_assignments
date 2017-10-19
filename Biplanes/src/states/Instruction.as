package states {
	import core.Game;
	import core.State;
	import core.Config;
	import gameObject.Background;
	import manager.SoundManager;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import core.Key;
	
	/**
	 * Instructions
	 * @author Andréas Appelqvist
	 */
	public class Instruction extends State {
		
		private var _background:Background;
		private var _rules:TextField;
		private var _controllsTitle:TextField;
		private var _leftContr:TextField;
		private var _rightContr:TextField;
		private var _start:TextField;
		private var _pause:TextField;
		private var _hasBeenReleased:Boolean = false;;
		
		public function Instruction(fsm:Game, sm:SoundManager){
			super(fsm,sm);
			_background = new Background(Assets.getBitmap(Config.backgroundSky));
			addChild(_background);
			
			_rules = new TextField(700, 200, "THE PLAYER THAT IS THE FIRST TO CRASH THREE TIMES LOSES THE GAME", new TextFormat(Config.defaultFont, 60, 0xFFFFFF));
			_rules.x = Config.worldWidth * 0.5 - _rules.width * 0.5;
			addChild(_rules);
			
			_controllsTitle = new TextField(300, 100, "CONTROLS:", new TextFormat(Config.defaultFont, 54, 0xFFFFFF));
			_controllsTitle.x = Config.worldWidth * 0.5 - _controllsTitle.width * 0.5;
			_controllsTitle.y = 200;
			addChild(_controllsTitle);
			
			_leftContr = new TextField(300, 400, "RED PLAYER:\n A - TURN LEFT\n D - TURN RIGHT\n W - LIFT OFF\n V - SHOOT", new TextFormat(Config.defaultFont, 45, 0xFFFFFF));
			_leftContr.x = 50;
			_leftContr.y = 250;
			addChild(_leftContr);
				
			_rightContr = new TextField(450, 400, "GREEN PLAYER:\n L ARROW - TURN LEFT\n R ARROW - TURN RIGHT\n UP ARROW - LIFT OFF\n M - SHOOT", new TextFormat(Config.defaultFont, 45, 0xFFFFFF));
			_rightContr.x = Config.worldWidth - _rightContr.width;
			_rightContr.y = 250;
			addChild(_rightContr);
			
			_start = new TextField(600, 100, "PRESS SPACE WHEN BOTH ARE READY", new TextFormat(Config.defaultFont, 40, 0xFFFFFF));
			_start.x = Config.worldWidth * 0.5  - _start.width * 0.5;
			_start.y = Config.worldHeight - 100;
			addChild(_start);
			
			_pause = new TextField(300, 100, "P - PAUSE", new TextFormat(Config.defaultFont, 45, 0xFFFFFF));
			_pause.x = Config.worldWidth * 0.5  - _pause.width * 0.5;
			_pause.y = Config.worldHeight - 400;
			addChild(_pause);
		}
		
		
		public override function update(deltaTime:Number):void{
			super.update(deltaTime);
			
			if(!Key.isKeyPressed(Key.SPACE))
				_hasBeenReleased = true;
			
			if (Key.isKeyPressed(Key.SPACE) && _hasBeenReleased){
				_fsm.changeState(_fsm.GAME_STATE_PLAY);
			}			
		}
		
		public override function destroy():void{
			removeChild(_background);
			_background.dispose();
			_background = null;
			
			removeChild(_rules);
			_rules.dispose();
			_rules = null;
			
			removeChild(_controllsTitle);
			_controllsTitle.dispose();
			_controllsTitle = null;
			
			removeChild(_leftContr);
			_leftContr.dispose();
			_leftContr = null;
			
			removeChild(_rightContr);
			_rightContr.dispose();
			_rightContr = null;
			
			removeChild(_start);
			_start.dispose();
			_start = null;
			
			removeChild(_pause);
			_pause.dispose();
			_pause = null;
		}
	}
}