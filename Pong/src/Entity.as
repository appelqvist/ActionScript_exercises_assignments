package {
	import flash.display.Sprite;
	
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
		
		public function Entity(){
			super();
		}
		
		public function update():void{
			this.y += _speedY;
			this.x += _speedX;
			boundariesCheck();
		}
		
		public function destroy():void{ }
		
		public function boundariesCheck():void{ }
		
		public function onCollision(e:Entity):void{ }
		
		public function reset():void{
			_speedX = 0;
			_speedY = 0;
		}
		
	}

}