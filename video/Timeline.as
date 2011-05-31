package com.smp.media.video
{
	/*
	 * graphic é um MovieClip no palco
	 * 
	 */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	

	public class  Timeline extends VideoInterfaceComponent
	{
		
		private var timer:Timer;
		private var width:Number;
		
		public function Timeline(graphic:MovieClip) {
			super(graphic);
			width = _graphic.width;
			//_graphic.buttonMode = true;
			_graphic.mouseEnabled = false;
			
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, updateTimeline);
			timer.start();
			
		}
		
		protected function updateTimeline(evt:TimerEvent = null) {
			
			if(_videoOutput.length > 0){
				this._graphic.scaleX = _videoOutput.time / _videoOutput.length;
			}
			
		}
		
	}
	
}