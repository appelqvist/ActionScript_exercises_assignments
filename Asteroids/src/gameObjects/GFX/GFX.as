package gameObjects.GFX 
{
	import com.adobe.tvsdk.mediacore.TextFormat;
	import core.Entity;
	import ui.Label;
	import core.Config;
	import core.Utils;;
	
	public class GFX extends Entity{
		
		protected var _label:Label;
		
		public function GFX(x:Number = 0, y:Number = 0, text:String = "This is a GFX", size:Number = 14, color:uint = 0xFFFFFF){
			super(x, y);
			_label = new Label(text, size, color, "Ostrich", true);
			addChild(_label);
			_label.x = -(_label.width * 0.5);
			_label.y = -(_label.height * 0.5);
		}
		
		override public function isColliding(e:Entity):Boolean{
			return false;
		}
		
		override public function destroy():void{
			removeChild(_label);
			_label.destroy();
			_label = null;
		}
		
	}

}