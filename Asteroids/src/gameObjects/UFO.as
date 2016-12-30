package gameObjects 
{
	import core.Entity;
	import core.Utils;
	import core.Config;
	import events.ShotEvent;
	import events.UfoHitEvent;
	import flash.utils.getTimer;
	
	public class UFO extends Entity {

		private var _target:Entity;
		private var _nextShotIsAllowed:Number = 1000;
		
		public function UFO(x:Number, y:Number, target:Entity){
			super(x, y);
			reset();
			_target = target;
			spawn();
			draw();
		}
		
		public function spawn():void{
			_speedX = Config.getNumber("speed", ["entities", "ufo"]);
			_speedY = Config.getNumber("speed", ["entities", "ufo"]);
			this.x = 0;
			this.y = 0;
		}
		
		override public function onCollision(e:Entity):void{
			dispatchEvent(new UfoHitEvent(this.centerX, this.centerY));
			super.onCollision(e);
		}
		
		public function draw():void{
			graphics.clear();
			graphics.lineStyle(Config.getNumber("line_size", ["entities"]), _color);
			graphics.drawEllipse(20, 0, 40, 35);
			graphics.beginFill(_color);
			graphics.drawEllipse(0, 15, 80, 20);
			graphics.endFill();
			cacheAsBitmap = true;
		}
		
		override public function update():void {
			shootAgainstTarget();
			super.update();
		}
		
		public function shootAgainstTarget():void{
			if (_nextShotIsAllowed <= getTimer()){
				var dx:Number = _target.x - centerX;
				var dy:Number = _target.y - centerY;
				var deG:Number = Utils.convertToDegrees(Math.atan2(dy, dx))
				dispatchEvent(new ShotEvent(this.centerX, this.centerY, deG, true));
				_nextShotIsAllowed = getTimer() + Config.getNumber("rate_of_fire", ["entities", "ufo"]);
			}
		}
	}

}