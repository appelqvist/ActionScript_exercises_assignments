package events 
{
	import flash.events.Event;
	
	public class UfoHitEvent extends Event {
		public static const UFO_HIT:String = "ufoHit";
		public var _x:Number = 0;
		public var _y:Number = 0;
		
		public function UfoHitEvent(x:Number, y:Number) {
			_x = x;
			_y = y;
			super(UFO_HIT, false, false);
		}
		
		override public function clone():Event{
			return new UfoHitEvent(_x, _y);
		}
		
	}

}