package ui {
	
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.display.Quad;
	import starling.display.Sprite;
	import core.Config;

	/**
	 * Pause overlay
	 * @author Andréas Appelqvist
	 */
	public class Pause extends Sprite {
		
		private var _background:Quad;
		private var _pause:TextField;
		private var _unpause:TextField;
		private var _restart:TextField;
		private var _quit:TextField;
		
		public function Pause() {
			super();
			_background = new Quad(Config.worldWidth, Config.worldHeight);
			_background.color = 0;
			_background.alpha = 0.8;
			addChild(_background);
			
			_pause = new TextField(400, 100, "PAUSED!", new TextFormat(Config.defaultFont, 92, 0xFFFFFF));
			_pause.x = Config.worldWidth * 0.5 - _pause.width*0.5;
			_pause.y = 100;
			addChild(_pause);
			
			_unpause = new TextField(400, 100, "P - UNPAUSE", new TextFormat(Config.defaultFont, 60, 0xFFFFFF));
			_unpause.x = Config.worldWidth * 0.5 - _unpause.width*0.5;
			_unpause.y = 220;
			addChild(_unpause);
			
			_restart = new TextField(400, 100, "R - RESTART", new TextFormat(Config.defaultFont, 60, 0xFFFFFF));
			_restart.x = Config.worldWidth * 0.5 - _restart.width*0.5;
			_restart.y = 290;
			addChild(_restart);
			
			_quit = new TextField(600, 100, "Q - QUIT AND GO TO MENU", new TextFormat(Config.defaultFont, 60, 0xFFFFFF));
			_quit.x = Config.worldWidth * 0.5 - _quit.width*0.5;
			_quit.y = 360;
			addChild(_quit);
			
		}	
		
		public function destroy():void{
			removeChild(_background);
			_background.dispose();
			_background = null;
			
			removeChild(_pause);
			_pause.dispose();
			_pause = null;
			
			removeChild(_unpause);
			_unpause.dispose();
			_unpause = null;
			
			removeChild(_restart);
			_restart.dispose();
			_restart = null;
			
			removeChild(_quit);
			_quit.dispose();
			_quit = null;
			
			super.dispose();
		}
	}

}