package com.smp.media.sound {
	
	import flash.events.Event;
	
	import com.smp.media.ICommand;
	
	
	internal class PlayPauseCommand implements ICommand {
		
		private var _model:SoundModel;
		private var _receiver:ISoundOutput;
		private var _fader:Boolean;
		
		public function PlayPauseCommand(model:SoundModel, fader:Boolean = false) {
			_model = model;
			_model.addEventListener(SoundEvent.SOUND_CHANGED, onSoundChanged);
			_receiver = _model.activeSound;
			_fader = fader;
		}
		
		protected function onSoundChanged(evt:Event):void{
			_receiver = _model.activeSound;
		}
		
		public function execute(evt:* = null):void {
			if (_receiver.playing) {

				if (_fader) {
					_receiver.fadeOut(1.5, true);
				} else {
					_receiver.togglePause();
				}
			} else {
				if (_fader) {
					_receiver.fadeIn(1.5);
				} else {
					_receiver.togglePause();
				}
			}
		}
		
	}
}