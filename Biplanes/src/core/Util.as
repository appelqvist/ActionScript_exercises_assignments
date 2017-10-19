package core {
	
	/**
	 * Util
	 * @author Andréas Appelqvist
	 */
	public class Util{
		
		public function Util(){ }
		
		public static function random(min:Number, max:Number):Number{
			return Math.floor(Math.random() * (max - min)) + min;
		}
		
	}

}