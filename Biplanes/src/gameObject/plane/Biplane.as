package gameObject.plane{
	import flash.automation.AutomationAction;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import core.Entity;
	import core.Config;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import nape.space.Space;
	import starling.animation.Tween;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import flash.utils.getTimer;
	import starling.animation.Transitions;
	import starling.animation.Juggler;
	
	/**
	 * Biplane - Plane-class
	 * @author Andréas Appelqvist
	 */
	public class Biplane extends Entity {
		private var _lives:Number = Config.totalLives;
		
		protected const FLYING:Number = 0;
		protected const TAKING_OFF:Number = 1;
		protected const AUTO_PILOT:Number = 2;
		protected const DEAD:Number = 3;
		
		protected var _currentState:Number = 1;
		protected var _hasTakenOff:Boolean = false;
		protected var _nextShotAllowed:Number = 0;
		protected var _respawn:Number;
		
		protected var _engineRunning:Boolean = false;
		
		protected var _biplaneDetail:MovieClip;
		protected var _biplaneBody:MovieClip;
		
		public function Biplane(x:Number, y:Number, space:Space){
			var body:Body = new Body(BodyType.DYNAMIC);
			var shape:Shape = new Polygon(Polygon.box(Config.biplaneWidth, Config.biplaneHeight));
			body.shapes.add(shape);
			body.space = space;
			super(x, y, body);
		}
		
		public function initPlane():void{
			_biplaneBody = new MovieClip(Assets.getBiplaneAtlas().getTextures("body"), 10);
			_biplaneBody.x = Math.ceil( -_biplaneBody.width / 2);
			_biplaneBody.y = Math.ceil( -_biplaneBody.height / 2);
			_biplaneBody.width = Config.biplaneWidth;
			_biplaneBody.height = Config.biplaneHeight;
			
			Starling.juggler.add(_biplaneBody);
			addChild(_biplaneBody);
		
			_biplaneDetail = new MovieClip(Assets.getBiplaneAtlas().getTextures("detail"), 10);
			_biplaneDetail.x = Math.ceil( -_biplaneDetail.width / 2);
			_biplaneDetail.y = Math.ceil( -_biplaneDetail.height / 2);
			_biplaneDetail.width = Config.biplaneWidth;
			_biplaneDetail.height = Config.biplaneHeight;
			
			Starling.juggler.add(_biplaneDetail);
			addChild(_biplaneDetail);
		}
		
		public function isEngineRunning():Boolean{
			return this._engineRunning;
		}
		
		public function pauseTexture():void{
			_biplaneBody.pause();
			_biplaneDetail.pause();
		}
		
		public function resumeTexture():void{
			_biplaneBody.play();
			_biplaneDetail.play();
		}
		
		public function getLives():Number{
			return _lives;
		}
		
		/**
		 * @return alive after decrease
		 */
		public function decreaseLives():Boolean{
			_lives--;
			if (_lives < 1){
				return false;
			}else{
				return true;
			}
		}
		
		/**
		 * To match the Movieclip to the rotatating body
		 */
		public function adaptTextureToBody():void{
			
			var bounds:Rectangle = _biplaneDetail.getBounds(this.parent);
			var center:Point = new Point(bounds.x + bounds.width * 0.5, bounds.y + bounds.height * 0.5);
			
			var xOff:Number = body.position.x - center.x;
			var yOff:Number = body.position.y - center.y;
			
			_biplaneDetail.x += xOff;
			_biplaneDetail.y += yOff;
			
			bounds = _biplaneDetail.getBounds(this.parent);
			center = new Point(bounds.x + bounds.width * 0.5, bounds.y + bounds.height * 0.5);
			_biplaneDetail.rotation = rotation;
			bounds = _biplaneDetail.getBounds(this.parent);
			var newCenter:Point = new Point(bounds.x + bounds.width*0.5, bounds.y + bounds.height*0.5);
			_biplaneDetail.x += center.x - newCenter.x;
			_biplaneDetail.y += center.y - newCenter.y;
	
			bounds = _biplaneBody.getBounds(this.parent);
			center = new Point(bounds.x + bounds.width * 0.5, bounds.y + bounds.height * 0.5);
			
			xOff = body.position.x - center.x;
			yOff = body.position.y - center.y;
			
			_biplaneBody.x += xOff;
			_biplaneBody.y += yOff;
			
			bounds = _biplaneBody.getBounds(this.parent);
			center = new Point(bounds.x + bounds.width * 0.5, bounds.y + bounds.height * 0.5);
			_biplaneBody.rotation = rotation;
			bounds = _biplaneBody.getBounds(this.parent);
			newCenter = new Point(bounds.x + bounds.width*0.5, bounds.y + bounds.height*0.5);
			_biplaneBody.x += center.x - newCenter.x;
			_biplaneBody.y += center.y - newCenter.y;
			
		}
		
		public function inputTakeOff(deltaTime:Number):void{
			if(Config.worldHeight - body.position.y > Config.biplaneTakeOffThresholdToFlying){
				_currentState = FLYING;
				_hasTakenOff = true;
			}			
		}
		
		public function inputFlying(deltaTime:Number):void{
			if (y < 10){
				_currentState = AUTO_PILOT;
			}
			configureVelocity(deltaTime);
		}
		
		public function configureVelocity(deltaTime:Number):void{
			var ax:Number = Math.cos(rotation) * Config.biplaneSpeed * getDirection();
			var ay:Number = Math.sin(rotation) * Config.biplaneSpeed * getDirection();
			body.velocity.setxy(ax, ay);
		}
		
		public function hasTakenOff():Boolean{
			return _hasTakenOff;
		} 
		
		public function getDirection():Number{ return -1; }
		
		/**
		 * Autopilot will bring the biplane back to the screen
		 * @param	deltaTime
		 */
		public function autoPilot(deltaTime:Number):void { 
			configureVelocity(deltaTime);
			if (y > 15){
				_currentState = FLYING;
			}
		}
		
		public function dead(cd:Number = Config.respawnCooldown):void{
			reset();
			_currentState = DEAD;
			_respawn = getTimer() + cd;
			_biplaneBody.alpha = 0;
			_biplaneDetail.alpha = 0;
			var repeats:int = 9
			
			var tweenBody:Tween = new Tween(_biplaneBody, (Config.respawnCooldown/1000)/repeats, Transitions.EASE_IN);
			tweenBody.fadeTo(1);
			tweenBody.reverse = true;
			tweenBody.repeatCount = repeats;
			
			var tweenDetails:Tween = new Tween(_biplaneDetail, (Config.respawnCooldown/1000)/repeats, Transitions.EASE_IN);
			tweenDetails.fadeTo(1);
			tweenDetails.reverse = true;
			tweenDetails.repeatCount = repeats;
			
			Starling.juggler.add(tweenBody);
			Starling.juggler.add(tweenDetails);
		}
		
		private function deadUpdate(deltaTime:Number):void{	
			if (_respawn <= getTimer()){
				_currentState = TAKING_OFF;
				body.gravMass = 0.3;
			}
		}
		
		override public function update(deltaTime:Number):void {
			
			if (body.velocity.x != 0 && body.velocity.y != 0){
				_engineRunning = true;
			}else{
				_engineRunning = false;
			}
			
			switch(_currentState){
				case TAKING_OFF:
					inputTakeOff(deltaTime);
					break;
				case AUTO_PILOT:
					autoPilot(deltaTime);
					break;
				case DEAD:
					deadUpdate(deltaTime);
					break;
				default:		//Flying
					inputFlying(deltaTime);
					break;
			}
			
			adaptTextureToBody();
			super.update(deltaTime);
		}
		
		public function reset():void{
			rotation = 0;
			body.velocity.setxy(0, 0);
			body.gravMass = 300;
			_hasTakenOff = false;
			_currentState = TAKING_OFF;
		}
		
		public override function destroy():void{
			removeChild(_biplaneBody);
			_biplaneBody.dispose();
			_biplaneBody = null;
			removeChild(_biplaneDetail);
			_biplaneDetail.dispose();
			_biplaneDetail = null;
			
			super.destroy();
		}
		
	}

}