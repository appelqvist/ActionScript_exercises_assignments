package events 
{
	import flash.events.Event;
	public class PlayerShotEvent extends Event 
	{
		public static const PLAYER_SHOT:String = "onPlayerShot"; 
		
		public var _x:Number = 0;
		public var _y:Number = 0;
		public var _direction:Number = 0;
		
		public function PlayerShotEvent(x:Number, y:Number, direction:Number){
			super(PLAYER_SHOT, false, false);
			_x = x;
			_y = y;
			_direction = direction;
		}
		
		override public function clone():Event{
			return new PlayerShotEvent(_x, _y, _direction);
		}
	}

}