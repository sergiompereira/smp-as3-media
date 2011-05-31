package com.smp.media.sound
{
		
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	internal class  VolumeButton extends SoundInterfaceComponent
	{
				
		private var _numSteps:uint;
		
		public function VolumeButton(graphic:MovieClip, numSteps:uint = 5) {
			super(graphic);
			_numSteps = numSteps;
			
			for (var i:uint = 1; i <= _numSteps; i++ ) {
				_graphic["step"+i].buttonMode = true;
			}
		}
		
		override public function handleMouseInput(evt:String, fnc:Function):void {
			
			for (var i:uint = 1; i <= _numSteps; i++ ) {
				_graphic["step"+i].addEventListener(evt, handleMouseEvent);	
			}
			_graphic.addEventListener(evt, fnc);
		}
		
		private function handleMouseEvent(evt:MouseEvent):void {
			
			var evtname:String = (evt.target as MovieClip).name;
			var index:Number = Number(evtname.substr( -1, 1));
				
			_model.setVolume(1 / (_numSteps - 1) * (index - 1));
			//trace("model" + 1 / (_numSteps - 1) * (index - 1));
		
			
		}
		
		
		override protected function onVolumeChanged(evt:Event = null):void {
			var i:uint;
			
			for (i = 1; i <= _numSteps; i++) {
				_graphic["step" + i].gotoAndStop("off");
			}
			for (i = 1; i <= Math.ceil((_model.getVolume() * (_numSteps-1) + 1)); i++) {
				_graphic["step" + i].gotoAndStop("on");
			}
		}
	}
	
}