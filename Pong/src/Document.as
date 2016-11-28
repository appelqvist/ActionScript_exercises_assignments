package 
{
	import com.adobe.tvsdk.mediacore.ABRControlParameters;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	[SWF(width="1280", height="720", backgroundColor="0x000000", frameRate="30")]
	public class Document extends Sprite {
		private var _game:Game;
		
		public function Document() 
		{
			if (stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Key.init(stage);
			_game = new Game();
			addChild(_game);
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true); 
			addEventListener(Event.DEACTIVATE, onDeactive, false, 0, true); 
		}
		
		private function onDeactive(e:Event):void{
			removeEventListener(Event.DEACTIVATE, onDeactive);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ACTIVATE, onActivate, false, 0, true);
		}
		
		private function onActivate(e:Event):void{
			removeEventListener(Event.ACTIVATE, onActivate);
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			addEventListener(Event.DEACTIVATE, onDeactive, false, 0, true);
		}
		
		private function onEnterFrame(e:Event):void{
			_game.update();
		}
		
	}

}