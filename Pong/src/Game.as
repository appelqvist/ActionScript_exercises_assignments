package 
{
	import flash.display.Sprite;

	public class Game extends Sprite {
		
		private var _paddles:Vector.<Paddle>;
		private var _ball:Ball;
		
		private var leftScore:Number;
		private var rightScore:Number;
		
		public function Game(){
			super();
			_paddles = new Vector.<Paddle>
			addPaddle(new Paddle(true));
			addPaddle(new Paddle(false));
			_ball = new Ball();
			addChild(_ball);
		}
		
		private function addPaddle(p:Paddle):void{
			_paddles.push(p);
			addChild(p);
		}
		
		public function update():void{
			
			if (Key.isKeyPressed(Key.SERVE)){ // && _ball.isReadyForServe()
				_ball.serve();
			}
			
			_ball.update();
			_ball.boundariesCheck();
			var p:Paddle;
			for (var i:Number = 0; i < _paddles.length; i++){
				p = _paddles[i]
				p.update();
				p.boundariesCheck();
				if (isColliding(_ball, p)){
					_ball.onCollision(p);
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
 
		
	}

}