package core 
{
	public class Config {
		public static const BLACK:uint = 0x111111;
		public static const WHITE:uint = 0xFFFFFF;
		public static const LIGHT_ORANGE:uint = 0xff6735;
		
		public static const WORLD_WIDTH:Number = 1280;
		public static const WORLD_HEIGHT:Number = 720;
		public static const WORLD_CENTER_X:Number = WORLD_WIDTH * 0.5;
		public static const WORLD_CENTER_Y:Number = WORLD_HEIGHT * 0.5;
		
		public static const LINE_SIZE:Number = 2;
		
		public static const SHIP_WIDTH:Number = 30;
		public static const SHIP_HEIGHT:Number = 15;
		public static const SHIP_TOP_SPEED:Number = 10;
		public static const SHIP_FRICTION:Number = 0.96;
		public static const SHIP_RATE_OF_FIRE:Number = 100;
		public static const SHIP_TOT_LIVES:Number = 3;
		
		public static const BULLET_IMPULSE:Number = 10;
		public static const BULLET_TIME_TO_LIVE:Number = 30; //frames
		
		public static const SOUND_VERY_LOW:Number = 0.1;
		public static const SOUND_LOW:Number = 0.25;
		public static const SOUND_MED:Number = 0.5;
		public static const SOUND_HIGH:Number = 0.7;
		public static const SOUND_HIGHEST:Number = 1;
		
		public static const TO_RAD:Number = (Math.PI / 180);
		public static const TO_DEG:Number = (180 / Math.PI);
		
		public static const SFX_SHOOT_URL:String = "./assets/shoot.mp3";
		public static const SFX_EXPLOSION_URL:String = "./assets/explosion.mp3";
		public static const SFX_HIT_URL:String = "./assets/hit.mp3";
		public static const SFX_BACKGROUND_URL:String = "./assets/background.mp3";
		
	

	}

} 