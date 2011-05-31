package com.smp.media.sound {
		
	import flash.events.Event;
	
	import com.smp.media.ICommand;
	
	
	internal class StopCommand implements ICommand {
		
		private var _model:SoundModel;
		private var _receiver:ISoundOutput;
		
		
		public function StopCommand(model:SoundModel) {
			
			_model = model;
			_model.addEventListener(SoundModel.SOUND_CHANGED, onSoundChanged);
			_receiver = _model.activeSound;
			
			
		}
		
		protected function onSoundChanged(evt:Event):void{
			_receiver = _model.activeSound;
		}
		
		public function execute(evt:* = null):void {
			_receiver.stop();
		}
		
	}
}