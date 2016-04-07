package old.example
{
	import flash.system.Capabilities;

	public class CapabilitiesExample
	{
		public function CapabilitiesExample()
		{
			showCapabilities();
		}
		
		
		public  static function showCapabilities():void {
			//指定对用户的摄像头和麦克风的访问是已经通过管理方式禁止 (true) 还是允许 (false)。
			trace("avHardwareDisable: " + Capabilities.avHardwareDisable)
			trace("hasAccessibility: " + Capabilities.hasAccessibility);
			//指定播放器是否在具有音频功能的系统上运行。 
			trace("hasAudio: " + Capabilities.hasAudio);
			//指定播放器能 (true) 还是不能 (false) 对音频流（如来自麦克风的音频流）进行编码。
			trace("hasAudioEncoder: " + Capabilities.hasAudioEncoder);
			trace("hasEmbeddedVideo: " + Capabilities.hasEmbeddedVideo);
			//指定播放器是在具有 (true) MP3 解码器的系统上运行，还是在没有 (false)的系统上运行。
			trace("hasMP3: " + Capabilities.hasMP3);
			//指定播放器是在支持 (true) 打印的系统上运行，还是在不支持 (false) 打印的系统上运行。
			trace("hasPrinting: " + Capabilities.hasPrinting);
			trace("hasScreenBroadcast: " + Capabilities.hasScreenBroadcast);
			trace("hasScreenPlayback: " + Capabilities.hasScreenPlayback);
			trace("hasStreamingAudio: " + Capabilities.hasStreamingAudio);
			trace("hasVideoEncoder: " + Capabilities.hasVideoEncoder);
			trace("isDebugger: " + Capabilities.isDebugger);
			//指定运行播放器的系统的语言代码。
			trace("language: " + Capabilities.language);
			trace("localFileReadDisable: " + Capabilities.localFileReadDisable);
			trace("manufacturer: " + Capabilities.manufacturer);
			//指定当前的操作系统。 
			trace("os: " + Capabilities.os);
			trace("pixelAspectRatio: " + Capabilities.pixelAspectRatio);
			trace("playerType: " + Capabilities.playerType);
			trace("screenColor: " + Capabilities.screenColor);
			trace("screenDPI: " + Capabilities.screenDPI);
			trace("screenResolutionX: " + Capabilities.screenResolutionX);//用户屏幕分辨率
			trace("screenResolutionY: " + Capabilities.screenResolutionY);
			trace("serverString: " + Capabilities.serverString);
			//指定 Flash Player 平台和版本信息。
			trace("version: " + Capabilities.version);
		}
	}
}