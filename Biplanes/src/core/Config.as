package core {
	/**
	 * Config-class that holds the settings of the game.
	 * @author Andréas Appelqvist
	 */
	public class Config {
		public static const worldWidth:Number = 1280;
		public static const worldHeight:Number = 720;
		public static const defaultFont:String = "Ostrich";

		public static const biplaneWidth:Number = 60;
		public static const biplaneHeight:Number = 30;
		public static const biplaneSpeed:Number = 350;
		public static const biplaneTakeOffAcc:Number = 1200;
		public static const biplaneTakeOffSpeedThreshold:Number = 300;
		public static const biplaneTakeOffThresholdToFlying:Number = 60;
		public static const biplaneTakeOffTopSpeed:Number = 320;
		
		public static const leftBiplaneStartX:Number = 40;
		public static const leftBiplaneStartY:Number = worldHeight - 40;
		
		public static const rightBiplaneStartX:Number = worldWidth-40;
		public static const rightBiplaneStartY:Number = worldHeight-40;
		
		public static const rateOfFire:Number = 200;
		
		public static const biplaneRotationSpeed:Number = 2;
		
		public static const bulletRadius:Number = 4;
		public static const bulletTimeToLive:Number = 0.8;
		public static const bulletSpeed:Number = 1000;
		
		public static const towerHeight:Number = 120;
		public static const towerWidth:Number = 60;
		public static const towerX:Number = worldWidth * 0.5;
		public static const towerY:Number = worldHeight - 30 - towerHeight * 0.5;
		
		public static const totalLives:Number = 3;
		public static const respawnCooldown:Number = 3000;
	
		public static const sfxExplosion:String = "./assets/explosion.mp3";
		public static const sfxShot:String = "./assets/shot.mp3";
		public static const sfxEnginge:String = "./assets/engine.mp3";
		
		public static const soundBackgroundSrc:String = "./assets/background.mp3";
		public static const backgroundSkyWithGround:String = "bgsky_g";
		public static const backgroundSky:String = "bgsky";
	}

}