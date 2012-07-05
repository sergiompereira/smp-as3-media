package com.smp.media.sound {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.smp.media.IMediaModel;
	
	
	internal class SoundModel extends EventDispatcher implements IMediaModel{
		
		public static const VOLUME_CHANGED:String = "VolumeChanged";
		public static const TIME_CHANGED:String = "TimeChanged";
		public static const SOUND_CHANGED:String = "SoundChanged";
		
		protected var _volume:Number;
		protected var _time:Number;
		protected var _maxVolume:Number;
		protected var _soundList:Array;
		protected var _soundObject:ISoundOutput;
		protected var _activeId:int = 0;
		
		
		public function SoundModel() {
			
		}
		
		public function setVolume(value:Number):void {
			_volume = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
	
		public function getVolume():Number {
			return _volume;
		}
		
		public function setMaxVolume(value:Number):void {
			_maxVolume = value;
		}
		
		public function getMaxVolume():Number {
			return _maxVolume;
		}
		
		
		public function setTime(value:Number):void
		{
			_time = value;
		}
	
		public function getTime():Number
		{
			return _time;
		}
		
		public function setMediaList(list:Array):void {
			_soundList = list;
		}
		
		public function getListLength():uint {
			return _soundList.length;
		}
		
		public function getMediaFile(i:uint):String {
			_activeId = i;
			return _soundList[_activeId];
		}
		
		public function get activeId():int {
			return _activeId;
		}
		
		public function set activeSound(sound:ISoundOutput):void {
			if(_soundObject) _soundObject.removeEventListener(SoundEvent.PLAY_CHANGED, onPlayChanged);
			_soundObject = sound;
			_soundObject.addEventListener(SoundEvent.PLAY_CHANGED, onPlayChanged);
			dispatchEvent(new Event(SOUND_CHANGED));
		}
		
		public function get activeSound():ISoundOutput {
			return _soundObject;
		}
		
		public function next():int {
			if (_activeId < _soundList.length -1) {
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
				_activeId = _soundList.length - 1;
			}
			return _activeId;
		}
		
		private function onPlayChanged(evt:SoundEvent):void {
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
		}
	}
}