﻿package com.smp.media.video {
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import com.smp.media.ICommand;
	
	
	public class PlayheadSliderCommand implements ICommand {
		
		private var _receiver:IVideoOutput;
		private var _model:VideoModel;
		
		public function PlayheadSliderCommand(model:VideoModel) {
			
			_model = model;
			_model.addEventListener(VideoEvent.VIDEO_CHANGED, onVideoChanged);
			_receiver = _model.activeVideo;
		}
		
		protected function onVideoChanged(evt:Event):void{
			_receiver = _model.activeVideo;
		}
		
		public function execute(evt:* = null):void 
		{
			_receiver.time = _model.getTime()*_receiver.length;
		}
		
	}
}