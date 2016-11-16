package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width = "500", height = "500", backgroundColor = "0xEEEEEE", frameRate = "30")]
	
	public class Document extends Sprite 
	{	
		private var _entities:Array = [];
		private var _withBound:Boolean = false; //Change between true and false to switch from wrapping to boundaries
		
		public function Document() 
		{
			super();
			var temp:Entity
			for (var i:Number = 0; i < 30; i++){
				
				var color:uint = getRandomInt(0,255) * 0x10000 + getRandomInt(0,255) * 0x100 + getRandomInt(0,255);
				
				var val:Number = getRandomInt(0,3);
				switch(val){
					case 0:
						temp = new Entity("rectangle", color);
						break;
					case 1:
						temp = new Entity("circle", color);
						break;
					case 2:
						temp = new Entity("roundrect", color);
						break;
				}
			
				temp.x = getRandomInt(0, stage.stageWidth - temp.width)
				temp.y = getRandomInt(0, stage.stageHeight - temp.height) 
				temp.setSpeedX(getRandomInt(-5, 6));
				temp.setSpeedY(getRandomInt( -5, 6));
				addEntity(temp)
			}
		
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function getRandomInt(min:Number, max:Number):Number{
			return Math.floor(Math.random() * (max - min)) + min;
		}
		
		private function addEntity(e:Sprite):void{
			_entities.push(e);
			addChild(e);
		}
		
		private function removeEntity(index:Number):void{
			removeChild(_entities[index]);
			_entities.removeAt(index);
		}
		
		public function onEnterFrame(e:Event):void{
			var temp:Entity;
			for (var i:Number = _entities.length - 1; i >= 0; i--){
				temp = _entities[i];
				
				temp.x += temp.getSpeedX();
				temp.y += temp.getSpeedY();
				
				
				//Has boundaries.
				if(_withBound){
					if (temp.x > stage.stageWidth - temp.width){
						//Crash with the right side
						temp.setSpeedX(-1 * Math.abs(temp.getSpeedX()));
					}else if (temp.x < 2){
						//Crash with the left side
						temp.setSpeedX(Math.abs(temp.getSpeedX()));
					}
					
					if (temp.y > stage.stageHeight - temp.height){
						//Crash down
						temp.setSpeedY(-1 * Math.abs(temp.getSpeedY()));
					}else if (temp.y < 2){
						//Crash up
						temp.setSpeedY(Math.abs(temp.getSpeedY()));
					}
				}
				
				//Will just continue on the other side
				if(!_withBound){
					if (temp.x > stage.stageWidth && temp.getSpeedX() > 0){
						//Crash with the right side
						temp.x = -temp.width;
					}else if (temp.x+temp.width < 0 && temp.getSpeedX() < 0){
						//Crash with the left side
						temp.x = stage.stageWidth;
					}
					
					if (temp.y > stage.stageHeight && temp.getSpeedY() > 0){
						//Crash down
						temp.y = - temp.height;
					}else if (temp.y+temp.height < 0 && temp.getSpeedY() < 0){
						//Crash up
						temp.y = stage.stageHeight;
					}
				}
			}
		}
	}

}