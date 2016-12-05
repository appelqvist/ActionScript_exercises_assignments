package{
	import flash.display.Sprite;
	
	public class GameOver extends Sprite implements IState {
		
		private var _lblGameOver:Label;
		private var _lblRestart:Label;
		private var _document:Document;
		
		public function GameOver(document:Document){
			super();
			_document = document;
			_lblGameOver = new Label("GAME OVER", 92, Config.WHITE, "Ostrich", true);
			_lblGameOver.x = Config.WORLD_CENTER_X - _lblGameOver.textWidth * 0.5;
			_lblGameOver.y = 150;
			addChild(_lblGameOver);
			
			_lblRestart = new Label("CLICK ESC TO RESTART", 50, Config.WHITE, "Ostrich", true);
			_lblRestart.x = Config.WORLD_CENTER_X - _lblRestart.textWidth * 0.5;
			_lblRestart.y = 300;
			addChild(_lblRestart);
		}
		
		
		public function destroy():void{
			removeChild(_lblGameOver);
			_lblGameOver = null;
			removeChild(_lblRestart);
			_lblRestart = null;
		}
		
		public function update():void {
			if (Key.isKeyPressed(Key.ESC)){
				_document.changeState(Config.GAME_STATE_MENU);
			}
		}
		
	}

}