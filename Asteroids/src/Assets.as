package {
	import flash.display.Bitmap;
	Bitmap
	public class Assets {
		[Embed(source = "assets/OstrichSans-Heavy.otf",
		fontName = "Ostrich",
		mimeType = "application/x-font",
		advancedAntiAliasing = "true",
		unicodeRange = "U+0020-U+0021, U+002d, U+002f-U+003a, U+0041-U+005a",
		embedAsCFF = "false"
		)]
		private static const OstrichClass:Class;
		
		[Embed(source="assets/sheart.png")]
		public static const Heart:Class;
		
		
		public static function getImage(name:String):Bitmap{
			switch(name){
				default: 
					return new Heart as Bitmap;
			}
		}
	}
}