package 
{
	import flash.display.Sprite;
	
	public class Entity extends Sprite 
	{
		private var _speedX:Number;
		private var _speedY:Number;
		
		public function Entity(shape:String, color:uint = 0x0000FF) 
		{
			super();
			draw(shape, color);
		}
		
		public function draw (shape:String, color:uint):void{
			graphics.clear();
			graphics.beginFill(color, 1);
			 
			if(shape == "rectangle"){
				graphics.drawRect(0, 0, 50, 50);
			}else if(shape == "circle"){
				graphics.drawRoundRect(0, 0, 50, 50, 50, 50); //To not have special case for cricles, the circles goes out from the center..
			}else{
				//Rounded rectangle
				graphics.drawRoundRect(0, 0, 50, 50, 15, 15);
			}
			
			graphics.endFill();			
	
		}
		
		public function getSpeedX():Number{
			return _speedX;
		}
		
		public function getSpeedY():Number{
			return _speedY;
		}
		
		public function setSpeedX(newSpeedX:Number):void{
			_speedX = newSpeedX;
		}
		
		public function setSpeedY(newSpeedY:Number):void{
			_speedY = newSpeedY
		}
	}

}