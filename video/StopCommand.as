package com.smp.media.video {
		
	import flash.events.Event;
	
	import com.smp.media.ICommand;
	
	
	public class StopCommand implements ICommand {
		
		private var _model:VideoModel;
		private var _receiver:IVideoOutput;
		
		
		public function StopCommand(model:VideoModel) {
			_model = model;
			_model.addEventListener(VideoEvent.VIDEO_CHANGED, onVideoChanged);
			_receiver = _model.activeVideo;
			
		}
		
		protected function onVideoChanged(evt:Event):void{
			_receiver = _model.activeVideo;
		}
		
		public function execute(evt:* = null):void {
			_receiver.stop();
		}
		
	}
}