package com.smp.media.video{

	import flash.display.Sprite;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;
	import flash.media.SoundTransform;
	import flash.events.*;
	import flash.utils.Timer; 


	public class VideoObject extends Sprite implements IVideoOutput{

		private var _verbose:Boolean;
		private var _conn:NetConnection;
		private var _streamer:NetStream;
		private var _video:Video;
		private var _streamerInfo:Object;
		private var _totalLength:Number;
		private var _timer:Timer;
		private var _timerInfo:Timer;
		private var _bytesLoaded:Number = 0;
		private var _bytesTotal:Number = 0;
		private var _loadedPercent:int;
		private var _loaded:Boolean = false;
		private var _file:String;
		private var _transf:SoundTransform = new SoundTransform();
		private var _volume:Number;
		private var _playing:Boolean = true;
		private var _loop:Boolean = false;
		
		private var _rescalable:Boolean = false;
		private var _registeredSize:Array = new Array(0,0);
		private var _rescaleValues:Array = new Array(2);
		private var _setSourceSize:Boolean = false;
		private var _centerVideo:Array = new Array(2);
		

		public function VideoObject() {
			//create vídeo
			_conn=new NetConnection  ;
			//_conn.connect("http://80.172.230.70:8080/");
			_conn.connect(null);

			createStream();
			//_conn.addEventListener(NetStatusEvent.NET_STATUS, connectionOnStatus);

		}
		private function connectionOnStatus(evt:NetStatusEvent):void {
			//private function connectionOnStatus():void {
			trace("status");

			if (evt.info.code == "NetConnection.Connect.Success") {
				trace("dopo status");
				createStream();

			}
		}
		private function createStream() {
			
			_streamer=new NetStream(_conn);
			_streamerInfo=new Object  ;
			_streamerInfo.onMetaData=OnMetaData;
			_streamer.client=_streamerInfo;
			_streamer.bufferTime=1;
			
			//streamer events
			_streamer.addEventListener(NetStatusEvent.NET_STATUS,onStatus,false,0,true);

			_video=new Video();
			_video.attachNetStream(_streamer);


			addChild(_video);

			_timerInfo = new Timer(50);
			_timerInfo.addEventListener(TimerEvent.TIMER, onTimerInfo, false, 0, true);
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, onProgress, false, 0, true);
			
			//dispatchEvent(new Event("StreamReady"));
		}
		public function load(file:String, loop:Boolean = false, autoplay:Boolean = true, verbose:Boolean = true):void {
			
			_file = file;
			_loop = loop;
			_playing = autoplay;
			_verbose = verbose;
			_rescalable = false;
			
			_streamer.seek(0);
			_streamer.play(file);

			
			_timer.start();
			_timerInfo.start();
			
			dispatchEvent(new VideoEvent(VideoEvent.PLAY_CHANGED));

		}
		
		private function OnMetaData(obj:Object) {
			_totalLength = obj.duration;
		
		}
		

		private function onStatus(evt:NetStatusEvent) {
			
			if (_verbose) { trace(evt.info.code); }
	
			if (evt.info.code == "NetStream.Play.Start") {
				
					if (!_playing) {
						stop();
					}
					
					dispatchEvent(new VideoEvent(VideoEvent.START));
					
				
			}
			if (evt.info.code == "NetStream.Play.Stop") {
				//_streamer.seek(0);
				
				dispatchEvent(new VideoEvent(VideoEvent.END));
				if (_loop) {
					this.init();
				}else {
					dispatchEvent(new VideoEvent(VideoEvent.PLAY_CHANGED));
				}
			}
		}
		
		private function onTimerInfo(evt:TimerEvent):void {
			//trace(_video.videoHeight + " // " + _video.videoWidth)
			
			
			
			//Avalia quando já existem dados para fazer um rescale do vídeo
			if (_video.videoWidth > 0 && _video.videoHeight > 0) {
				
				
				
				if(_registeredSize[0]!=_video.videoWidth || _registeredSize[1]!=_video.videoHeight){
					_registeredSize[0] = _video.videoWidth;
					_registeredSize[1] = _video.videoHeight;
					
					_rescalable = true;
					
					if (_rescaleValues.length > 0) {
						rescale(_rescaleValues[0], _rescaleValues[1])
					}
					if (_setSourceSize) {
						if(_centerVideo.length>0){
							setSourceSize(_centerVideo);
							_centerVideo = new Array();
						}else {
							setSourceSize();
						}
						_setSourceSize = false;
					}
					
				}
				
				_timerInfo.removeEventListener(TimerEvent.TIMER, onTimerInfo);

			}
			
		}
		
		public function get streamer():NetStream 
		{
			return _streamer;
		}
		
		public function get video():Video 
		{
			return _video;
		}
		
		private function onProgress(evt:TimerEvent):void
		{

			_loadedPercent=Math.round(_streamer.bytesLoaded / _streamer.bytesTotal * 100);
			_bytesLoaded=_streamer.bytesLoaded;
			_bytesTotal = _streamer.bytesTotal;
			
			if (_bytesLoaded >= _bytesTotal) {
				
				_timer.removeEventListener(TimerEvent.TIMER, onProgress);
				_timer.reset();
				_loaded = true;
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,_bytesLoaded,_bytesTotal));
		}
		
		public function get loadPercent():int 
		{
			return _loadedPercent;
		}
		
		public function get loaded():Boolean {
			return _loaded;
		}
		
		public function set length(value:Number):void {
			_totalLength = value;
		}
		
		public function get length():Number 
		{
			
			if(isNaN(_totalLength)) {
				return streamer.time;
			}
			
			return _totalLength;
		}
		
		public function get fpSecond():Number
		{
			return _streamer.currentFPS;
		}
		
		
		public function get time():Number
		{
			return _streamer.time;
		}
		
		public function set time(value:Number):void
		{
			_streamer.seek(value);
		}
		
		public function set videoWidth(value:Number)
		{
			_video.width = value;
		}
		
		public function set videoHeight(value:Number)
		{
			_video.height = value;
		}
		
		public function get videoWidth():Number
		{
			return _video.width;
		}
		
		public function get videoHeight():Number
		{
			return _video.height;
		}
		
		public function setSize(width:Number, height:Number):void
		{
			_video.width = width;
			_video.height = height;
		}
		
		public function rescale(width:Number = 0, height:Number = 0):void {
			
			if (_rescalable == true) {
				
				if(width > 0){
					_video.width = width;
					_video.height = _video.videoHeight / _video.videoWidth * _video.width;
				}else if(height > 0){
					_video.height = height;
					_video.width = _video.videoWidth / _video.videoHeight * _video.height;
				}
				
				_rescaleValues =  new Array();
				
			}else {
				_rescaleValues =  new Array(width, height);
			}
		}
		
		public function setSourceSize(centerVideo:Array = null):void {
			
			if (_rescalable == true) {
				_video.width = _video.videoWidth;
				_video.height = _video.videoHeight;
				if (centerVideo != null) {
					this.x = (centerVideo[0] - this.width) / 2;
					this.y = (centerVideo[1] - this.height) / 2;
				}
				
			}else {
				_centerVideo = centerVideo;
				_setSourceSize = true;
			}
		}
		
		public function init():void{
			_streamer.seek(0);
			_streamer.play(_file);
			_playing = true;
			
			dispatchEvent(new VideoEvent(VideoEvent.PLAY_CHANGED));
		}
		
		public function stop():void 
		{
			_loop = false;
			
			if (_playing) {
				togglePause();
			}
			_streamer.seek(0);
			_streamer.pause();
			
			dispatchEvent(new VideoEvent(VideoEvent.PLAY_CHANGED));
		}
		
		public function clear():void{
			_streamer.close();
			_video.clear();
		}
		
		public function togglePause():void {
			_streamer.togglePause();
			_playing = !_playing;
			
			dispatchEvent(new VideoEvent(VideoEvent.PLAY_CHANGED));
		}
		
		public function get playing():Boolean{
			return _playing;
		}
		
		public function set volume(value:Number):void {
			_volume = value;
			_transf.volume = _volume;
			_streamer.soundTransform = _transf;
		}
		
		public function get volume():Number {
			return _streamer.soundTransform.volume;
		}
		
		public function set loop(value:Boolean):void{
			_loop = value;
		}
		
		public function get loop():Boolean{
			return _loop;
		}
		
	}
}