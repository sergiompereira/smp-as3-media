package com.smp.media.sound {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.errors.IllegalOperationError;
	
	import com.smp.media.InterfaceComponent;
	
	//ABSTRACT CLASS
	internal class  SoundInterfaceComponent extends InterfaceComponent
	{
		protected var _soundOutput:ISoundOutput;
		protected var _model:SoundModel;
		protected var _handlerFunction:Function;
		
		
		public function SoundInterfaceComponent(graphic:MovieClip) {
			super(graphic)
			
		}
		
		public function init(model:SoundModel = null) {
			if(model!=null){
				_model = model;
				_model.addEventListener(SoundModel.SOUND_CHANGED, onSoundChanged);
				_soundOutput = _model.activeSound;
			}
			
			onPlayChanged();
			
			handleSoundEvents();
		}
		
		protected function onSoundChanged(evt:Event):void {
			_soundOutput.removeEventListener(SoundEvent.PLAY_CHANGED, onPlayChanged);
			_soundOutput.removeEventListener(Event.SOUND_COMPLETE, onStop);
			_soundOutput = _model.activeSound;
			_soundOutput.addEventListener(SoundEvent.PLAY_CHANGED, onPlayChanged);
			_soundOutput.addEventListener(Event.SOUND_COMPLETE, onStop);
		}
		
		protected function handleSoundEvents():void {
			
			if(_soundOutput != null){
				_soundOutput.addEventListener(SoundEvent.PLAY_CHANGED, onPlayChanged);
				_soundOutput.addEventListener(Event.SOUND_COMPLETE, onStop);
				
				if (_model != null) {
					
					_model.addEventListener(Event.CHANGE, onVolumeChanged);
				}
			}
			
			
		}
		
		protected function onPlayChanged(evt:SoundEvent  = null):void {
			//throw new IllegalOperationError("Abstract method: must be overriden");
		}
		
		protected function onStop(evt:Event):void {
			//throw new IllegalOperationError("Abstract method: must be overriden");
		}
		
		protected function onVolumeChanged(evt:Event = null):void {
			//throw new IllegalOperationError("Abstract method: must be overriden");
		}
		
		override public function handleMouseInput(evt:String, fnc:Function):void {
			_handlerFunction = fnc;
			_graphic.addEventListener(evt, fnc);
		}
		
		override public function handleInput(fnc:Function):void {
			_handlerFunction = fnc;
			
		}
		
	}
	
}