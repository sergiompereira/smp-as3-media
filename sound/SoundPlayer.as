package com.smp.media.sound {
	
	
	/* USO:
		import srg.media.sound.SoundPlayer;

		var soundPlayer = new SoundPlayer(["Track1.mp3","Track2.mp3"], true);
		soundPlayer.PlayPauseBt = playPause;
		soundPlayer.StopBt = stopBt;
		soundPlayer.TimelineView = timeline;
		soundPlayer.PlayheadBar = playhead;
		soundPlayer.PlayheadSlider = playheadSlider;
		soundPlayer.VolumeOnOffBt = volumeOnOff;
		soundPlayer.setMaxVolume(0.8);
		soundPlayer.setVolumeBt(volumeBt, 5);
		soundPlayer.setVolume(0.4);
	 * 
	 * 
	*/
	  
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.smp.media.sound.*;
	import com.smp.media.Invoker;
	import com.smp.media.InputHandler;
	
	public class SoundPlayer extends Sprite {
		
		private var soundCollection:Array;
		//private var soundObject:ISoundOutput
		private var invoker:Invoker;
		private var model:SoundModel;
		
		private var playbackWidth:Number = 0;
		
		private var _loop:Boolean = false;
		private var _autoplay:Boolean = false;
		
		
		public function SoundPlayer(files:Array, loop:Boolean  = false, autoplay:Boolean = false) {	
				
			soundCollection = new Array();
			for (var i:uint = 0; i < files.length; i++) {
				var soundObject:ISoundOutput = new SoundObject("", false, autoplay);	
				soundObject.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				soundCollection.push(soundObject);
			}
			
			invoker = new Invoker();
			_loop = loop;
			_autoplay = autoplay;
			
			model = new SoundModel();
			model.setMediaList(files);
			
			model.activeSound = soundCollection[0];
			if (files.length > 0) {
				soundCollection[0].load(model.getMediaFile(0));
			}else {
				throw new Error("SoundPlayer->init: files array must be not empty.");
			}
			
			
		}
		
		public function set autoplay(value:Boolean):void {
			_autoplay = value;
		}
		
		public function set loop(value:Boolean):void {
			_loop = value;
		}
		
		public function play(item:uint = 0):void {
			if((soundCollection[model.activeId] as ISoundOutput).playing){
				(soundCollection[model.activeId] as ISoundOutput).stop();
			}
			if(!(soundCollection[item] as ISoundOutput).loaded){
				(soundCollection[item] as ISoundOutput).load(model.getMediaFile(item));
			}else {
				(soundCollection[item] as ISoundOutput).init();
			}
			model.activeSound = (soundCollection[item] as ISoundOutput);
		}
		
		/* 
		 * obj é um MovieClip com dois frames "play" e "pause"
		 */
		public function set PlayPauseBt(obj:MovieClip):void {
			var playPauseBt:SoundInterfaceComponent = new PlayPauseButton(obj);
			playPauseBt.init(model);
			invoker.setMouseHandler(playPauseBt, new InputHandler(new PlayPauseCommand(model, true)));	
		}
		
		/* 
		 * obj é um MovieClip com uma animação na timeline e dois stop(), no 1º e último frame
		 */
		public function set StopBt(obj:MovieClip):void {
			var StopBt:SoundInterfaceComponent = new StopButton(obj);
			StopBt.init(model);
			invoker.setMouseHandler(StopBt, new InputHandler(new StopCommand(model)));
		}
		
		/* 
		 * 
		 */
		public function set TimelineView(obj:MovieClip):void {
			playbackWidth = obj.width;
			var timeline:SoundInterfaceComponent = new Timeline(obj);
			timeline.init(model);
		}
		
		/* 
		 * 
		 */
		public function set PlayheadBar(obj:MovieClip):void {
			var playheadBar:SoundInterfaceComponent = new PlayheadBar(obj);
			playheadBar.init(model);
			invoker.setMouseHandler(playheadBar, new InputHandler(new PlayheadBarCommand(model)));
		}
		
		
		/* 
		 * !! Invocar este método sempre DEPOIS de TimelineView!
		 * obj deve ser um MovieClip no palco com outro MovieClip interno (com qualquer nome), centrado na origem (0,0)
		 */
		public function set PlayheadSlider(obj:MovieClip):void {
			var playheadSlider:SoundInterfaceComponent = new PlayheadSlider(obj, playbackWidth);
			playheadSlider.init(model);
			invoker.setHandler(playheadSlider, new InputHandler(new PlayheadSliderCommand(model)));
		}
		
		public function set VolumeOnOffBt(obj:MovieClip):void {
			var volumeOnOff:SoundInterfaceComponent = new VolumeOnOff(obj);
			volumeOnOff.init(model);
			invoker.setMouseHandler(volumeOnOff, new InputHandler(new VolumeCommand(model)));
		}
		
		public function setMaxVolume(value:Number):void {
			model.setMaxVolume(value);
		}
		
		/* 
		 * obj é um MovieClip com N MovieClips internos, todos instâncias do mesmo MovieClip
		 * Estas instâncias têm a propriedade name "stepn", com n = 1..N
		 * É assumido por default N = 5;
		 * O MovieClip interno base, tem dois framse "on" e "off"
		 */
		public function setVolumeBt(obj:MovieClip, numSteps:uint = 5):void {
			var volumeBt:SoundInterfaceComponent = new VolumeButton(obj, numSteps);
			volumeBt.init(model);
			invoker.setMouseHandler(volumeBt, new InputHandler(new VolumeCommand(model)));
		}
		
		public function stop():void {
			(soundCollection[model.activeId] as ISoundOutput).fadeOut(3, true);
		}
		
		public function setVolume(value:Number):void {
			model.setVolume(value);
			(soundCollection[model.activeId] as ISoundOutput).volume = value;
		}
		
		private function onSoundComplete(evt:Event):void {
			if (_autoplay) {
				if((model.activeId == model.getListLength()-1 && _loop == true) || model.activeId < model.getListLength()-1){
					this.play(model.next());
				}
			}
		}
		
		public function init():void {
			(soundCollection[model.activeId] as ISoundOutput).init();
		}
		
		public function next():void {
			this.play(model.next());
		}
		
		public function previous():void {
			this.play(model.previous());
		}
		
	}
}