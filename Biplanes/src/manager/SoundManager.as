package manager {
	import core.SimpleSound;
	import core.Config;
	/**
	 * SoundManager that handle all sound call.
	 * @author Andréas Appelqvist
	 */
	public class SoundManager {
		private var _soundBackground:SimpleSound = new SimpleSound(Config.soundBackgroundSrc, null, true, 0.1);
		private var _explosion:SimpleSound = new SimpleSound(Config.sfxExplosion, null, false, 0.8);
		private var _sfxShoot:Vector.<SimpleSound> = new Vector.<SimpleSound>;
		private var _sfxEngine:SimpleSound = new SimpleSound(Config.sfxEnginge, null, true, 0.05);
	
		public function SoundManager() {
			for (var i:Number = 0; i < 6; i++){
				_sfxShoot.push(new SimpleSound(Config.sfxShot));
			}
		}
		
		public function playBackground():void{
			if(!_soundBackground.isPlaying())
				_soundBackground.start();
		}		
		
		private function getPanValue(objectCenterX:Number):Number{
			var minRange:Number = -1, maxRange:Number = 1;
			var pan:Number =  (maxRange - minRange) / (Config.worldWidth) * (objectCenterX - Config.worldWidth) + maxRange;
			return pan;
		}
		
		public function playExplosion(x:Number):void{
			_explosion.setPan(getPanValue(x));
			_explosion.start();
		}
		
		public function playShot(x:Number):void{
			for (var i:Number = 0; i < _sfxShoot.length; i++){
				if (!_sfxShoot[i].isPlaying()){
					_sfxShoot[i].setPan(getPanValue(x));
					_sfxShoot[i].start();
					break;
				}
			}
		}
		
		public function playEngine():void{
			if (!_sfxEngine.isPlaying()){
				_sfxEngine.start();
			}
		}
		
		public function stopEngine():void{
			if (_sfxEngine.isPlaying()){
				_sfxEngine.stop();
			}
		}
		
		public function destroy():void{
			_sfxEngine = null;
			_sfxShoot = null;
			_explosion = null;
			_soundBackground = null;
		}
	}
}