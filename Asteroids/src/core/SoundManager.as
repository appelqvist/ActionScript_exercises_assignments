package core 
{
	public class SoundManager {
		private var _sfxShoot:SimpleSound = new SimpleSound(Config.getSettings("url", ["sound", "sfx", "sfx_shoot"]));
		private var _sfxHit:SimpleSound = new SimpleSound(Config.getSettings("url", ["sound", "sfx", "sfx_hit"]));
		private var _sfxExplosion:SimpleSound = new SimpleSound(Config.getSettings("url", ["sound", "sfx", "sfx_explosion"]));
		private var _soundBackground:SimpleSound = new SimpleSound(Config.getSettings("url", ["sound", "sfx", "sfx_background"]), null, true, Config.getNumber("lowest", ["sound", "level"]));
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