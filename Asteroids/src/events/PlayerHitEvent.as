package events{
	import flash.events.Event;
	public class PlayerHitEvent extends Event{
		
		public static const PLAYER_HIT:String = "playerHit";
			
		public function PlayerHitEvent() {
			super(PLAYER_HIT, false, false);
		}
		
		override public function clone():Event{
			return new PlayerHitEvent();
		}
		
	}

}