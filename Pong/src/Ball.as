package 
{
	import flash.events.Event;
	import flash.geom.Point;
	public class Ball extends Entity {
		public static const EXIT_LEFT:String = "exitLeft";
		public static const EXIT_RIGHT:String = "exitRight";
		public static const BOUNCE:String = "onBounce";
		
		public function Ball() {
			super();
			draw();
			reset();
		}
		
		public function serve():void{
			var speedX:Number, speedY:Number;
			do{
				speedX = Utils.random( -1 * Config.BALL_MAX_SPEED, Config.BALL_MAX_SPEED );
			}while (speedX < Config.BALL_MIN_SPEED && speedX > Config.BALL_MIN_SPEED * -1);
			
			do{
				speedY = Utils.random( -1 * Config.BALL_MAX_SPEED*0.5, Config.BALL_MAX_SPEED*0.5 );
			}while (speedY < Config.BALL_MIN_SPEED && speedY > Config.BALL_MIN_SPEED * -1);
			
			_speedX = speedX;
			_speedY = speedY;
		}
		
		override public function onCollision(e:Entity):void{
			var overlap:Point = new Point(0, 0);
			if (Utils.getOverlap(this, e, overlap)){
				x += overlap.x;
				y += overlap.y;
				_speedX *= -1;
				_speedY *= -1;
				dispatchEvent(new Event(BOUNCE));
			}
		}
		
		override public function boundariesCheck():void{
			if (top < 0){
				top = 0;
				_speedY *= -1;
				dispatchEvent(new Event(BOUNCE));
			}else if (bottom > Config.WORLD_HEIGHT){
				bottom = Config.WORLD_HEIGHT;
				_speedY *= -1;
				dispatchEvent(new Event(BOUNCE));
			}
			
			if (left < 0){
				left = 0;
				_speedX = 0;
				dispatchEvent(new Event(EXIT_LEFT));
			}else if (right > Config.WORLD_WIDTH){
				right = Config.WORLD_WIDTH;
				_speedX = 0;
				dispatchEvent(new Event(EXIT_RIGHT));
			}
		}
		
		override public function reset():void{
			super.reset();
			centerX = Config.WORLD_CENTER_X;
			centerY = Config.WORLD_CENTER_Y;
		}
		
		public function draw():void{
			graphics.clear();
			graphics.beginFill(Config.WHITE, 1);
			graphics.drawRect(0, 0, Config.BALL_SIZE, Config.BALL_SIZE);
			graphics.endFill();
		}
		
		
		
	}

}