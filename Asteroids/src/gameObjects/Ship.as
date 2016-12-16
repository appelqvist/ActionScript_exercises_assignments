package gameObjects 
{
	import core.Entity;
	import core.Key;
	import core.Config;
	import events.PlayerShotEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import core.Utils;
	import flash.display.Sprite;
	import states.Play;
	
	public class Ship extends Entity{
		private var _thrust:Number = 1;
		private var _nextShotIsAllowed:Number = 0;
		private var _rearLeft:Point = new Point(0, 0);
		private var _nose:Point = new Point(Config.SHIP_WIDTH, Config.SHIP_HEIGHT * 0.5);
		private var _rearRight:Point = new Point(0, Config.SHIP_HEIGHT);
		private var _engineHole:Point = new Point(Config.SHIP_WIDTH * 0.125, Config.SHIP_HEIGHT * 0.5);
		
		private var _livesLeft:Number = Config.SHIP_TOT_LIVES;
		
		public function Ship(x:Number = 0, y:Number = 0) {
			super(x, y);
			reset();
		}
		
		public function checkInput():void{
			if (Key.isKeyPressed(Key.FIRE) && _nextShotIsAllowed <= getTimer()){
				var globalNose:Point = localToGlobal(_nose);
				dispatchEvent(new PlayerShotEvent(globalNose.x, globalNose.y, rotation));
				_nextShotIsAllowed = getTimer() + Config.SHIP_RATE_OF_FIRE;
			}
			
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
		
		override public function isColliding(e:Entity):Boolean{
			if (super.isColliding(e)){
				var globalNose:Point = localToGlobal(_nose);
				var globalRearL:Point = localToGlobal(_rearLeft);
				var globalRearR:Point = localToGlobal(_rearRight);
				
				if (Utils.lineCircleIntersection(globalNose, globalRearR, e)){
					return true;
				}else if (Utils.lineCircleIntersection(globalNose, globalRearL, e)){
					return true;
				}
			}
			return false;
		}
		
		override public function onCollision(e:Entity):void{
			//Notify play
		}	
		
		
		override public function update():void{
			checkInput();
			
			if (_livesLeft < 1){
				_alive = false;
			}
			
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
			if (_thrust){
				drawFlame();
			}
				
			super.update();
		}
		
		public function draw():void{
			graphics.clear();
			graphics.lineStyle(Config.LINE_SIZE, _color);
			graphics.moveTo(_rearLeft.x, _rearLeft.y);
			graphics.lineTo(_nose.x, _nose.y);
			graphics.lineTo(_rearRight.x, _rearRight.y);
			graphics.lineTo(_engineHole.x, _engineHole.y);
			graphics.lineTo(_rearLeft.x, _rearLeft.y);
		}
		
		private function drawFlame():void{
			graphics.lineStyle(Config.LINE_SIZE, _color);
			var heightOfFlame:Number = Config.SHIP_HEIGHT;
			var lengthOfFlame:Number = Utils.random(2, 15);
			graphics.moveTo(2, 1);
			graphics.lineTo( -lengthOfFlame, heightOfFlame * 0.5);
			graphics.lineTo(2, heightOfFlame - 1);
		}
		
		override public function destroy():void{
		}
	}
}