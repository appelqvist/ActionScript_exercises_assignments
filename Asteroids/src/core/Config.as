package core 
{
	public class Config {
		public static const BLACK:uint = 0x111111;
		public static const WHITE:uint = 0xFFFFFF;
		
		public static const WORLD_WIDTH:Number = 1280;
		public static const WORLD_HEIGHT:Number = 720;
		public static const WORLD_CENTER_X:Number = WORLD_WIDTH * 0.5;
		public static const WORLD_CENTER_Y:Number = WORLD_HEIGHT * 0.5;
		
		public static const GAME_STATE_MENU:Number = 0;
		public static const GAME_STATE_PLAY:Number = 1;
		public static const GAME_STATE_GAMEOVER:Number = 2;
		public static const GAME_STATE_INSTRUCTIONS:Number = 3;
		
		public static const SHIP_WIDTH:Number = 30;
		public static const SHIP_HEIGHT:Number = 15;
		public static const SHIP_TOP_SPEED:Number = 10;
		
		public static const SHIP_FRICTION:Number = 0.98;
		
		public static const SOUND_VERY_LOW:Number = 0.1;
		public static const SOUND_LOW:Number = 0.25;
		public static const SOUND_MED:Number = 0.5;
		public static const SOUND_HIGH:Number = 0.7;
		public static const SOUND_HIGHEST:Number = 1;
		
		public static const TO_RAD:Number = (Math.PI / 180);
		public static const TO_DEG:Number = (180 / Math.PI);
	

	}

} 