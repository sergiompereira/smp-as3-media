package com.smp.media.sound
{
	/*
	 * graphic é um MovieClip no palco
	 * 
	 */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	

	internal class  PlayheadBar extends SoundInterfaceComponent
	{
		
		private var _width:Number;
		
		
		public function PlayheadBar(graphic:MovieClip) {
			super(graphic);
			_width = _graphic.width;
			_graphic.buttonMode = true;
			
			_graphic.addEventListener(MouseEvent.MOUSE_UP, onUp);
			
		}
		
		protected function onUp(evt:MouseEvent):void
		{
			if (_model != null) {
				_model.setTime(evt.localX / _width);	
			}
		}
		
		
	}
	
}