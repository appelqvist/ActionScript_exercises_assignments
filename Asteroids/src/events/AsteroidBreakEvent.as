package events 
{
	import flash.events.Event;
	public class AsteroidBreakEvent extends Event 
	{
		
		public static const ASTEROID_BREAK:String = "asteroidBreakEvent"; 
		
		public var _x:Number = 0;
		public var _y:Number = 0;
		public var _type:Number = 0; //Asteriod size/type
		
		
		public function AsteroidBreakEvent(x:Number, y:Number, type:Number) {
			super(ASTEROID_BREAK, false , false);
			_x = x;
			_y = y;
			_type = type;
		}
		
		override public function clone():Event{
			return new AsteroidBreakEvent(_x, _y, _type);
		}
		
	}

}