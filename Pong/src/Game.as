package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.TextField; 
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Game extends Sprite implements IState{
		private var _document:Document;
		private var _paddles:Vector.<Paddle>;
		private var _ball:Ball;	
		private var _leftScore:Number = 0;
		private var _rightScore:Number = 0;
		
		private var _soundBounce:SimpleSound = new SimpleSound("./assets/bounce.mp3");
		private var _soundGoal:SimpleSound = new SimpleSound("./assets/goal.mp3", null, false, Config.SOUND_VERY_LOW);
		
		private var _isPaused:Boolean = false;
		private var _rdyNewPauseClick:Boolean = true;
		private var _hasServed:Boolean = false;
		private var _lblScore:Label = new Label("0   :   0", 92, Config.WHITE, "Ostrich", true);
		private var _lblPause:Label = new Label("THE GAME IS NOW PAUSED", 70, Config.WHITE, "Ostrich", true);
		
		public function Game(document:Document){
			super();
			_document = document;
			_paddles = new Vector.<Paddle>
			addPaddle(new Paddle(true));
			addPaddle(new Paddle(false));
			
			_ball = new Ball();
			_ball.addEventListener(Ball.EXIT_LEFT, onExit, false, 0, true);
			_ball.addEventListener(Ball.EXIT_RIGHT, onExit, false, 0, true);
			_ball.addEventListener(Ball.BOUNCE, onBounce, false, 0, true);
			addChild(_ball);
			
			addChild(_lblScore);
			_lblScore.x = (Config.WORLD_CENTER_X - _lblScore.textWidth * 0.5);
			_lblScore.y = 20;
			
			_lblPause.x = (Config.WORLD_CENTER_X - _lblPause.textWidth * 0.5);
			_lblPause.y = (Config.WORLD_CENTER_Y - _lblPause.textHeight * 0.5);
			//Adding as child when game paused.
		}
		
		private function addPaddle(p:Paddle):void{
			_paddles.push(p);
			addChild(p);
		}
		
		private function resetEntities():void{
			_hasServed = false;
			for (var i:Number = 0; i < _paddles.length; i++){
				_paddles[i].reset();
			}
			_ball.reset();
		}
		
		private function onBounce(e:Event):void{
			var minRange:Number = -1, maxRange:Number = 1;
			var pan:Number =  (maxRange - minRange) / (Config.WORLD_WIDTH - 0) * (_ball.centerX - Config.WORLD_WIDTH) + maxRange;
			_soundBounce.setPan(pan);
			_soundBounce.start();
		}
		
		private function onExit(e:Event):void{
			_soundGoal.start();
			if (e.type == Ball.EXIT_LEFT){
				_rightScore++;
			}else if (e.type == Ball.EXIT_RIGHT){
				_leftScore++;
			}
			
			if (_leftScore >= Config.GAME_WINNING_POINTS || _rightScore >= Config.GAME_WINNING_POINTS){
				_document.changeState(Config.GAME_STATE_GAMEOVER);
			}else{
				resetEntities();
				_lblScore.text = _leftScore+"   :   " + _rightScore;
			}
		}
		
		public function update():void{
			if (Key.isKeyPressed(Key.PAUSE_ESC) || Key.isKeyPressed(Key.PAUSE_P)){
				if (_rdyNewPauseClick){
					if (_isPaused){
						removeChild(_lblPause);
						_document.onGameResume();
					}else{
						addChild(_lblPause);
						_document.onGamePause();
					}
					_isPaused = !_isPaused;
				}
				_rdyNewPauseClick = false;
			}else{
				_rdyNewPauseClick = true;
			}
			
			if (!_isPaused){
				if (_hasServed){
				_ball.update();
				for (var i:Number = 0; i < _paddles.length; i++){
					_paddles[i].update();
					if (isColliding(_ball, _paddles[i])){
					_ball.onCollision(_paddles[i]);
					}
				}
				}else if (Key.isKeyPressed(Key.SERVE)){
					_ball.serve();
					_hasServed = true;
				}
			}
		}
		
		//AABB intersection test
		public function isColliding(e1:Entity, e2:Entity):Boolean {
			return !(e1.right < e2.left
					|| e2.right < e1.left
					|| e1.bottom < e2.top
					|| e2.bottom < e1.top);
		}
 
		
		public function destroy():void{
			_ball.removeEventListener(Ball.EXIT_LEFT, onExit);
			_ball.removeEventListener(Ball.EXIT_RIGHT, onExit);
			_ball.removeEventListener(Ball.BOUNCE, onBounce);
			
			for (var i:Number = 0; i < _paddles.length; i++){
				removeChild(_paddles[i]);
				_paddles[i].destroy();
			}
			_paddles = new Vector.<Paddle>;
			removeChild(_ball);
			_ball.destroy();
			_ball = null;
			removeChild(_lblScore);
			_lblScore = null;	
			
			_soundBounce.destroy();
			_soundBounce = null;
			
			_soundGoal.destroy();
			_soundGoal = null;
			
			_document = null;
		}
		
	}

}