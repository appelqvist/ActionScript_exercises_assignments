package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.text.TextField; 
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Game extends Sprite implements IState{
		private var _document:Document;
		private var _paddles:Vector.<Paddle>;
		private var _ball:Ball;	
		private var _leftScore:Number = 0;
		private var _rightScore:Number = 0;
		
		private var _hasServed:Boolean = false;
		
		private var _lblScore:Label = new Label("0   :   0", 92, Config.WHITE, "Ostrich", true);
		
		public function Game(document:Document){
			super();
			_document = document;
			_paddles = new Vector.<Paddle>
			addPaddle(new Paddle(true));
			addPaddle(new Paddle(false));
			
			_ball = new Ball();
			_ball.addEventListener(Ball.EXIT_LEFT, onExit, false, 0, true);
			_ball.addEventListener(Ball.EXIT_RIGHT, onExit, false, 0, true);
			addChild(_ball);
			
			addChild(_lblScore);
			_lblScore.x = (Config.WORLD_CENTER_X - _lblScore.textWidth * 0.5);
			_lblScore.y = 20;
		}
		
		public function destroy():void{
			_ball.removeEventListener(Ball.EXIT_LEFT, onExit);
			_ball.removeEventListener(Ball.EXIT_RIGHT, onExit);
			
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
			
			_document = null;
		}
		
		private function addPaddle(p:Paddle):void{
			_paddles.push(p);
			addChild(p);
		}
		
		private function onExit(e:Event):void{
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
		
		private function resetEntities():void{
			_hasServed = false;
			for (var i:Number = 0; i < _paddles.length; i++){
				_paddles[i].reset();
			}
			_ball.reset();
		}
		
		public function update():void{
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
		
		
		//AABB intersection test
		public function isColliding(e1:Entity, e2:Entity):Boolean {
			return !(e1.right < e2.left
					|| e2.right < e1.left
					|| e1.bottom < e2.top
					|| e2.bottom < e1.top);
		}
 
		
	}

}