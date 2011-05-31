package com.smp.media {
	
	import flash.events.MouseEvent;
	
	public interface IInvoker {
		
		function setHandler(inputView:InterfaceComponent, inputHandler:IInputHandler):void;
		function setMouseHandler(inputView:InterfaceComponent, inputHandler:IInputHandler):void
		
	}
}