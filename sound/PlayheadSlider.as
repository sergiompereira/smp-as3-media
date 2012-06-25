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
	
	import com.smp.common.display.MovieClipUtilities;
	

	internal class  PlayheadSlider extends SoundInterfaceComponent
	{
		
		private var _width:Number;
		private var _slider:MovieClip;
		
		private var timer:Timer;
		
		
		public function PlayheadSlider(graphic:MovieClip, playbackWidth:Number) 
		{
			super(graphic);
			_width = playbackWidth;
			
			_graphic.buttonMode = true;
			_slider  = MovieClip(_graphic.getChildAt(_graphic.numChildren - 1));
			MovieClipUtilities.setDraggable(_slider, false, 0, 0, _width, 0);
			
			
			_slider.addEventListener("Drag", onSlide);
			
			_graphic.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			_graphic.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			_graphic.addEventListener(MouseEvent.DOUBLE_CLICK, onDobleClick);
			
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, updateTimeline);
			timer.start();
			
		}
		
		override public function handleInput(fnc:Function):void {
			super.handleInput(fnc);
		}
		
		protected function onSlide(evt:Event):void
		{
			
			if (_model != null) {
				_model.setTime(_slider.x / _width);	
			}
		}
		
		protected function onDown(evt:MouseEvent):void
		{
			timer.stop();
			_graphic.stage.addEventListener(MouseEvent.MOUSE_MOVE, updateHandler);
		}
		
		protected function onUp(evt:MouseEvent):void
		{
			timer.start();
			_graphic.stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateHandler);
		}
		
		protected function onDobleClick(evt:MouseEvent):void
		{
			_soundOutput.togglePause();
		}
		
		
		protected function updateHandler(evt:MouseEvent):void
		{
			_handlerFunction(this);
		}
		
		protected function updateTimeline(evt:TimerEvent = null) {
			if(_soundOutput!=null){
				_slider.x = _soundOutput.time / _soundOutput.length * _width;
			}
		}
		
		
	}
	
}