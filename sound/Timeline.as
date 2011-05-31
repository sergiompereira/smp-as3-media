package com.smp.media.sound
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
	

	internal class  Timeline extends SoundInterfaceComponent
	{
		
		private var timer:Timer;
		private var width:Number;
		
		public function Timeline(graphic:MovieClip) {
			super(graphic);
			width = _graphic.width;
			//_graphic.buttonMode = true;
			
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, updateTimeline);
			timer.start();
			
		}
		
		protected function updateTimeline(evt:TimerEvent = null) {
			if(_soundOutput!=null){
				this._graphic.scaleX = _soundOutput.time / _soundOutput.length;
			}
		}
		
	}
	
}