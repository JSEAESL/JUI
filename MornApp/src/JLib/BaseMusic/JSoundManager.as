package JLib.BaseMusic
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class JSoundManager
	{
		private static var _instance:JSoundManager;
		
		public static function getInstance():JSoundManager
		{
			if(null == _instance)
			{
				_instance = new JSoundManager()
			}
			return _instance;
		}
		
		private var sondDic:Dictionary;
		private var bgmSound:JSound;
		private var bgmSoundChannel:SoundChannel;
		private var bgmSoundTransfrom:SoundTransform;
		
		public function JSoundManager()
		{
			sondDic = new Dictionary();
		}
		
		public function playBgm(key:String):void
		{
			selectNowBgm(key)
			playNowBgm();
		}
		
		public function selectNowBgm(key:String):void
		{
			bgmSound = getSound(key)
			stopBgm()
		}
		
		public function playNowBgm():void
		{
			if(bgmSound)
			{
			stopBgm()
			bgmSoundChannel = bgmSound.creatSoundChannel(0,999,bgmSoundTransfrom);		
			}
		}
		
		public function stopBgm():void
		{
			if(bgmSoundChannel)
			{
			bgmSoundTransfrom = bgmSoundChannel.soundTransform;
			bgmSoundChannel.stop()
			}
		}
		
		private function getSound(key:String):JSound
		{
			var result:JSound
			if(null == sondDic[key])
			{
				sondDic[key] = JSound.creatSound( keyToUrl(key) )
			}
			result = sondDic[key] 
			
			return result;
		}
		
		private function keyToUrl(key:String):String
		{
			var result:String
			
			return result;
		}
		
		public function getBgmSoundChannel():SoundChannel
		{
			return bgmSoundChannel;
		}
		
		public function saveCaseSound(key:String,byteData:ByteArray):Boolean
		{
			if(null == sondDic[key] )
			{
				sondDic[key] =  JSound.creatSoundByteArray(byteData)
				return true
			}
			return false
		}
	
	}
}