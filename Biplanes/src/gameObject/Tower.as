package gameObject{
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import core.Entity;
	import core.Config;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import nape.space.Space;
	import starling.display.Image;
	
	/**
	 * Tower
	 * @author Andréas Appelqvist
	 */
	public class Tower extends Entity{
		
		private var _towerImage:Image;
		
		public function Tower(space:Space) {
			var b:Body = new Body(BodyType.DYNAMIC);
			var shape:Shape = new Polygon(Polygon.box(Config.towerWidth, Config.towerHeight));
			b.shapes.add(shape);
			b.space = space;
			b.gravMass = 150;
			super(0, 0, b);
			_towerImage = new Image(Assets.getTexture("tower"));
			_towerImage.x = Config.worldWidth*0.5;
			_towerImage.y = Config.worldHeight-100;
			_towerImage.width = Config.towerWidth;
			_towerImage.height = Config.towerHeight;
			addChild(_towerImage);
			reset();
		}
		
		public function reset():void{
			this.x = Config.towerX;
			this.y = Config.towerY;
			this.rotation = 0;
		}
		
		public override function update(deltaTime:Number):void{
			super.update(deltaTime);
			followBounds();
		}
		
		public function followBounds():void{
			var bounds:Rectangle = _towerImage.getBounds(this.parent);
			var center:Point = new Point(bounds.x + bounds.width * 0.5, bounds.y + bounds.height * 0.5);
			
			var xOff:Number = body.position.x - center.x;
			var yOff:Number = body.position.y - center.y;
			
			_towerImage.x += xOff;
			_towerImage.y += yOff;
			
			bounds = _towerImage.getBounds(this.parent);
			center = new Point(bounds.x + bounds.width * 0.5, bounds.y + bounds.height * 0.5);
			_towerImage.rotation = rotation;
			bounds = _towerImage.getBounds(this.parent);
			var newCenter:Point = new Point(bounds.x + bounds.width*0.5, bounds.y + bounds.height*0.5);
			_towerImage.x += center.x - newCenter.x;
			_towerImage.y += center.y - newCenter.y;
		}
		
		public override function destroy():void{
			removeChild(_towerImage);
			_towerImage.dispose();
			_towerImage = null;
			super.destroy();
		}
	}

}