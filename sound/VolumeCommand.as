package com.smp.media.sound {
		
	import flash.events.Event;
	
	import com.smp.media.ICommand;
	
	
	internal class VolumeCommand implements ICommand {
		
		private var _receiver:ISoundOutput;	
		private var _model:SoundModel;
		
		public function VolumeCommand(model:SoundModel) {
			_model = model;
			_model.addEventListener(SoundEvent.SOUND_CHANGED, onSoundChanged);
			_receiver = _model.activeSound;
			
		}
		
		protected function onSoundChanged(evt:Event):void{
			_receiver = _model.activeSound;
		}
		
		public function execute(evt:* = null):void {
			trace(_model.getVolume())
			_receiver.volume = _model.getVolume();
		}
	
		
	}
}