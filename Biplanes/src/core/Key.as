package core {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * Static class that that talks with I/O-devices
	 */
	public class Key{
		
		private static var _dispatcher:EventDispatcher; 
		
		private static var _init:Boolean = false;
		private static var _keys:Object = {};
		
		private static const SPACE:uint = Keyboard.SPACE;
		
		public static const LEFT_LIFT:uint = Keyboard.W;
		public static const LEFT_TURN_RIGHT:uint = Keyboard.D;
		public static const LEFT_TURN_LEFT:uint = Keyboard.A;
		public static const LEFT_SHOOT:uint = Keyboard.V;
		public static const RIGHT_LIFT:uint = Keyboard.UP;
		public static const RIGHT_TURN_RIGHT:uint = Keyboard.RIGHT;
		public static const RIGHT_TURN_LEFT:uint = Keyboard.LEFT;
		public static const RIGHT_SHOOT:uint = Keyboard.M;
		
		public static const PAUSE_P:uint = Keyboard.P;
		public static const PAUSE_ESC:uint = Keyboard.ESCAPE;
		public static const	RESTART:uint = Keyboard.R;
		public static const QUIT:uint = Keyboard.Q;
		public static const SPACE:uint = Keyboard.SPACE;
		
		
		public static function init(s:Stage):void{
			if (!_init){
				_dispatcher = new EventDispatcher();
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
			_dispatcher.dispatchEvent(e);
		}
		
		public static function onKeyRelease(e:KeyboardEvent):void{
			delete _keys[e.keyCode];
		}
		
		public static function onDeactivate(e:Event):void{
			_keys = {};
		}
		
		public static function addEventListener(type:String, listener:Function):void {
			_dispatcher.addEventListener(type, listener, false, 0, true);
		}
		
		public static function removeEventListener(type:String, listener:Function):void {
			_dispatcher.removeEventListener(type, listener);
		}
		
		public static function dispatchEvent(event:Event):Boolean {
			return _dispatcher.dispatchEvent(event);
		}
		
		public static function hasEventListener(type:String):Boolean {
			return _dispatcher.hasEventListener(type);
		}
		
		public static function willTrigger(type:String):Boolean {
			return willTrigger(type);
		}
	}

}