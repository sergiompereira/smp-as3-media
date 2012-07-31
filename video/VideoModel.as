package com.smp.media.video {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.smp.media.IMediaModel;
	
	
	public class VideoModel extends EventDispatcher implements IMediaModel {
		
		
		protected var _volume:Number;
		protected var _time:Number;
		protected var _maxVolume:Number = 1;
		
		protected var _videoList:Array;
		protected var _activeId:int = 0;
		protected var _videoObject:IVideoOutput;
		
		public function VideoModel() {
			
		}
		
		public function setVolume(value:Number):void {
			trace("volume set"+ value);
			_volume = value;
			dispatchEvent(new VideoEvent(VideoEvent.VOLUME_CHANGED));
		}
	
		public function getVolume():Number {
			return _volume;
		}
		
		public function setTime(value:Number):void {
			_time = value;
			dispatchEvent(new VideoEvent(VideoEvent.TIME_CHANGED));
		}
	
		public function getTime():Number {
			return _time;
		}
		
		public function setMaxVolume(value:Number):void {
			trace("maxvolume set"+ value);
			_maxVolume = value;
		}
		
		public function getMaxVolume():Number {
			return _maxVolume;
		}
		
		public function setMediaList(list:Array):void {
			_videoList = list;
		}
		
		public function getListLength():uint {
			return _videoList.length;
		}
		
		public function getMediaFile(i:uint):String {
			_activeId = i;
			return _videoList[_activeId];
		}
		
		public function get activeId():int {
			return _activeId;
		}
		
		public function set activeVideo(video:IVideoOutput):void {
			if (_videoObject) _videoObject.removeEventListener(VideoEvent.PLAY_CHANGED, onPlayChanged);
			_videoObject = video;
			_videoObject.addEventListener(VideoEvent.PLAY_CHANGED, onPlayChanged);			
			dispatchEvent(new Event(VideoEvent.VIDEO_CHANGED));
		}
		
		public function get activeVideo():IVideoOutput {
			return _videoObject;
		}
		
		public function next():int {
			if (_activeId < _videoList.length -1) {
				_activeId++;
			}else {
				_activeId = 0;
			}
			return _activeId;
		}
		public function previous():int {
			if (_activeId > 0) {
				_activeId--;
			}else {
				_activeId = _videoList.length - 1;
			}
			return _activeId;
		}
		private function onPlayChanged(evt:VideoEvent):void {
			dispatchEvent(new VideoEvent(VideoEvent.PLAY_CHANGED));
		}
	}
}