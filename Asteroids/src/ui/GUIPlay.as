package ui 
{
	import com.adobe.tvsdk.mediacore.TextFormat;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import core.Config;
	import core.Utils;
	
	public class GUIPlay extends Sprite{
		
		private var _offset:Number = 40;
		private var _lives:Vector.<Bitmap> = new Vector.<Bitmap>;
		private var _lblScore:Label;
		private var _lblPause:Label;
		
		public function GUIPlay(x:Number = 0, y:Number = 0){
			this.x = x, this.y = y;
			_lblScore = new Label("0", 40, Config.getColor("hex", ["color", "light_orange"]), "Ostrich", true, 0, 0);
			_lblScore.x = Config.getNumber("width", ["world"]) - _lblScore.textWidth - _offset;
			_lblScore.y = Config.getNumber("height", ["world"]) - _lblScore.textHeight - _offset;
			_lblPause = new Label("THE GAME IS NOW PAUSED", 70, Config.getColor("hex", ["color","white"]), "Ostrich", true);
			
			var worldCenter:Point = Utils.getWorldCenter();
			_lblPause.x = worldCenter.x - _lblPause.textWidth * 0.5;
			_lblPause.y = worldCenter.y - _lblPause.textHeight * 0.5;
			
			this.addChild(_lblScore);
			super();
			initLives();
		}
		
		public function removeLive():void{
			var bitmapIndex:Number = _lives.length - 1;
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
			_lblScore.x = Config.getNumber("width", ["world"]) - _lblScore.textWidth - _offset;
		}
		
		public function displayPauseLabel(condition:Boolean):void {
			if (condition){
				this.addChild(_lblPause);
			}else{
				this.removeChild(_lblPause);
			}
		}
		
		public function initLives():void{
			var lives:Number = Config.getNumber("tot_lives", ["entities", "ship"]);
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
			
			if (_lblPause.parent){
				removeChild(_lblPause);
				_lblPause.destroy();
				_lblPause = null;
			}
			
			_lives.length = 0;
			_lives = null;
			_lblScore.destroy();
			removeChild(_lblScore);
			_lblScore = null;
			
		}
	
	}

}