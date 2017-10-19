package gameObject.plane {
	
	import gameObject.plane.Biplane; 
	import core.Config;
	import nape.space.Space;
	import core.Key;
	import events.ShotEvent;
	import flash.utils.getTimer;
	
	/**
	 * Leftplane
	 * @author Andréas Appelqvist
	 */
	public class LeftPlane extends Biplane {
		private const _direction:Number = 1;
		
		public function LeftPlane(space:Space) {
			super(Config.leftBiplaneStartX, Config.leftBiplaneStartY, space);
			initPlane();
			reset();
		}
		
		public override function initPlane():void{
			super.initPlane();
			_biplaneBody.color = 0xDD0000;
		}
		
		public override function getDirection():Number{
			return _direction;
		}
		
		public override function inputFlying(deltaTime:Number):void{
			
			if (Key.isKeyPressed(Key.LEFT_TURN_LEFT)){
				body.rotation -= Config.biplaneRotationSpeed * deltaTime;
			}
			else if (Key.isKeyPressed(Key.LEFT_TURN_RIGHT)){
				body.rotation += Config.biplaneRotationSpeed * deltaTime;
			}
			
			if (Key.isKeyPressed(Key.LEFT_SHOOT) && _nextShotAllowed <= getTimer()){
				_nextShotAllowed = getTimer() + Config.rateOfFire;
				var dx:Number = ((Config.biplaneWidth * 0.5)+19) * Math.cos(rotation);
				var dy:Number = ((Config.biplaneHeight * 0.5)+19) * Math.sin(rotation);
				dispatchEvent(new ShotEvent(x + dx, y + dy, rotation));
			}
			
			super.inputFlying(deltaTime);
		}
		
		public override function inputTakeOff(deltaTime:Number):void{
			
			if (Key.isKeyPressed(Key.LEFT_LIFT) && body.velocity.x < Config.biplaneTakeOffTopSpeed){
				body.velocity.x += Config.biplaneTakeOffAcc * deltaTime;
			}
					
			if (body.velocity.x > Config.biplaneTakeOffSpeedThreshold){
				body.gravMass = 0.01;
				if (Key.isKeyPressed(Key.LEFT_TURN_LEFT)){
					body.rotation -= 0.017;
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
				rotation += _direction * Config.biplaneRotationSpeed * deltaTime;
			}else{
				rotation -= _direction * Config.biplaneRotationSpeed * deltaTime;
			}
			
			super.autoPilot(deltaTime);
		}
		
		public override function reset():void{
			body.position.setxy(Config.leftBiplaneStartX, Config.leftBiplaneStartY);
			super.reset();
		}
		
		public override function destroy():void{
			super.destroy();
		}
	}
}