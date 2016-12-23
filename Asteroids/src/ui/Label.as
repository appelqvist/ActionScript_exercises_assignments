package ui 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	import core.Config;

	public class Label extends TextField {
		
		private var _format:TextFormat;
		
		public function Label(text:String, size:Number = 30, color:uint = 0xFFFFF, fontName:String="Times New Roman", embededFonts:Boolean=false, posX:Number=100, posY:Number=100) {
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
		
		public function destroy():void{
			_format = null;
		}
	}
}