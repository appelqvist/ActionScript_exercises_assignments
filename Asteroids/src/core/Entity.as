package core {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Entity extends Sprite {
		
		public function get centerY():Number{ return _bounds.y + (_bounds.height * 0.5); }
		public function get centerX():Number{ return _bounds.x + (_bounds.width * 0.5); }
			
		public function get halfHeight():Number { return _bounds.height * 0.5; }
		public function get halfWidth():Number {  return _bounds.width * 0.5; }
		
		public function get top():Number{ 		return _bounds.top; }
		public function get bottom():Number{ 	return _bounds.bottom; }
		public function get left():Number{ 		return _bounds.left; }
		public function get right():Number{		return _bounds.right; }
		public function get radius():Number{	return (_bounds.width + _bounds.height) * 0.25; }
		
		public function set top(y:Number):void{		this.y = y + _offset.y; 				   updateBounds(); }
		public function set bottom(y:Number):void{	this.y = (y - _bounds.height) + _offset.y; updateBounds(); }
		public function set left(x:Number):void{	this.x = x + _offset.x;					   updateBounds(); }
		public function set right(x:Number):void{	this.x = (x - _bounds.width) + _offset.x;  updateBounds(); }
		
		public function set centerX(x:Number):void { this.x = x - (_bounds.width * 0.5) + _offset.x;  updateBounds(); }
		public function set centerY(y:Number):void { this.y = y - (_bounds.height * 0.5) + _offset.y; updateBounds(); }
		
		protected var _bounds:Rectangle = new Rectangle();
		protected var _offset:Point = new Point();
		
		protected var _speedX:Number = 0;
		protected var _speedY:Number = 0;
		protected var _speedRotation:Number = 0;
		protected var _color:uint = Config.getColor("color", ["entities"]);
		protected var _alive:Boolean = true;
		
		public function Entity(x:Number, y:Number){
			super();
			this.x = x;
			this.y = y;
		}
		
		public function update():void{
			this.x += _speedX;
			this.y += _speedY;
			rotate(_speedRotation);
			worldWrap();
			updateBounds();
		}
		
		public function isColliding(e:Entity):Boolean{
			return (Utils.distanceSq(this, e) < this.radius * this.radius + e.radius * e.radius);
		}
		
		public function onCollision(e:Entity):void{
			kill();
		}	
		
		protected function worldWrap():void{
			if (right < 0){
				left = Config.getNumber("width", ["world"]);
			}else if (left > Config.getNumber("width", ["world"])){
				right = 0;
			}
			
			if (bottom < 0){
				top = Config.getNumber("height", ["world"]);
			}else if (top > Config.getNumber("height", ["world"])){
				bottom = 0;
			}
		}
		
		public function isAlive():Boolean{
			return _alive;
		}
		
		public function kill():void{
			_alive = false;
		}
		
		public function destroy():void{ }
		
		private function updateBounds():void{
			_bounds = this.getBounds(parent);
			_offset.x = this.x - _bounds.left;
			_offset.y = this.y - _bounds.top;
		}
		
		private function rotate(degrees:Number):void{
			var bounds:Rectangle = this.getBounds(this.parent);
			var center:Point = new Point(bounds.x + bounds.width*0.5, bounds.y + bounds.height*0.5);
			this.rotation += degrees;
			bounds = this.getBounds(this.parent);
			var newCenter:Point = new Point(bounds.x + bounds.width*0.5, bounds.y + bounds.height*0.5);
			this.x += center.x - newCenter.x;
			this.y += center.y - newCenter.y;
		}
		
		public function reset():void{
			_speedX = 0;
			_speedY = 0;
			_speedRotation = 0;
		}
		
	}

}