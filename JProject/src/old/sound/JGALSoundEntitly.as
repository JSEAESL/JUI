package old.sound
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import jlib.astar.Aa;
	
	public class JGALSoundEntitly extends EventDispatcher
	{
		private var _key:String;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		
		private var _loops:int;
		private var _lastLoops:int;
		
		private var _position:int;
		private var _volume:int;
		
		private var _initialized:Boolean = false;
		private var _pause:Boolean;
		
		
		private var _url:String;
		private var _soundLoaderContext:SoundLoaderContext;
		public function JGALSoundEntitly(key:int, sound:Sound = new Sound())
		{
			_key = key;
			_sound = sound;
			if(sound.url)
			{
				_initialized = true;
			}
		}
		
	
		
		public function initializedParms(url:String, context:SoundLoaderContext):void
		{
			_url = url;
			_soundLoaderContext = context;
		}
		public function load(url:String, cotext:SoundLoaderContext):void
		{
			_sound.load(new URLRequest(url),cotext);
			_initialized = true
		}
		
		public function getNewSoundChannel(statTime:int = 0, loops:int = 0, sndTranform:SoundTransform = null):SoundChannel
		{
			return _sound.play(statTime, loops, sndTranform);
		}
		
		public function play(statTime:int = 0, loops:int = 0, sndTranform:SoundTransform = null):void
		{
			_loops = loops
			
			if(_soundChannel)
			{
				_soundChannel.stop();
			}
			
			if(_initialized)
			{
				load(_url,_soundLoaderContext);
			}
			try
			{
				_soundChannel = _sound.play(statTime, loops, sndTranform);
			}
			catch(e:Error)
			{
				trace(e);
				return 
			}
			
			if(_soundChannel == null)
			{
				return
			}
			_soundChannel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
			
			_pause = false;
		}
		
		private function onSoundComplete(e:Event):void
		{
			_lastLoops--
			
			if(_lastLoops >=0 )
			{
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
				_soundChannel.stop();
				this.dispatchEvent(e.clone());
			}
		}
		
		public function stop():void
		{
			if(_soundChannel == false)
			{
				return 
			}
			
			_pause=false;
			_soundChannel.stop();
			_position = _soundChannel.position;
			
			
		}
		
		public function pause():void
		{
			if(_soundChannel == false)
			{
				return 
			}
			
			if(_pause)
			{
				_pause = false;
				_soundChannel.stop();
				_position=_soundChannel.position;
			}else
			{
				_soundChannel.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
				_soundChannel = _sound.play(_position,_loops,_soundChannel.soundTransform);
				_soundChannel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
			}
			
		}
		

		
		
		public function get loops():int
		{
			return _loops;
		}
		
		public function set loops(value:int):void
		{
			 _lastLoops = _loops = value;
		}
		
		public function get volume():int
		{
			if(_soundChannel == null)
			{
				return -1;
			}
			return _soundChannel.soundTransform.volume;
		}
		
		public function set volume(value:int):void
		{
			if(_soundChannel == null)
			{
				return -1;
			}
			var sndTrans:SoundTransform = new SoundTransform;
			sndTrans.volume = value;
			_soundChannel.soundTransform = sndTrans;
		}
		
		public function get key():int
		{
			return _key;
		}
		
		//代理sound;
		public function close():void
		{
			_sound.close();
		}
		
		
		public function length():uint
		{
			return _sound.length;
		}
		
		public function get id3():ID3Info
		{
			return _sound.id3;
		}
		
		public function bytesLoaded():uint
		{
			return _sound.bytesLoaded;
		}
		
		public function bytesTotal():uint
		{
			return _sound.bytesTotal;
		}
		public function get isBuffering():Boolean
		{
			return _sound.isBuffering;
		}
		
		public function get url():String
		{
			return _sound.url;
		}
		
		
		//代理soundChannel;
		public function get position():Number
		{
			if (_soundChannel)
				return _soundChannel.position;
			return -1;
		}
		
		public function get soundTransform():SoundTransform
		{
			if (_soundChannel == null)
			{
				return null;
			}
			return _soundChannel.soundTransform;
		}
		
		public function get leftPeak():Number
		{
			if (_soundChannel == null)
			{
				return 0;
			}
			return _soundChannel.leftPeak;
		}
		
		public function get rightPeak():Number
		{
			if (_soundChannel == null)
			{
				return 0;
			}
			return _soundChannel.rightPeak;
		}
		
		
		
	}
}