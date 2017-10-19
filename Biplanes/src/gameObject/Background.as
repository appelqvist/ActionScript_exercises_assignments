package gameObject{
	
	import flash.display.Bitmap;
	import core.Config;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * Background
	 * @author Andréas Appelqvist
	 */
	public class Background extends Sprite{
		
		private var _background:Image;
		
		public function Background(bitmap:Bitmap){
			_background = new Image(Texture.fromBitmap(bitmap));
			_background.x = 0,
			_background.y = 0;
			_background.width = Config.worldWidth;
			_background.height = Config.worldHeight;
			addChild(_background);
		}
		
		public function destroy():void{
			removeChild(_background);
			_background.dispose();
			_background = null;
		}
	}
}