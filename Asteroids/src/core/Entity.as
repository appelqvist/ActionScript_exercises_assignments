package core {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Entity extends Sprite {
		public function get centerY():Number{ return y + (height * 0.5); }
		public function set centerY(y:Number):void { this.y = y - (height * 0.5); }
		public function get centerX():Number{ return x + (width * 0, 5); }
		public function set centerX(x:Number):void {this.x = x - (width * 0.5); }
		
		public function get top():Number{ 		return y; }
		public function get bottom():Number{ 	return y + height; }
		public function get left():Number{ 		return x; }
		public function get right():Number{		return x + width; }
		
		public function set top(n:Number):void{		y = n; }
		public function set bottom(n:Number):void{	y = n - height; }
		public function set left(n:Number):void{	x = n; }
		public function set right(n:Number):void{	x = n - width; }
		
		protected var _speedX:Number;
		protected var _speedY:Number;
		protected var _speedRotation:Number;
		protected var _color:uint = Config.WHITE;
		protected var _friction:Number = 0.97;
		
		public function Entity(){
			super();
		}
		
		public function update():void{
			this.x += _speedX;
			this.y += _speedY;
			rotate(_speedRotation);
			boundariesCheck();
			worldWrap();
		}
		
		private function worldWrap():void{  //Not 100% when going left
			if (right < 0){
				left = Config.WORLD_WIDTH;
			}else if (left > Config.WORLD_WIDTH){
				right = 0;
			}
			
			if (bottom < 0){
				top = Config.WORLD_HEIGHT;
			}else if (top > Config.WORLD_HEIGHT){
				bottom = 0;
			}
		}
		
		public function destroy():void{ }
		
		public function boundariesCheck():void{ }
		
		public function onCollision(e:Entity):void{ }
		
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