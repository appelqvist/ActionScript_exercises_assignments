package 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SimpleSound extends Sound{
		
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		private var _position:Number = 0;
		private var _loop:Boolean;
		private var _validTrack:Boolean = false;  //Used to not call play() if the mp3 is not found or valid.
		
		public function SimpleSound(path:String = "", context:SoundLoaderContext = null,
									loop:Boolean = false, volume:Number = Config.SOUND_MED) {
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
				_soundChannel.soundTransform = _soundTransform;
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
			}
		}
		
		public function stop():void{
			if (_validTrack && _soundChannel != null){
				_soundChannel.stop();
			}
		}
		
		public function pause():void{
			if (_validTrack){
				_position = _soundChannel.position;
				_soundChannel.stop();
			}
		}
		
		public function resume():void{
			if (_validTrack){
				_soundChannel = play(_position);
				_soundChannel.soundTransform = _soundTransform;
			}
		}
		
		public function setVolume(vol:Number):void{
			_soundTransform.volume = vol;
		}
		
		public function setPan(pan:Number):void{
			_soundTransform.pan = pan;
		}
		
		public function onSoundComplete(e:Event):void{
			if (_loop){
				stop();
				_soundChannel.soundTransform = _soundTransform;
				_soundChannel = play(0);
				trace("loop");
			}else{
				stop();
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