package core 
{
	import flash.display.Sprite;
	
	public class State extends Sprite 
	{
		protected var _fsm:Game;
		protected var _soundManager:SoundManager;
		
		public function State(fsm:Game, soundManager:SoundManager){
			super();
			_fsm = fsm;
			_soundManager = soundManager;
		}
		
		public function update():void{
			
		}
		
		public function destroy():void{
			
		}
	
		
	}

}