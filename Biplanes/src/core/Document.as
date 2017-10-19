package core{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * This class will init Biplane as a starling project.
	 * @author Andréas Appelqvist
	 */
	[SWF(frameRate="60", width="1280", height="720", backgroundColor="0x333333")]
	public class Document extends Sprite{
		private var _myStarling:Starling;
		
		public function Document(){
			if (stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void {
			Key.init(stage);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_myStarling = new Starling(core.Game, stage);
			_myStarling.showStats = true;
			_myStarling.start();
		}
		
	}
	
}