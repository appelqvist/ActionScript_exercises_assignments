package 
{
	import flash.geom.Point;
	public class Ball extends Entity {
		
		private var _readyForServe:Boolean = false;;
		
		public function Ball() {
			super();
			draw();
			reset();
			_readyForServe = true;
		}
		
		public function serve():void{
			if(_readyForServe){
				var speedX:Number, speedY:Number;
				do{
					speedX = Utils.random( -1 * Config.BALL_MAX_SPEED, Config.BALL_MAX_SPEED );
				}while (speedX < Config.BALL_MIN_SPEED && speedX > Config.BALL_MIN_SPEED * -1);
				
				do{
					speedY = Utils.random( -1 * Config.BALL_MAX_SPEED, Config.BALL_MAX_SPEED );
				}while (speedY < Config.BALL_MIN_SPEED && speedY > Config.BALL_MIN_SPEED * -1);
				
				_speedX = speedX;
				_speedY = speedY;
				_readyForServe = false;
			}
		}
		
		override public function onCollision(e:Entity):void{
			var overlap:Point = new Point(0, 0);
			if (Utils.getOverlap(this, e, overlap)){
				x += overlap.x;
				y += overlap.y;
				_speedX *= -1;
				_speedY *= -1;
				
				//Maybe fix the angles.
			}
		}
		
		override public function boundariesCheck():void{
			if (top < 0){
				_speedY *= -1;
			}else if (bottom > Config.WORLD_HEIGHT){
				_speedY *= -1;
			}
			
			if (left < 0){
				_speedX *= -1;
			}else if (right > Config.WORLD_WIDTH){
				_speedX *= -1;
			}
		}
		
		
		override public function reset():void{
			super.reset();
			centerX = Config.WORLD_CENTER_X;
			centerY = Config.WORLD_CENTER_Y;
			_readyForServe = true;
		}
		
		public function draw():void{
			graphics.clear();
			graphics.beginFill(Config.WHITE, 1);
			graphics.drawRect(0, 0, Config.BALL_SIZE, Config.BALL_SIZE);
			graphics.endFill();
		}
		
		
		
	}

}