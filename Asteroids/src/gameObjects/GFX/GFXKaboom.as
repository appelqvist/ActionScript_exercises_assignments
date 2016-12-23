package gameObjects.GFX {
	import core.Config;
	import core.Utils;
	
	public class GFXKaboom extends GFX{
		
		private static const minSpeed:Number = -2;
		private static const maxSpeed:Number = 2;
		private static const rotationSpeed:Number = 2;
		private static const fadeAwayConst:Number = 0.98;
		
		public function GFXKaboom(x:Number, y:Number) {
			super(x, y, "KABOOM!", 22, Config.getColor("hex", ["color", "light_orange"]));
			_speedX = Utils.random(minSpeed, maxSpeed);
			_speedY = Utils.random(minSpeed, maxSpeed);
			_speedRotation = rotationSpeed;
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