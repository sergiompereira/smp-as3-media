package com.smp.media{
	
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.MouseEvent;
	
	
	//ABSTRACT CLASS
	public class  InterfaceComponent
	{
		protected var _graphic:MovieClip;
		
		public function InterfaceComponent(graphic:MovieClip) {
			_graphic = graphic;
		}
		
		public function get graphic():MovieClip {
			return _graphic;
		}
		
		public function handleInput(fnc:Function):void {
			throw new IllegalOperationError("Abstract method: must be overriden.");
		}
		
		public function handleMouseInput(evt:String, fnc:Function):void {
			throw new IllegalOperationError("Abstract method: must be overriden.");
		}
		
		
	}
	
}