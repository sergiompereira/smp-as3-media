package  com.smp.media.sound
{

/*
-------------------------
Sérgio Pereira :: 01-2009
-------------------------
Load de som
Load event handlers
Loaded percent
Tempo total
OnPlayComplete handler
Controlos:stop,init,play/pause,playback position,volume
Faders
*/

	import com.smp.common.utils.JSUtils;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	import flash.events.*;
	import flash.utils.Timer;

	public class SoundObject extends EventDispatcher implements ISoundOutput{


		private var _som:Sound;
		private var _verbose:Boolean = false;
		private var _loop:Boolean;
		private var _autoplay:Boolean;
		private var _buffer:SoundLoaderContext;
		private var _url:String;

		private var _faderTimer:Timer;
		private var _bytesLoaded:Number = 0;
		private var _bytesTotal:Number = 0;
		private var _loadedPercent:int;
		private var _totalLength:Number;
		private var _loaded:Boolean = false;

		private var _canal:SoundChannel;
		private var _transf:SoundTransform = new SoundTransform();

		private var _position:int = 0;
		private var _volume:Number;
		private var _playing:Boolean = false;
		


		public function SoundObject(url:String = "", loop:Boolean = false, autoplay:Boolean = true, verbose:Boolean = true, buffer:Number = 2000) {

			_url = url;
			_loop = loop;
			_autoplay = autoplay;
			_buffer = new SoundLoaderContext(buffer);
			_volume = 1;
			
			_playing = false;
			_verbose = verbose;

			_faderTimer = new Timer(500);
			
			if (_autoplay && _url != '') {
				this.load(_url);
			}

		}
		public function set buffer(buffer:Number):void 
		{
			_buffer = new SoundLoaderContext(buffer);
		}
		
		public function load(url:String = ''):void {
			
			if (_som == null) {
				
				if (url != '') {
					_url = url;
				}else if (_url == '') {
					throw new ArgumentError("SoundObject->load: Não foi fornecido nenhum ficheiro de som.");
					return;
				}
				
				_loaded = false;
				_loadedPercent=0;
				_bytesLoaded=0;
				_bytesTotal=0;

				try {
					
					_som = new Sound();
					_som.load(new URLRequest(_url), _buffer);
					
					//if (_autoplay) {
						if (_loop) {
							resetChannel(_som.play(0, 9999));
						}else {
							resetChannel(_som.play());
						}
						_transf.volume = _volume;
						_canal.soundTransform = _transf;
						
						_playing = true;
						
						dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
					/*}else {
						resetChannel(_som.play());
						_transf.volume = _volume;
						_canal.soundTransform = _transf;
						_playing = true;
						togglePause();
					}*/
		

					_som.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
					_som.addEventListener(Event.OPEN, onOpen, false, 0, true);
					_som.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
					_som.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);

				} catch (err:Error) {
					if (_verbose) {
						throw new Error("SoundObject->load: " + err.message);
					}
				}
			} else {
				throw new ArgumentError("SoundObject->load: Só pode ser carregado um único ficheiro.");
			}
		}
		private function onIOError(evt:IOErrorEvent):void {
			if (_verbose) {
				throw IOErrorEvent;
			}
		}
		private function onOpen(evt:Event):void {
			if (_verbose) {
				trace("Loading started");
			}
		}
		private function onProgress(evt:ProgressEvent):void {
			
			dispatchEvent(evt);

			_loadedPercent=Math.round(_som.bytesLoaded / _som.bytesTotal * 100);
			_bytesLoaded=_som.bytesLoaded;
			_bytesTotal=_som.bytesTotal;

		}
		private function onComplete(evt:Event) {

			_loaded = true;

			_som.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_som.removeEventListener(Event.OPEN, onOpen);
			_som.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_som.removeEventListener(Event.COMPLETE, onComplete);

			dispatchEvent(evt);
			
			/*if (!_autoplay) {
				_playing = false;
				_position = 0;
				_canal.stop();
				dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
			}*/

		}
		public function get loadedPercent():int {
			return _loadedPercent;

		}
		
		public function get loaded():Boolean {
			return _loaded;
		}
		
		public function get length():Number {
			_totalLength = _som.length / _loadedPercent*100;
			return _totalLength;
		}
		private function onPlayComplete(evt:Event) {
			_position = 0;
			if(!_loop){
				_playing = false;

				dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
				dispatchEvent(new Event(Event.SOUND_COMPLETE));
			}
		}
		
		public function stop():void {
			
			_playing = false;
			_position = 0;
			//sorry!
			_canal.stop();
			resetChannel(_som.play(0));
			_canal.stop();
			////
			
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
			
			//A REMOVER -> encontrar outra solução se necessário -> stack overflow (v. onPlayComplete)
			//dispatchEvent(new Event(Event.SOUND_COMPLETE));
		}
		public function init():void 
		{
			if (_som == null) {
				if(_url != '') {
					load(_url);
				}else {
					throw new ArgumentError("SoundObject -> togglePause: Não foi fornecido nenhum ficheiro de som.");
				}
			
			}else {
				_playing = true;
				_position = _canal.position;
				
				if(_loop){
					resetChannel(_som.play(0, 9999));
				}else {
					resetChannel(_som.play());
				}
				
				dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
			}
			
		}
		
		public function togglePause():void {
			
			if (_som == null) {
				if(_url != '') {
					load(_url);
				}else {
					throw new ArgumentError("SoundObject -> togglePause: Não foi fornecido nenhum ficheiro de som.");
				}
			
			}else if (_playing == true) {
				_position = _canal.position;
				_canal.stop();
				
				_playing = false;
				dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
			
			} else {
				
				if(_loop){
					resetChannel(_som.play(_position, 9999));
				}else {
					resetChannel(_som.play(_position));
				}
				
				this.volume = _volume;
				
				_playing = true;
				dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
			}

		}

		public function set time(value:int):void 
		{	
			_canal.stop();
			
			if(_loop){
				resetChannel(_som.play(value, 9999));
			}else {
				resetChannel(_som.play(value));
			}
			
			if (!_playing) {
				_position = _canal.position;
				_canal.stop();
			}
		}
		
		public function get time():int 
		{
			if(_canal != null){
				return _canal.position;
			}
			
			return _position;
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			resetFader();
			_volume = value;
			_transf.volume = _volume;
			if(_canal!=null){
				_canal.soundTransform = _transf;
			}
		}
		
		public function get playing():Boolean
		{
			return _playing;
		}
		
		public function fadeIn(tempo:Number):void 
		{
			if (_som == null) {
				if(_url != '') {
					load(_url);
				}else {
					throw new ArgumentError("SoundObject -> togglePause: Não foi fornecido nenhum ficheiro de som.");
				}
			}else{
				_position = _canal.position;
				_canal.stop();
				
				if (!_playing) {
					togglePause();
				}
				
				resetFader();
				_transf.volume = 0;
				_canal.soundTransform = _transf;

				_faderTimer.delay = tempo*100;
				_faderTimer.addEventListener(TimerEvent.TIMER, volumeIn, false, 0, true);
				_faderTimer.start();
			}

		}
		
		public function fadeOut(tempo:Number, pausa:Boolean = false):void 
		{
			
			resetFader();
			_transf.volume = _volume;
			_canal.soundTransform = _transf;

			if (pausa) {
				//v. VolumeOut
				_playing = false;
				dispatchEvent(new SoundEvent(SoundEvent.PLAY_CHANGED));
			}
			_faderTimer.delay = tempo*100;
			_faderTimer.addEventListener(TimerEvent.TIMER, volumeOut, false, 0, true);
			_faderTimer.start();

		}
		private function volumeIn(evt:TimerEvent):void {
			if (_transf.volume < _volume) {
				_transf.volume += 0.1;
				_canal.soundTransform = _transf;
			} else {
				_transf.volume = _volume;
				_canal.soundTransform = _transf;
				resetFader();
			}
		}
		private function volumeOut(evt:TimerEvent):void {
			if (_transf.volume  > 0.1) {
				_transf.volume -= 0.1;
				_canal.soundTransform = _transf;
			} else {
				_transf.volume=0;
				_canal.soundTransform = _transf;

				if (!_playing) {
					//Entendido como um fadeout para pausa (e não uma transição). v. fadeOut()
					//Não afecta o _volume porque nem a transição, nem a pausa são entendidos como controlos de volume.
					_position = _canal.position;
					_canal.stop();
				}
				resetFader();
			}
		}
		private function resetFader():void {
			_faderTimer.removeEventListener(TimerEvent.TIMER, volumeOut);
			_faderTimer.removeEventListener(TimerEvent.TIMER, volumeIn);
			_faderTimer.reset();
		}
		
		private function resetChannel(canal:SoundChannel):SoundChannel {
			_canal = canal;
			_canal.addEventListener(Event.SOUND_COMPLETE, onPlayComplete);
			this.volume = _volume;
			return _canal;
		}
	}
}