package events 
{
	import flash.events.Event;
	public class ShotEvent extends Event 
	{
		public static const ON_SHOT:String = "onPlayerShot"; 
		
		public var _x:Number = 0;
		public var _y:Number = 0;
		public var _direction:Number = 0;
		public var _enemyBullet:Boolean = false;
		
		public function ShotEvent(x:Number, y:Number, direction:Number, enemyBullet:Boolean = false){
			super(ON_SHOT, false, false);
			_x = x;
			_y = y;
			_direction = direction;
			_enemyBullet = enemyBullet;
		}
		
		override public function clone():Event{
			return new ShotEvent(_x, _y, _direction);
		}
	}

}