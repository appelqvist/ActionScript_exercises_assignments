package ui 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;

	public class Label extends TextField {
		
		private var _format:TextFormat;
		
		public function Label(text:String, size:Number = 30, color:uint=core.Config.WHITE, fontName:String="Times New Roman", embededFonts:Boolean=false, posX:Number=0, posY:Number=0) {
			super();
			_format = new TextFormat(fontName, size, color);
			_format.align = TextFormatAlign.LEFT;
			this.defaultTextFormat = _format;
			this.embedFonts = true;
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.multiline = false;
			this.cacheAsBitmap = true;
			this.selectable = false;
			this.text = text;
		}
		
	}

}