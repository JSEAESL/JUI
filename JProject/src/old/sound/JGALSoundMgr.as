package old.sound
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.text.engine.Kerning;
	import flash.utils.Dictionary;
	
	import kokoro.jbox.one.Book;
	import jlib.sound.JSoundEntity;

	public class JGALSoundMgr
	{
		private static var _instance:JGALSoundMgr;
		public static function get instance():void
		{
			if(_instance == null)
			{
				_instance = new JGALSoundMgr(new instanceClass())
			}
			return _instance;
		}
		
		private var _sound:JGALSoundEntitly;
		private var soundDic:Dictionary;
		private var soundChannelDic:Dictionary;
		public function JGALSoundMgr(insClass:instanceClass)
		{
			soundDic = new Dictionary();
			soundChannelDic = new Dictionary();
		}
		
		public function dispose():void
		{
			_instance = null;
		}
		
		
		public function hasSound(key:String):Boolean
		{
			if(soundDic[key])
			{
				return true;
			}
			return false;	
		}
		
		public function delSound(key:String):void
		{
			soundDic[key] = null;
			delete soundDic[key];
		}
		
		public function getJGALSoundEntity(key:String):JGALSoundEntitly
		{
			if( hasSound(key) )
			{
				return soundDic[key];
			}
			return null
		}
		
		public function registPath(key:String, path:String, buffTime:int, checkPolicyFile:Boolean = false):Boolean
		{
			if( hasSound(key) )
			{
				return false;
			}
			
			var sound:JGALSoundEntitly = new JGALSoundEntitly(key)
			sound.initializedParms(path,new SoundLoaderContext(buffTime,checkPolicyFile));
			soundDic[key] = sound;
			return true;
			
		}
		
		public function regist(key:String, sound:Sound):Boolean
		{
			if(sound == null)
			{
				_sound = getJGALSoundEntity(key);
				if(_sound )
				{
					_sound.stop();
				}
				delSound(key);
				return true
			}
			
			if(soundDic[key])
			{
				return false;
			}
			_sound = new JGALSoundEntitly(key,sound)
			soundDic[key] = _sound;
			return true;
		}
		
		public function play(key:String,volume:int = 1,statTime:int = 0,loop:int = 1,soundTradnsform:SoundTransform = null):JGALSoundEntitly
		{
			if(hasSound(key))
			{
				var sound:JGALSoundEntitly = getJGALSoundEntity(key);
				sound.play(statTime,loop,soundTradnsform);
				sound.volume = volume;
				return sound;
			}
			return null;
			
		}
		
		
		public function playVoice():void
		{
			
		}
		
		
		
		public function pause(key:String):void
		{
			if(hasSound(key))
			{
				var sound:JGALSoundEntitly = getJGALSoundEntity(key);
				sound.pause();
			}
			
		}
		
		public function stop(key:String):void
		{
			if(hasSound(key))
			{
				var sound:JGALSoundEntitly = getJGALSoundEntity(key);
				sound.stop();
			}
		}
		
		public function getVolume(key:String):Number
		{
			
			if (hasSound(key))
			{
				var dim:JSoundEntity = getJGALSoundEntity(key);
				return dim.volume;
			}
			
			return -1;
		}
		
		public function setVolume(key:String, value:Number):void
		{
			
			if (hasSound((key))
			{
				var dim:JSoundEntity = getJGALSoundEntity(key);
				dim.volume = value;
			}
			
		}
		
		
		
		
		
	}
}
class instanceClass{}