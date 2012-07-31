package com.smp.media.sound {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.smp.media.ICommand;
	
	
	internal class PlayheadSliderCommand implements ICommand {
		
		private var _receiver:ISoundOutput;
		private var _model:SoundModel;
		
		public function PlayheadSliderCommand(model:SoundModel) {
			_model = model;
			_model.addEventListener(SoundEvent.SOUND_CHANGED, onSoundChanged);
			_receiver = _model.activeSound;
		}
		
		protected function onSoundChanged(evt:Event):void{
			_receiver = _model.activeSound;
		}
		
		public function execute(evt:* = null):void 
		{
			_receiver.time = _model.getTime()*_receiver.length;
		}
		
	}
}