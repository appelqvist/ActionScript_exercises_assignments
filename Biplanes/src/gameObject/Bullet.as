package gameObject{
	
	import core.Entity;
	import core.Config;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Shape;
	import nape.shape.Polygon;
	import nape.space.Space;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * Bullet
	 * @author Andréas Appelqvist
	 */
	public class Bullet extends Entity{
	
		private var _timeToLive:Number = Config.bulletTimeToLive;
		public var _isAlive:Boolean = true;
		private var _bulletImage:Image;
		
		public function Bullet(x:Number, y:Number, direction:Number, space:Space){
			var b:Body = new Body(BodyType.DYNAMIC);
			b.isBullet = true;
			var shape:Shape = new Circle(Config.bulletRadius);
			b.shapes.add(shape);
			b.space = space;
			b.gravMass = 0;
			super(x, y, b);
			var ax:Number = Math.cos(direction) * Config.bulletSpeed;
			var ay:Number = Math.sin(direction) * Config.bulletSpeed;
			body.velocity.setxy(ax, ay);
			
			_bulletImage = new Image(Assets.getTexture("bullet"));
			_bulletImage.scaleX = Config.bulletRadius*0.5;
			_bulletImage.scaleY = Config.bulletRadius*0.5;
			addChild(_bulletImage);
		}
		
		override public function update(deltaTime:Number):void{
			
			_bulletImage.x = body.position.x - Config.bulletRadius * 0.5 - 1;
			_bulletImage.y = body.position.y - Config.bulletRadius * 0.5 - 1;
	
			_timeToLive -= 1 * deltaTime;
			if (_timeToLive < 0){
				_isAlive = false;
			}
		}
		
		override public function destroy():void{
			removeChild(_bulletImage);
			_bulletImage.dispose();
			_bulletImage = null;
			super.destroy();
		}
		
	}

}