package gameObjects 
{
	import core.Entity;
	import core.Config;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	
	public class Bullet extends Entity{	
		private var timeToLive:Number = Config.BULLET_TIME_TO_LIVE;
		
		public function Bullet(x:Number, y:Number, direction:Number){
			super(x,y);
			var radians:Number = direction * Config.TO_RAD
			_speedX = Math.cos(radians) * Config.BULLET_IMPULSE;
			_speedY = Math.sin(radians) * Config.BULLET_IMPULSE;
			draw();
		}
	
		public function draw():void{
			var w:Number = 2;
			graphics.clear();
			graphics.lineStyle(w, _color, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND);
			graphics.lineTo(0.5, 0);
			cacheAsBitmap = true;
		}
		
		override public function update():void{
			timeToLive--;
			if (timeToLive < 0){
				_alive = false;
			}
			super.update();
		}
	}

}