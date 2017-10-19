package core {
	import manager.SoundManager;
	import starling.display.Sprite;
	import core.State;
	
	/**
	 * 
	 * @author Andréas Appelqvist
	 */
	public class State extends Sprite{
		
		protected var _fsm:Game;
		protected var _soundManager:SoundManager;
		
		public function State(fsm:Game, sm:SoundManager){
			super();
			_fsm = fsm;
			_soundManager = sm;
		}
		
		public function update(deltaTime:Number):void{}
		
		public function destroy():void{
			_fsm = null;
			_soundManager = null;
		}
		
	}
}