package core 
{
	public class SoundManager {
		private var _sfxShoot:SimpleSound = new SimpleSound(Config.SFX_SHOOT_URL);
		private var _sfxHit:SimpleSound = new SimpleSound(Config.SFX_HIT_URL);
		private var _sfxExplosion:SimpleSound = new SimpleSound(Config.SFX_EXPLOSION_URL);
		private var _soundBackground:SimpleSound = new SimpleSound(Config.SFX_BACKGROUND_URL, null, true, Config.SOUND_VERY_LOW);
		public function SoundManager() { }
		
		public function playHit():void{
			_sfxHit.play();
		}
		public function playShoot():void{
			_sfxShoot.play();
		}
		public function playExplosion():void{
			_sfxExplosion.play();
		}
		public function playBackground():void{
			_soundBackground.play();
		}
		
	}

}