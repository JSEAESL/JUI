package JLib.BaseMusic
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class JSound extends Sound
	{
		public function JSound(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
		public static function creatSound(url:String=null, context:SoundLoaderContext=null):JSound
		{
			var result:JSound = new JSound()
			var req:URLRequest = new  URLRequest(url);
			var con:SoundLoaderContext = (context == null)? new SoundLoaderContext(1000,true):context;
			result.load(req,con);
			return result;
		}
		
		public static function creatSoundByteArray(byte:ByteArray):JSound
		{
			var result:JSound = new JSound()
			result.loadCompressedDataFromByteArray(byte,byte.length/2)
			return result
		}
		
		public function creatSoundChannel(startTime:Number=0, loops:int=999, sndTransform:SoundTransform=null):SoundChannel
		{
			var result:SoundChannel = new SoundChannel();
			result = play(0,loops,sndTransform);
			return result;
		}
	}
}