package gameObjects 
{
	import core.Entity;
	import core.Config;
	import core.Utils;
	import events.AsteroidBreakEvent;
	import flash.display.Sprite;
	
	public class Asteroid extends Entity{
		public static const ASTEROID_BREAK:String = "asteroidBreak";
		public static const TYPE_BIG:Number = 1;
		public static const TYPE_MED:Number = 0.5;
		public static const TYPE_SMALL:Number = 0.3;
		
		private static const DEFAULT_SPEED:Number = 2;
		private static const DEFAULT_RADIUS:Number = 100;
		private var _radius:Number;
		private var _type:Number;
		
		public function Asteroid(x:Number = 0, y:Number = 0, type:Number = 0){
			super(x, y);
			reset();
			_radius = type * DEFAULT_RADIUS;
			_type = type;
			var maxSpeed:Number = DEFAULT_SPEED / type;
			_speedX = Utils.random( -maxSpeed, maxSpeed);
			_speedY = Utils.random( -maxSpeed, maxSpeed);
			draw();
		}
		
		override public function onCollision(e:Entity):void{
			super.onCollision(e);
			dispatchEvent(new AsteroidBreakEvent(centerX, centerY, _type));
		}	
		
		
		public function draw():void{
			graphics.clear();
			graphics.lineStyle(Config.LINE_SIZE, _color);
			graphics.drawCircle(_radius, _radius, _radius);
			cacheAsBitmap = true;
		}
	}

}