package events {
	import starling.events.Event;
	
	/**
	 * ShotEvent
	 * @author Andréas Appelqvist
	 */
	public class ShotEvent extends Event {
		
		public static const ON_SHOT:String = "onPlayerShot";
		public var _x:Number = 0;
		public var _y:Number = 0;
		public var _direction:Number = 0;
		
		public function ShotEvent(x:Number, y:Number, direction:Number) {
			super(ON_SHOT, false, false);
			_x = x;
			_y = y;
			_direction = direction;
		}
		
	}

}