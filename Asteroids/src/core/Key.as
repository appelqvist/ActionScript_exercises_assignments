package core {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Key{
		
		private static var _dispatcher:EventDispatcher; 
		
		private static var _init:Boolean = false;
		private static var _keys:Object = {};
		
		public static const FIRE:uint = Keyboard.SPACE;
		public static const ACCELERATE:uint = Keyboard.W;
		public static const BREAK:uint = Keyboard.S;
		public static const LEFT:uint = Keyboard.A;
		public static const RIGHT:uint = Keyboard.D;
		public static const PAUSE:uint = Keyboard.ESCAPE;
		
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
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_dispatcher.removeEventListener(type, listener, useCapture);
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