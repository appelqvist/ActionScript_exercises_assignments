package gameObject.plane {
	import gameObject.plane.Biplane;
	import core.Config;
	import nape.space.Space;
	import core.Key;
	import events.ShotEvent;
	import flash.utils.getTimer;
	
	/**
	 * Right plane
	 * @author Andréas Appelqvist
	 */
	public class RightPlane extends Biplane{
		private const _direction:Number = -1;
		
		public function RightPlane(space:Space) {
			super(Config.rightBiplaneStartX, Config.rightBiplaneStartY, space);
			initPlane();
			reset();
		}
		
		override public function initPlane():void {
			super.initPlane();
			_biplaneBody.color = 0x00DD00;
			_biplaneBody.scaleX *= -1;
			_biplaneDetail.scaleX *= -1;
		}
		
		public override function getDirection():Number{
			return _direction;
		}
		
		public override function inputFlying(deltaTime:Number):void{
			
			if (Key.isKeyPressed(Key.RIGHT_TURN_LEFT)){
				body.rotation -= Config.biplaneRotationSpeed * deltaTime;
			}
			else if (Key.isKeyPressed(Key.RIGHT_TURN_RIGHT)){
				body.rotation += Config.biplaneRotationSpeed * deltaTime;
			}
			
			if (Key.isKeyPressed(Key.RIGHT_SHOOT) && _nextShotAllowed <= getTimer()){
				_nextShotAllowed = getTimer() + Config.rateOfFire;
				var dx:Number = ((Config.biplaneWidth * 0.5) + 19) * Math.cos(rotation+Math.PI);		
				var dy:Number = ((Config.biplaneHeight * 0.5) + 19) * Math.sin(rotation + Math.PI);
				dispatchEvent(new ShotEvent(x + dx, y + dy, rotation + Math.PI));
			}
			
			super.inputFlying(deltaTime);
		}
		
		public override function inputTakeOff(deltaTime:Number):void{
			if (Key.isKeyPressed(Key.RIGHT_LIFT) && body.velocity.x > -Config.biplaneTakeOffTopSpeed){
				body.velocity.x -= Config.biplaneTakeOffAcc * deltaTime;
			}
					
			if (body.velocity.x < -Config.biplaneTakeOffSpeedThreshold){
				body.gravMass = 0.01;
				if (Key.isKeyPressed(Key.RIGHT_TURN_RIGHT)){
					body.rotation += 0.017;
					body.position.y -= 0.7;
				}
			}else{
				body.gravMass = 0.3;
			}
			
			super.inputTakeOff(deltaTime);
			
		}
		
		public override function autoPilot(deltaTime:Number):void{
			var rotDir:Number = Math.cos(rotation) * _direction;
			
			if (rotDir > 0){
				rotation -= _direction * Config.biplaneRotationSpeed * deltaTime;
			}else{
				rotation += _direction * Config.biplaneRotationSpeed * deltaTime;
			}
			
			super.autoPilot(deltaTime);
		}
		
		public override function reset():void{
			body.position.setxy(Config.rightBiplaneStartX, Config.rightBiplaneStartY);
			super.reset();
		}
		
		public override function destroy():void{
			super.destroy();
		}
		
	}

}