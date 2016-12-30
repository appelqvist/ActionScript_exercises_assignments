package gameObjects 
{
	import core.Entity;
	import core.Key;
	import core.Config;
	import events.PlayerHitEvent;
	import events.ShotEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import core.Utils;
	
	public class Ship extends Entity{
		private var _thrust:Number = 1;
		private var _nextShotIsAllowed:Number = 0;
		private var _rearLeft:Point = new Point(0, 0);
		private var _nose:Point = new Point(Config.getNumber("width", ["entities", "ship"]), Config.getNumber("height", ["entities", "ship"]) * 0.5);
		private var _rearRight:Point = new Point(0, Config.getNumber("height", ["entities", "ship"]));
		private var _engineHole:Point = new Point(Config.getNumber("width", ["entities", "ship"]) * 0.125, Config.getNumber("height", ["entities", "ship"]) * 0.5);
		
		private var _livesLeft:Number = Config.getNumber("tot_lives", ["entities", "ship"]);
		
		public function Ship(x:Number = 0, y:Number = 0) {
			super(x, y);
			reset();
		}
		
		public function checkInput():void{
			if (Key.isKeyPressed(Key.FIRE) && _nextShotIsAllowed <= getTimer()){
				var globalNose:Point = localToGlobal(_nose);
				dispatchEvent(new ShotEvent(globalNose.x, globalNose.y, rotation));
				_nextShotIsAllowed = getTimer() + Config.getNumber("rate_of_fire", ["entities", "ship"]);
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
			dispatchEvent(new PlayerHitEvent());
		}	
		
		
		override public function update():void{
			checkInput();
			
			if (_livesLeft < 1){
				_alive = false;
			}
			
			var radians:Number = Utils.convertToRad(rotation);
			var ax:Number = Math.cos(radians) * _thrust;
			var ay:Number = Math.sin(radians) * _thrust;
			
			if (_thrust){
				_speedX += ax;
				_speedY += ay;
			}
			
			//Adding friction to get easier control
			var friction:Number = Config.getNumber("friction", ["entities", "ship"])
			_speedX *= friction
			_speedY *= friction;
			_speedRotation *= friction;
			
			draw();
			if (_thrust){
				drawFlame();
			}
				
			super.update();
		}
		
		public function draw():void{
			graphics.clear();
			graphics.lineStyle(Config.getNumber("line_size", ["entities"]), _color);
			graphics.moveTo(_rearLeft.x, _rearLeft.y);
			graphics.lineTo(_nose.x, _nose.y);
			graphics.lineTo(_rearRight.x, _rearRight.y);
			graphics.lineTo(_engineHole.x, _engineHole.y);
			graphics.lineTo(_rearLeft.x, _rearLeft.y);
		}
		
		private function drawFlame():void{
			graphics.lineStyle(Config.getNumber("line_size", ["entities"]), _color);
			var heightOfFlame:Number = Config.getNumber("height", ["entities", "ship"]);
			var lengthOfFlame:Number = Utils.random(2, 15);
			graphics.moveTo(2, 1);
			graphics.lineTo( -lengthOfFlame, heightOfFlame * 0.5);
			graphics.lineTo(2, heightOfFlame - 1);
		}
		
		override public function destroy():void{
		}
	}
}