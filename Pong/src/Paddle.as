package {
	
	public class Paddle extends Entity{
		private var _isLeft:Boolean; 
		private var _color:uint = Config.WHITE;
		
		public function Paddle(isLeft:Boolean) {
			super();
			_isLeft = isLeft;
			draw();
			reset();
		}
	
		private function checkInput():void{
			if (_isLeft){
				
				if (Key.isKeyPressed(Key.LEFT_PADDLE_UP)){
					_speedY -= 2;
				}
				if (Key.isKeyPressed(Key.LEFT_PADDLE_DOWN)){
					_speedY += 2;
				}
			}else{
				var dy:Number = stage.mouseY - this.centerY;
				_speedY = (dy * 0.1); 
			}
		}
		
		override public function update():void{
			checkInput();
			_speedX *= Config.PADDLE_FRICTION;
			_speedY *= Config.PADDLE_FRICTION;
			super.update();
		}
		
		override public function boundariesCheck():void{
			if (top < 0){
				top = 0;
				_speedY = -1*(_speedY*0.15); //15% of the speed you go in the wall with, you bounces back the other direction
			}else if (bottom > Config.WORLD_HEIGHT){
				bottom = Config.WORLD_HEIGHT;
				_speedY = -1*(_speedY*0.1);
			}
		}
		
		override public function reset():void{
			super.reset(); //resets the speed.
			
			//puts the paddle in the reset position
			if (_isLeft){
				centerX = Config.PADDLE_WALL_OFFSET;
			}else{
				centerX = Config.WORLD_WIDTH - Config.PADDLE_WALL_OFFSET;
			}
			
			centerY = Config.WORLD_CENTER_Y
		}
		
		private function draw():void{
			graphics.clear();
			graphics.beginFill(_color, 1);
			graphics.drawRect(0, 0, Config.PADDLE_WIDTH, Config.PADDLE_HEIGHT);
			graphics.endFill();
		}
	}

}