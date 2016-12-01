package 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SimpleSound extends Sound{
		
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		
		public function SimpleSound(stream:URLRequest=null, context:SoundLoaderContext=null) {
			super(stream, context);	
		}
		
		public function stop():void{
			
		}
		
		public function pause():void{
			
		}
		
		public function resume():void{
			
		}
		
		public function setVolume(vol:Number):void{
			
		}
		
		public function setPan(pan:Number):void{
			
		}
		
	}

}