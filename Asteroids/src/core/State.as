package core 
{
	import flash.display.Sprite;
	
	public class State extends Sprite 
	{
		private var _fsm:Game;
		
		public function State(fsm:Game) 
		{
			super();
			_fsm = fsm;
		}
		
		public function update():void{
			
		}
		
		public function destroy():void{
			
		}
	
		
	}

}