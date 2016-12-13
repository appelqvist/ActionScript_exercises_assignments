package states 
{
	import core.Config;
	import core.Entity;
	import core.Game;
	import core.Key;
	import core.State;
	import flash.events.Event;
	

	public class Play extends State{
		private var _entities:Vector.<Entity> = new Vector.<Entity>;
		
		public function Play(fsm:Game){
			super(fsm);
		}
		
		private function addEntity(e:Entity):void{
			_entities.push(e);
			addChild(e);
		}
		
		override public function update():void{
			for (var i:Number = 0; i < _entities.length; i++){
				_entities[i].update();
			}
		}
		
		override public function destroy():void{
			for (var i:Number = 0; i < _entities.length; i++){
				removeChild(_entities[i]);
				_entities[i].destroy();
			}
			_entities = new Vector.<Entity>;
			super.destroy();
		}
		
	}

}