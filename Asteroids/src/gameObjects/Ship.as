package gameObjects 
{
	import core.Entity;
	import core.Key;
	import core.Config;
	
	public class Ship extends Entity{
		private var _thrust:Number = 2;
		
		public function Ship() { }
		
		public function checkInput():void{
			if (Key.isKeyPressed(Key.RIGHT)){
				_speedRotation = 5;
			}else if (Key.isKeyPressed(Key.LEFT)){
				_speedRotation = -5;
			}else{
				if (_speedRotation > 0.5){  
					_speedRotation = 0.5;
				}else if (_speedRotation < -0.5){
					_speedRotation = -0.5;
				}
			}
			
			if (Key.isKeyPressed(Key.ACCELERATE)){
				_thrust = 1;
			}else{
				_thrust = 0;
			}
		}
		
		override public function update():void{
			checkInput();
			var radians:Number = rotation * Config.TO_RAD
			var ax:Number = Math.cos(radians) * _thrust;
			var ay:Number = Math.sin(radians) * _thrust;
			
			if (_thrust){
				_speedX += ax;
				_speedY += ay;
			}
			
			//Adding friction to get easier control
			_speedX *= Config.SHIP_FRICTION;
			_speedY *= Config.SHIP_FRICTION;
			_speedRotation *= Config.SHIP_FRICTION;
			
			draw();
			super.update();
		}
		
		public function draw():void{
			var engineHole:Number = 5;
			var w:Number = Config.SHIP_WIDTH;
			var h:Number = Config.SHIP_HEIGHT;
			graphics.clear();
			graphics.lineStyle(1.5, _color);
			graphics.moveTo(0, 0);
			graphics.lineTo(w, h * 0.5);
			graphics.lineTo(0, h);
			graphics.lineTo(engineHole, h * 0.5);
			graphics.lineTo(0, 0);
		}
		
		
	}

}