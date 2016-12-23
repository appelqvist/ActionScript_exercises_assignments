package gameObjects 
{
	import core.Entity;
	import core.Config;
	import core.Utils;
	import events.AsteroidBreakEvent;
	import flash.display.Sprite;
	
	public class Asteroid extends Entity{
		public static const ASTEROID_BREAK:String = "asteroidBreak";
		public static const TYPE_LARGE:String = "asteroid_large";
		public static const TYPE_MED:String = "asteroid_medium";
		public static const TYPE_SMALL:String = "asteroid_small";
		
		private var _radius:Number;
		private var _type:String;
		
		public function Asteroid(x:Number = 0, y:Number = 0, type:String = TYPE_LARGE){
			super(x, y);
			reset();
			_type = type;
			_radius = Config.getNumber("radius", ["entities", "asteroids", _type]);
			
			var maxSpeed:Number = Config.getNumber("starting_speed", ["entities", "asteroids", _type]);
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
			graphics.lineStyle(Config.getNumber("line_size", ["entities"]), _color);
			graphics.drawCircle(_radius, _radius, _radius);
			cacheAsBitmap = true;
		}
	}

}