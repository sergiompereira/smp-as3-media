package com.smp.media.video
{
	/*
	 * graphic é um MovieClip no palco
	 * deve conter dois frames com labels on e off
	 */
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	public class  VolumeOnOff extends VideoInterfaceComponent
	{
		
		protected var _state:Boolean;
		
		public function VolumeOnOff(graphic:MovieClip) {
			super(graphic);
			_state = false;
			_graphic.buttonMode = true;
			_graphic.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		protected function onUp(evt:MouseEvent):void
		{
			
			if (_model != null) {
				switch(_state) {
					case true:
						_model.setVolume(_model.getMaxVolume());
						break;
					case false:
						_model.setVolume(0);
						break;
				}	
			}
		}
		
		override protected function onVolumeChanged(evt:Event = null):void {
			
			if (_model.getVolume() > 0)
			{
				_graphic.gotoAndStop("on");
				_state = false;
			}else {
				_graphic.gotoAndStop("off");
				_state = true;
			}
			
			
		}
	}
	
}