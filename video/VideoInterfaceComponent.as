package com.smp.media.video {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.errors.IllegalOperationError;
	
	import com.smp.media.InterfaceComponent;
	
	//ABSTRACT CLASS
	public class  VideoInterfaceComponent extends InterfaceComponent
	{
		protected var _videoOutput:IVideoOutput;
		protected var _model:VideoModel;
		protected var _handlerFunction:Function;
		
		
		public function VideoInterfaceComponent(graphic:MovieClip) {
			super(graphic)
			
		}
		
		public function init(model:VideoModel = null) {
		
			if(model!=null){
				_model = model;
				_model.addEventListener(VideoEvent.VIDEO_CHANGED, onVideoChanged);
				_videoOutput = _model.activeVideo;
			}
			
			
			onPlayChanged();
			onVolumeChanged();
			
			handleVideoEvents();
			
		}
		
		protected function onVideoChanged(evt:Event):void {
			_videoOutput.removeEventListener(VideoEvent.PLAY_CHANGED, onPlayChanged);
			_videoOutput.removeEventListener(VideoEvent.START, onPlayChanged);
			_videoOutput.removeEventListener(VideoEvent.END, onStop);
			_videoOutput = _model.activeVideo;
			_videoOutput.addEventListener(VideoEvent.PLAY_CHANGED, onPlayChanged);
			_videoOutput.addEventListener(VideoEvent.START, onPlayChanged);
			_videoOutput.addEventListener(VideoEvent.END, onStop);
		}
		
		protected function handleVideoEvents():void {
			
			_videoOutput.addEventListener(VideoEvent.PLAY_CHANGED, onPlayChanged);
			_videoOutput.addEventListener(VideoEvent.START, onPlayChanged);
			_videoOutput.addEventListener(VideoEvent.END, onStop);
			
			if (_model != null) {
				_model.addEventListener(VideoEvent.VOLUME_CHANGED, onVolumeChanged);
			}
			
			
		}
		
		protected function onPlayChanged(evt:VideoEvent = null):void {
			//throw new IllegalOperationError("Abstract method: must be overriden");
		}
		
		protected function onStop(evt:VideoEvent):void {
			//throw new IllegalOperationError("Abstract method: must be overriden");
		}
		
		protected function onVolumeChanged(evt:Event = null):void {
			//throw new IllegalOperationError("Abstract method: must be overriden");
		}
		
		override public function handleMouseInput(evt:String, fnc:Function):void {
			_handlerFunction = fnc;
			_graphic.addEventListener(evt, fnc);
		}
		
		override public function handleInput(fnc:Function):void {
			_handlerFunction = fnc;
			
		}
		
	}
	
}