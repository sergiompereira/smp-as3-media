package com.smp.media {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public interface IInputHandler {
		
		function handleMouseUp(evt:MouseEvent):void;
		function handleCall():void;
	}
}