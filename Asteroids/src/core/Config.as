package core 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
    import flash.events.*;
	
	public class Config {
		private static var _dispatcher:EventDispatcher = new EventDispatcher; 
		private static var _cache:Object = {};
		private static var _data:XML;
		
		public static function getSettings(key:String, path:Array):String{
			var hashKey:String = path.toString()+key;
			if (_cache[hashKey] != undefined){
				return _cache[hashKey];
			}
			
			var xml:XMLList = Config._data[path[0]];
			if (path.length > 1){
				for (var i:Number = 1; i < path.length; i++){
					xml = xml[path[i]];
				}
			}
			var value:String = xml.attribute(key)
			_cache[hashKey] = value;
			return value;
		}
		
		
		public static function loadConfig():void{
			var loader:URLLoader = new URLLoader();
			var url:URLRequest = new URLRequest("settings.xml");
			
			loader.addEventListener(Event.COMPLETE, Config.completeHandler, false, 0, true);
            loader.addEventListener(Event.OPEN, Config.openHandler, false, 0, true);
            loader.addEventListener(ProgressEvent.PROGRESS, Config.progressHandler, false, 0, true);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, Config.securityErrorHandler, false, 0, true);
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, Config.httpStatusHandler, false, 0, true);
            loader.addEventListener(IOErrorEvent.IO_ERROR, Config.ioErrorHandler, false, 0, true);
			
			try{
				loader.load(url);
			}catch (error:Error){
				trace("Error when loading: " + error);
			}
		}

        private static function completeHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
			var data:XML = XML(loader.data);
			Config._data = data;
			dispatchEvent(event);
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
        private static function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }
        private static function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        private static function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
        private static function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }
        private static function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
}
		public static function getInt(key:String, path:Array):int{
			 return parseInt(getSettings(key, path));
		}
		public static function getNumber(key:String, path:Array):Number{
			return parseFloat(getSettings(key, path));
		}
		public static function getBoolean(key:String, path:Array):Boolean{
			var s:String = getSettings(key, path);
			return (s == "1" || s == "true");
		}
		public static function getColor(key:String, path:Array):uint{
			return parseInt(getSettings(key, path));}
	
	}
} 