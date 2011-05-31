package com.smp.media.video
{
	/*
	 * graphic é um MovieClip no palco
	 * deve conter dois frames com labels over e out
	 */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	

	public class  StopButton extends VideoInterfaceComponent
	{
		
		
		public function StopButton(graphic:MovieClip) {
			super(graphic);
			_graphic.buttonMode = true;
			_graphic.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_graphic.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			
		}
		
		private function onOver(evt:MouseEvent):void {
			_graphic.gotoAndPlay("over");
		}
		
		private function onOut(evt:MouseEvent):void {
			_graphic.gotoAndPlay("out");
		}
		
		override protected function onStop(evt:VideoEvent):void {
			
		}
	}
	
}