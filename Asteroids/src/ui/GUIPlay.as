package ui 
{
	import com.adobe.tvsdk.mediacore.TextFormat;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import core.Config;
	import core.Utils;
	
	public class GUIPlay extends Sprite{
		
		private var _offset:Number = 40;
		private var _lives:Vector.<Bitmap> = new Vector.<Bitmap>;
		private var _lblScore:Label;
		
		public function GUIPlay(x:Number = 0, y:Number = 0){
			this.x = x, this.y = y;
			_lblScore = new Label("0", 40, Config.WHITE, "Ostrich", true, 0, 0);
			_lblScore.x = Config.WORLD_WIDTH - _lblScore.textWidth - _offset;
			_lblScore.y = Config.WORLD_HEIGHT - _lblScore.textHeight - _offset;
			this.addChild(_lblScore);
			super();
			initLives();
		}
		
		public function removeLive():void{
			var bitmapIndex:Number = _lives.length - 1;
			trace(bitmapIndex);
			
			if (bitmapIndex >= 0){
				var h:Bitmap = _lives[bitmapIndex];
				_lives.removeAt(bitmapIndex);
				
				removeChild(h);
				h.visible = false;
				h = null;
			}else{
				//Maybe cast an exception
			}
		}
		
		public function updateScore(currentScore:Number):void{
			_lblScore.text = "" + currentScore;
			_lblScore.x = Config.WORLD_WIDTH - _lblScore.textWidth - _offset;
		}
		
		public function initLives():void{
			var lives:Number = Config.SHIP_TOT_LIVES;
			var heartPic:Bitmap = Assets.getImage("Heart");
			
			for (var i:Number = 0; i < lives; i++){
				var h:Bitmap = new Bitmap(heartPic.bitmapData);
				h.x = _offset/2+(i * _offset);
				h.y = 10;
				_lives.push(h);
				addChild(h);
			}
		}
		
		public function destroy():void{
			for (var i:Number = 0; i < _lives.length; i++){
				_lives[i].visible = false;
				removeChild(_lives[i]);
				_lives[i] = null;
			}
			_lives.length = 0;
			_lives = null;
			_lblScore.destroy();
			removeChild(_lblScore);
			_lblScore = null;
			
		}
	
	}

}