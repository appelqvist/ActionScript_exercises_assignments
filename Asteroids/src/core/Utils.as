package core {
	import core.Entity;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Utils {
		
		public static function random(min:Number, max:Number):Number{
			return Math.floor(Math.random() * (max - min)) + min;
		}
		
		/*Math from "Making Thing Move!" by Keith Peters*/
		public static function lineCircleIntersection(lineStart:Point, lineEnd:Point, entity:Entity):Boolean {
			var angle:Number = Math.atan2((lineEnd.y-lineStart.y), (lineEnd.x-lineStart.x));
			var dx:Number = entity.centerX-((lineStart.x+lineEnd.x) * 0.5);
			var dy:Number = entity.centerY-((lineStart.y+lineEnd.y) * 0.5);
			return (Math.abs(Math.cos(angle)*dy - Math.sin(angle)*dx) < entity.radius);
		}
		
		public static function distanceSq(e1:Entity, e2:Entity):Number{
			var dx:Number = e1.centerX - e2.centerX;
			var dy:Number = e1.centerY - e2.centerY;
			return (dx * dx + dy * dy);
		}
		
		public static function distance(e1:Entity, e2:Entity):Number{
			var dx:Number = e1.centerX - e2.centerX;
			var dy:Number = e1.centerY - e2.centerY;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		
		//SAT intersection test. http://www.metanetsoftware.com/technique/tutorialA.html
		//returns true on intersection, and sets the least intersecting axis in overlap
		public static function getOverlap(lhs:Entity, rhs:Entity, overlap:Point):Boolean {
			overlap.setTo(0, 0);
			var centerDeltaX:Number = lhs.centerX - rhs.centerX;
			var halfWidths:Number = (lhs.width + rhs.width) * 0.5;
		 
			if (Math.abs(centerDeltaX) > halfWidths) return false; //no overlap on x == no collision
		 
			var centerDeltaY:Number = lhs.centerY - rhs.centerY;
			var halfHeights:Number = (lhs.height + rhs.height) * 0.5;
		 
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
