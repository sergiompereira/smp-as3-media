package com.smp.media.sound
{
		
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	

	internal class  StopButton extends SoundInterfaceComponent
	{
		
		
		public function StopButton(graphic:MovieClip) {
			super(graphic);
			_graphic.buttonMode = true;
			_graphic.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_graphic.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			
		}
		
		private function onOver(evt:MouseEvent):void {
			_graphic.play();
		}
		
		private function onOut(evt:MouseEvent):void {
			_graphic.gotoAndStop(1);
		}
		
		override protected function onStop(evt:Event):void {
			
		}
	}
	
}