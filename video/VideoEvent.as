package com.smp.media.video
{

	import flash.events.Event;
	
	public class  VideoEvent extends Event
	{
		public static const PLAY_CHANGED:String = "PlayChanged";
		public static const END:String = "End";
		public static const START:String = "Start";
		public static const VOLUME_CHANGED:String = "VolumeChanged";
		public static const TIME_CHANGED:String = "TimeChanged";
		public static const VIDEO_CHANGED:String = "VideoChanged";
		public static const STREAM_ERROR:String = "StreamError";
		
		public function VideoEvent(type:String):void {
			
			super(type);
		}
		
	}
	
}