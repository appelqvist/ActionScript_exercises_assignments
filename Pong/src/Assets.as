package 
{
	import flash.display.Bitmap;
	public class Assets 
	{		
		public function Assets(){}
		
		[Embed(source = "assets/OstrichSans-Heavy.otf",
			fontName = "Ostrich",
			mimeType = "application/x-font",
			advancedAntiAliasing = "true",
			unicodeRange = "U+0020-U+0021, U+002d, U+002f-U+003a, U+0041-U+0056, U+0058-U+005a, U+00c4-U+00c5, U+00d6",
			embedAsCFF = "false"
			)]
		public var OstrichClass:Class;
	
		[Embed(source="assets/btnnormal.png")]
		public static const BtnNormal:Class;
		
		[Embed(source="assets/btnhover.png")]	
		public static const BtnHover:Class;
		
		[Embed(source="assets/btnclick.png")]
		public static const BtnClick:Class;
		
		public static function getImage(name:String):Bitmap{
			switch(name){
				case "btnClick":
					return new BtnClick as Bitmap;
				case "btnHover":
					return new BtnHover as Bitmap;
				default: //default: normal
					return new BtnNormal as Bitmap;
			}
		}
	}

}