package com.smp.media.sound
{
		
	import flash.display.MovieClip;
	import flash.events.Event;

	internal class  PlayPauseButton extends SoundInterfaceComponent
	{
		
		
		public function PlayPauseButton(graphic:MovieClip) {
			super(graphic);
			_graphic.buttonMode = true;
			
		}
		
		override protected function onSoundChanged(evt:Event):void {
			super.onSoundChanged(evt);
			onPlayChanged();
		}
		
		
		override protected function onPlayChanged(evt:SoundEvent = null):void 
		{
			if(_soundOutput != null){
				if (_soundOutput.playing) {
					_graphic.gotoAndPlay("pause");
				}else {
					_graphic.gotoAndPlay("play");
				}
			}
			
		}
		
	}
	
}