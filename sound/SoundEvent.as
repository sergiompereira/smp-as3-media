package  com.smp.media.sound
{

	import flash.events.Event;
	
	public class  SoundEvent extends Event
	{
		public static var PLAY_CHANGED:String = "PlayChanged";
		
		public function SoundEvent(type:String):void {
			
			super(type);
		}
		
	}
	
}