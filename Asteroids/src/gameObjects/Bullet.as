package gameObjects 
{
	import core.Entity;
	import core.Config;
	import core.Utils;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	
	public class Bullet extends Entity{	
		private var timeToLive:Number = Config.getNumber("time_to_live", ["entities", "bullet"]);
		
		public function Bullet(x:Number, y:Number, direction:Number){
			super(x,y);
			var radians:Number = Utils.convertToRad(direction);
			_speedX = Math.cos(radians) * Config.getNumber("impulse", ["entities", "bullet"]);
			_speedY = Math.sin(radians) * Config.getNumber("impulse", ["entities", "bullet"]);
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