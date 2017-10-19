package states {
	import core.Game;
	import core.State;
	import core.Config;
	import flash.events.Event;
	import gameObject.Background;
	import manager.SoundManager;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.core.Starling;
	import core.Key;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.animation.Juggler;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Main menu
	 * @author Andréas Appelqvist
	 */
	public class Menu extends State {
		
		private var _lblName:TextField;
		private var _lblStart:TextField;
		private var _background:Background;
		private var _bBody:MovieClip;
		private var _bDetails:MovieClip;
		
		private var _movingx:Number = 250;
		private var _movingy:Number = -10;
		private var _dir:Number = 1;
		
		public function Menu(fsm:Game, sm:SoundManager) {
			super(fsm,sm);
			
			_background = new Background(Assets.getBitmap(Config.backgroundSky));
			addChild(_background);
			
			_lblName = new TextField(500, 300, "BIPLANES!", new TextFormat(Config.defaultFont, 100, 0xFFFFFF));
			_lblName.x = Config.worldWidth * 0.5 - _lblName.width * 0.5;
			addChild(_lblName);
			
			_lblStart = new TextField(500, 300, "PRESS SPACE TO CONTIUE", new TextFormat(Config.defaultFont, 60, 0xFFFFFF));
			_lblStart.x = Config.worldWidth * 0.5 - _lblStart.width * 0.5;
			_lblStart.y = Config.worldHeight - 200;
			addChild(_lblStart);
			printBiplane();
		}
		 
		/**
		 * Menu-main update
		 * @param	deltaTime
		 */
		public override function update(deltaTime:Number):void{
			_bBody.x += _movingx * deltaTime * _dir;
			_bBody.y += _movingy * deltaTime;
			_bDetails.x += _movingx * deltaTime * _dir;
			_bDetails.y += _movingy * deltaTime;
		
			if (_bBody.x - _bBody.width > Config.worldWidth || _bBody.x + _bBody.width < 0){
				_bBody.scaleX *= -1;
				_bDetails.scaleX *=-1
				_dir *= -1;
			}
		
			if (Key.isKeyPressed(Key.SPACE)){
				_fsm.changeState(_fsm.GAME_STATE_INSTRUCTION);
			}
		}
		
		/**
		 * Printing the plane
		 */
		public function printBiplane():void{
			var width:Number = 205;
			var height:Number = 104;
			var rotation:Number = 0;
			
			_bBody = new MovieClip(Assets.getBiplaneAtlas().getTextures("body"), 10);
			_bBody.x = Math.ceil( -_bBody.width / 2);
			_bBody.y = Math.ceil( -_bBody.height / 2);
			_bBody.width = width;
			_bBody.height = height;
			_bBody.x = -_bBody.width;
			_bBody.y = Config.worldHeight - 320;
			_bBody.rotation = rotation;
			_bBody.color = 0xDDDD00;
			Starling.juggler.add(_bBody);
			addChild(_bBody);
			
			_bDetails = new MovieClip(Assets.getBiplaneAtlas().getTextures("detail"), 10);
			_bDetails.x = Math.ceil( -_bDetails.width / 2);
			_bDetails.y = Math.ceil( -_bDetails.height / 2);
			_bDetails.width = width;
			_bDetails.height = height;
			_bDetails.x = -_bBody.width;
			_bDetails.y = Config.worldHeight - 320;
			_bDetails.rotation = rotation;
			Starling.juggler.add(_bDetails);
			addChild(_bDetails);
			
			_soundManager.playEngine();
		}
		
		/**
		 * destroy
		 */
		public override function destroy():void{
			removeChild(_lblName);
			_lblName.dispose();
			_lblName = null;
			removeChild(_background);
			_background.dispose();
			_background = null;
			removeChild(_lblStart);
			_lblStart.dispose();
			_lblStart = null;
			
			if (_bBody != null && _bDetails != null){
				removeChild(_bDetails)
				_bDetails.dispose();
				_bDetails = null;
				removeChild(_bBody);
				_bBody.dispose();
				_bBody = null;
			}
			
			_soundManager.stopEngine();
			super.destroy();
		}
		
	}

}