package 
{
	import flash.display.Sprite;
	public class Instructions extends Sprite implements IState {
		
		private var _document:Document;
		private var _lblInstruction:Label;
		private var _lblHowToWin:Label;
		private var _lblHowToServe:Label;
		private var _lblHowToPause:Label;
		private var _lblLeftPaddleIns:Label;
		private var _lblRightPaddleIns:Label;
		private var _lblContinue:Label;
		
		
		public function Instructions(document:Document){
			super();
			_document = document;
			
 			_lblInstruction = new Label("GAME INSTRUCTIONS",
									60,
									Config.WHITE,
									"Ostrich",
									true);
			addChild(_lblInstruction);
			_lblInstruction.x = Config.WORLD_CENTER_X - _lblInstruction.textWidth * 0.5;
			_lblInstruction.y = 40;
			
			_lblHowToWin = new Label("FIRST TO " + Config.GAME_WINNING_POINTS + " GOALS WILL WIN",
									40,
									Config.WHITE,
									"Ostrich",
									true);
			addChild(_lblHowToWin);
			_lblHowToWin.x = Config.WORLD_CENTER_X - _lblHowToWin.textWidth * 0.5;
			_lblHowToWin.y = 150;
			
			_lblLeftPaddleIns = new Label("LEFT PADDLE: W FOR UP AND S FOR DOWN",
										40,
										Config.WHITE,
										"Ostrich",
										true);
			addChild(_lblLeftPaddleIns);
			_lblLeftPaddleIns.x = Config.WORLD_CENTER_X - _lblLeftPaddleIns.textWidth * 0.5;
			_lblLeftPaddleIns.y = 200;
			
			
			_lblRightPaddleIns = new Label("RIGHT PADDLE: MOVE CURSOR UP AND DOWN",
										40,
										Config.WHITE,
										"Ostrich",
										true);
			addChild(_lblRightPaddleIns);
			_lblRightPaddleIns.x = Config.WORLD_CENTER_X - _lblRightPaddleIns.textWidth * 0.5;
			_lblRightPaddleIns.y = 250;
			
			
			_lblHowToServe = new Label("PRESS SPACE TO SERVE",
										40,
										Config.WHITE,
										"Ostrich",
										true);
			addChild(_lblHowToServe);
			_lblHowToServe.x = Config.WORLD_CENTER_X - _lblHowToServe.textWidth * 0.5;
			_lblHowToServe.y = 300;
			
			_lblHowToPause = new Label("PRESS P OR ESC TO PAUSE/RESUME",
										40,
										Config.WHITE,
										"Ostrich",
										true);
			addChild(_lblHowToPause);
			_lblHowToPause.x = Config.WORLD_CENTER_X - _lblHowToPause.textWidth * 0.5;
			_lblHowToPause.y = 350;
			
			_lblContinue = new Label("PRESS ENTER TO START THE GAME",
										40,
										Config.WHITE,
										"Ostrich",
										true);
			addChild(_lblContinue);
			_lblContinue.x = Config.WORLD_CENTER_X - _lblContinue.textWidth * 0.5;
			_lblContinue.y = Config.WORLD_HEIGHT - _lblContinue.textHeight * 2;
			
		}
		
		public function destroy():void {
			removeChild(_lblInstruction);
			_lblInstruction = null;
			removeChild(_lblHowToWin);
			_lblHowToWin = null;
			removeChild(_lblHowToServe);
			_lblHowToServe = null;
			removeChild(_lblHowToPause);
			_lblHowToPause = null;
			removeChild(_lblLeftPaddleIns);
			_lblLeftPaddleIns = null;
			removeChild(_lblRightPaddleIns);
			_lblRightPaddleIns = null;
			removeChild(_lblContinue);
			_lblContinue = null;
		}
		
		public function update():void {
			if (Key.isKeyPressed(Key.START)){
				_document.changeState(Config.GAME_STATE_PLAY);
			}
		}
		
	}

}