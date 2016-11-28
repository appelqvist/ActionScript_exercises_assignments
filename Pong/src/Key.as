package {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	public class Key {
		
		private static var _init:Boolean = false;
		private static var _keys:Object = {} //Empty object
		
		public static const SERVE:uint = Keyboard.SPACE;
		public static const LEFT_PADDLE_UP:uint = Keyboard.W;
		public static const LEFT_PADDLE_DOWN:uint = Keyboard.S;
		
		public static function init(s:Stage):void{
			if(!_init){
				s.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress, false, 0, true);
				s.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease, false, 0, true);
				s.addEventListener(Event.DEACTIVATE, onDeactivate, false, 0, true);
				_init = true;
			}
		}
		
		public static function isKeyPressed(keyCode:uint):Boolean{
			return (keyCode in _keys);
		}
		
		public static function onKeyPress(e:KeyboardEvent):void{
			_keys[e.keyCode] = true;
		}
		
		public static function onKeyRelease(e:KeyboardEvent):void{
			delete _keys[e.keyCode];
		}
		
		public static function onDeactivate(e:Event):void{
			_keys = {};
			
		}
	}

}