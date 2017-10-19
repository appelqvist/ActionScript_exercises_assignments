package gameObject{
	
	import core.Entity;
	import core.Config;
	import core.Util;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * Cloud
	 * No functionallity
	 * @author Andréas Appelqvist
	 */
	public class Cloud extends Sprite{
		
		private var _image:Image;
		private var xSpeed:Number;
		
		public function Cloud(x:Number, y:Number, direction:Number){
			var n:Number = Util.random(1, 3);
			_image = new Image(Assets.getTexture("cloud" + n));
			_image.x = x;
			_image.y = y;
			this.xSpeed = Util.random(-30, 30);
			_image.scale = 0.8;
			addChild(_image);
		}
		
		private function worldWrap():void{
			if (_image.x + _image.width < 0){
				_image.x = Config.worldWidth;
			}
			else if (_image.x > Config.worldWidth){
				_image.x = -_image.width;
			}	
		}
		
		public function update(deltaTime:Number):void{
			_image.x += xSpeed * deltaTime;
			worldWrap();
		}
		
		public function destroy():void{
			removeChild(_image);
			_image.dispose();
			_image = null;
		}
	}
}