package com.smp.media.video
{
		
	import flash.display.MovieClip;
	import flash.events.Event;
	

	public class  PlayPauseButton extends VideoInterfaceComponent
	{
		
		
		public function PlayPauseButton(graphic:MovieClip) {
			super(graphic);
			_graphic.buttonMode = true;
			
		}
		
		override protected function onVideoChanged(evt:Event):void {
			
			super.onVideoChanged(evt);
			
			onPlayChanged();
			
		}
		
		override protected function onPlayChanged(evt:VideoEvent = null):void {
			
			if (_videoOutput.playing) {
				
				_graphic.gotoAndPlay("pause");
			}else {
				
				_graphic.gotoAndPlay("play");
			}
			
		}
		
		override protected function onStop(evt:VideoEvent):void {
			
			_graphic.gotoAndPlay("play");
		}
	}
	
}