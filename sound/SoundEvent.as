package  com.smp.media.sound
{

	import flash.events.Event;
	
	public class  SoundEvent extends Event
	{
		public static const PLAY_CHANGED:String = "PlayChanged";
		public static const SOUND_CHANGED:String = "SoundChanged";
		
		public function SoundEvent(type:String):void {
			
			super(type);
		}
		
	}
	
}