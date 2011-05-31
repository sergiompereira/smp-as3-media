package  com.smp.media.sound
{
	import flash.events.IEventDispatcher;
	
	public interface  ISoundOutput extends IEventDispatcher
	{
		function load(url:String):void;
		function get loaded():Boolean;
		function get playing():Boolean;
		function fadeIn(tempo:Number):void 
		function fadeOut(tempo:Number, pausa:Boolean = false):void
		function togglePause():void
		function init():void;
		function stop():void;
		function get time():int;
		function set time(value:int):void;
		function get length():Number;
		function get volume():Number;
		function set volume(value:Number):void;
		
		
	}
	
}