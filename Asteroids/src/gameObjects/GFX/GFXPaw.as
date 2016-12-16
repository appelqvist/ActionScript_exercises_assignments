package gameObjects.GFX {
	import core.Config;
	import core.Utils;
	
	public class GFXPaw extends GFX {
	
		private static const minSpeed:Number = -10;
		private static const maxSpeed:Number = 10;
		private static const fadeAwayConst:Number = 0.85;
		
		public function GFXPaw(x:Number, y:Number){
			super(x, y, "PAW!", 15, Config.LIGHT_ORANGE);
			_speedX = Utils.random(minSpeed, maxSpeed);
			_speedY = Utils.random(minSpeed, maxSpeed);
		}
		
		override public function update():void{
			super.update();
			alpha *= fadeAwayConst;
			if (alpha < 0.05){
				visible = false;
				alpha = 0;
				this.kill();
			}
		}
		
		override protected function worldWrap():void{ /* Dont do anything */ }
		
	}

}