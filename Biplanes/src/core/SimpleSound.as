package core{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/** 
	 * Sound-obj
	 */
	public class SimpleSound extends Sound{
		
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		private var _position:Number = 0;
		private var _loop:Boolean;
		private var _validTrack:Boolean = false; 
		protected var _playing:Boolean = false;
		
		public function SimpleSound(path:String = "", context:SoundLoaderContext = null,
									loop:Boolean = false, volume:Number = 0.5) {
			addEventListener(IOErrorEvent.IO_ERROR, notFound);
			var stream:URLRequest = new URLRequest(path);
			super(stream, context);
			_soundTransform =  new SoundTransform(volume);
			_loop = loop;
			_validTrack = true;
		}
		
		private function notFound(e:Event):void{
			_validTrack = false;
			trace("Not Found");
		}
		
		public function start():void{
			if (_validTrack){
				_soundChannel = play();
				_playing = true;
				_soundChannel.soundTransform = _soundTransform;
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
			}
		}
		
		public function stop():void{
			if (_validTrack && _soundChannel != null){
				_soundChannel.stop();
				_playing = false;
			}
		}
		
		public function pause():void{
			if (_validTrack){
				_position = _soundChannel.position;
				_soundChannel.stop();
				_playing = false;
			}
		}
		
		public function resume():void{
			if (_validTrack){
				_soundChannel = play(_position);
				_playing = true;
				_soundChannel.soundTransform = _soundTransform;
			}
		}
		
		public function setVolume(vol:Number):void{
			_soundTransform.volume = vol;
		}
		
		public function setPan(pan:Number):void{
			_soundTransform.pan = pan;
		}
		
		public function isPlaying():Boolean{
			return _playing;
		}
		
		public function onSoundComplete(e:Event):void{
			if (_loop){
				stop();
				start();
			}else{
				stop();
				_playing = false;
				removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
		}
		
		public function destroy():void{
			stop();
			_soundChannel = null;
			_soundTransform = null;
			if (hasEventListener(Event.SOUND_COMPLETE)){
				removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
			removeEventListener(IOErrorEvent.IO_ERROR, notFound);
		}
	}

}