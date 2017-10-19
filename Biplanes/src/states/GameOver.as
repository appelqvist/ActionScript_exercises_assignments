package states 
{
	import core.Game;
	import core.State;
	import manager.SoundManager;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.core.Starling;
	import core.Game;
	import core.State;
	import core.Config;
	import flash.events.Event;
	import gameObject.Background;
	import core.Key;
	
	/**
	 * Game Over
	 * @author Andréas Appelqvist
	 */
	public class GameOver extends State {
		
		private var _lblCongrats:TextField;
		private var _background:Background;
		private var _playAgain:TextField;
		
		public function GameOver(fsm:Game, sm:SoundManager, winner:String) {
			super(fsm, sm);
			
			_background = new Background(Assets.getBitmap(Config.backgroundSky));
			addChild(_background);
			
			var str:String;
			switch(winner){
				case Play.WIN_LEFT:
					str = "CONGRATULATIONS!\nRED PLAYER WON!";
					break;
				case Play.WIN_RIGHT:
					str = "CONGRATULATIONS!\nGREEN PLAYER WON!";
					break;
				default:
					str = "TOO BAD, BOTH LOST!"
					break;
			}
			
			_lblCongrats = new TextField(700, 400, str, new TextFormat(Config.defaultFont, 100, 0xFFFFFF));
			_lblCongrats.x = Config.worldWidth * 0.5 - _lblCongrats.width * 0.5;
			_lblCongrats.y = 100;
			addChild(_lblCongrats);
			
			_playAgain = new TextField(800, 400, "PRESS SPACE TO START A NEW GAME", new TextFormat(Config.defaultFont, 50, 0xFFFFFF));
			_playAgain.x = Config.worldWidth * 0.5 - _playAgain.width * 0.5;
			_playAgain.y = Config.worldHeight-300;
			addChild(_playAgain);
		}
		
		
		public override function update(deltaTime:Number):void {
			super.update(deltaTime);
			if (Key.isKeyPressed(Key.SPACE)){
				_fsm.changeState(_fsm.GAME_STATE_INSTRUCTION);
			}
		}
		
		public override function destroy():void{
			removeChild(_lblCongrats);
			_lblCongrats.dispose();
			_lblCongrats = null;
			
			removeChild(_background);
			_background.dispose();
			_background = null;
			
			removeChild(_playAgain);
			_playAgain.dispose();
			_playAgain = null;
			
			super.destroy();
		}
	}
}