package core {
	import core.Entity;
	import flash.geom.Point;
	
	public class Utils {
		
		public static function random(min:Number, max:Number):Number{
			return Math.floor(Math.random() * (max - min)) + min;
		}
		
		//SAT intersection test. http://www.metanetsoftware.com/technique/tutorialA.html
		//returns true on intersection, and sets the least intersecting axis in overlap
		public static function getOverlap(e1:core.Entity, e2:core.Entity, overlap:Point):Boolean {
			overlap.setTo(0, 0);
			var centerDeltaX:Number = e1.centerX - e2.centerX;
			var halfWidths:Number = (e1.width + e2.width) * 0.5;
		 
			if (Math.abs(centerDeltaX) > halfWidths) return false; //no overlap on x == no collision
		 
			var centerDeltaY:Number = e1.centerY - e2.centerY;
			var halfHeights:Number = (e1.height + e2.height) * 0.5;
		 
			if (Math.abs(centerDeltaY) > halfHeights) return false; //no overlap on y == no collision
		 
			var dx:Number = halfWidths - Math.abs(centerDeltaX); //overlap on x
			var dy:Number = halfHeights - Math.abs(centerDeltaY); //overlap on y
			if (dy < dx) {
				overlap.y = (centerDeltaY < 0) ? -dy : dy;
			} else if (dy > dx) {
				overlap.x = (centerDeltaX < 0) ? -dx : dx;
			} else {
				overlap.x = (centerDeltaX < 0) ? -dx : dx;
				overlap.y = (centerDeltaY < 0) ? -dy : dy;
			}
			return true;
		}
		
		public static function IntersectionAABB(e1:core.Entity, e2:core.Entity):Boolean {
			return !(e1.right < e2.left
					|| e2.right < e1.left
					|| e1.bottom < e2.top
					|| e2.bottom < e1.top);
		}
		
	}
}
