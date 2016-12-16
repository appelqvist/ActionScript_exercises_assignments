package gameObjects.GFX 
{
	import flash.geom.Point;
	public class GFXShake extends GFX {		
		private var _size:Number = 4;
		private var _startPoint:Point;
		private var _initilized:Boolean = false;
		
		public function GFXShake(){
			super(0, 0);
			removeChild(_label);
			_label = null;
		}
		
		override public function update():void{
			if (!_initilized){
				_startPoint = new Point(parent.x, parent.y);
				_initilized = true;
			}
			
			if (_size < 0){
				parent.x = _startPoint.x;
				parent.y = _startPoint.y;
				this.kill();
				return //stop here
			}
			
			var odd:int = _size % 2;
			var moveTo:Number = odd ? _size : -_size;
			parent.x = moveTo;
			parent.y = moveTo;
			_size--;
		}
		
		override public function destroy():void{
			_startPoint = null;
		}
	}

}