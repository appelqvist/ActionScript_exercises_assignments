package ui {
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.display.Sprite;
	import core.Config;
	
	/**
	 * Stats
	 * @author Andréas Appelqvist
	 */
	public class Stats extends Sprite {
	
		private var _right:TextField;
		private var _left:TextField;
		
		public function Stats() {
			_left = new TextField(200, 100, "RED : "+Config.totalLives, new TextFormat(Config.defaultFont, 50, 0xDD0000));
			_left.x = 0;
			_left.y = 0;
			addChild(_left);
			
			_right = new TextField(200, 100, "GREEN : "+Config.totalLives, new TextFormat(Config.defaultFont, 50, 0x00DD00));
			_right.x = Config.worldWidth-_right.width;
			_right.y = 0;
			addChild(_right);
		}
		
		public function updateStats(leftLives:Number, rightLives:Number):void{
			_right.text = "GREEN : " + rightLives;
			_left.text = "RED : " + leftLives;
		}
		
		public function destroy():void{
			removeChild(_left);
			_left.dispose();
			_left = null;
			removeChild(_right);
			_right.dispose();
			_right = null;
			super.dispose();
		}
		
	}
}