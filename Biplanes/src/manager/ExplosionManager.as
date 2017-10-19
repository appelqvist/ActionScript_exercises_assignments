package manager {
	import starling.events.Event;
	import gameObject.Explosion;
	import states.Play;
	/**
	 * Handle explosion-call
	 * @author Andréas Appelqvist
	 */
	public class ExplosionManager {
		
		private var _play:Play;
		
		public function ExplosionManager(play:Play) {
			this._play = play;
		}
		
		public function spawnExplosion(x:Number, y:Number):void{
			var ex:Explosion = new Explosion();
			ex.emitterX = x;
			ex.emitterY = y;
			_play.addChild(ex);
			ex.addEventListener(Event.COMPLETE, onComplete);
			ex.start(0.1);
		}
		
		public function onComplete(e:Event):void{
			var ex:Explosion = e.currentTarget as Explosion;
			ex.dispose();
		}
		
		public function destroy():void{
			_play = null;
		}
		
	}

}