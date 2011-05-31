package com.smp.media {
	
	import flash.events.MouseEvent;
	import flash.errors.IllegalOperationError

	
	import com.smp.media.IInputHandler;
	
		
	public class Invoker implements IInvoker{
		
		
		private var _aInputHandlers:Array = new Array();
		private var _aInputViews:Array = new Array();
		
		public function setHandler(inputView:InterfaceComponent, inputHandler:IInputHandler):void {
			_aInputHandlers.push(inputHandler);
			_aInputViews.push(inputView);
			
			inputView.handleInput(executeCommand);
			
		}
		
		public function setMouseHandler(inputView:InterfaceComponent, inputHandler:IInputHandler):void {
			_aInputHandlers.push(inputHandler);
			_aInputViews.push(inputView);
			
			inputView.handleMouseInput(MouseEvent.MOUSE_UP, executeMouseCommand);
			
		}
		
		private function executeCommand(obj:InterfaceComponent) {
			
			for (var i:uint = 0; i < _aInputViews.length; i++) {
				
				if (obj == (_aInputViews[i] as InterfaceComponent))
				{
					(_aInputHandlers[i] as IInputHandler).handleCall();
					break;
				}
			}
		}
		
		
		private function executeMouseCommand(evt:MouseEvent) {
			
			for (var i:uint = 0; i < _aInputViews.length; i++) {
				
				if (evt.currentTarget == (_aInputViews[i] as InterfaceComponent).graphic) 
				{
					(_aInputHandlers[i] as IInputHandler).handleMouseUp(evt);
					break;
				}
				
			}
			
		}

	}
}