package com.smp.media {
	
	import flash.events.*;
	import flash.errors.IllegalOperationError
		
	import com.smp.media.IInputHandler;
	import com.smp.media.ICommand;	
	
	public class InputHandler implements IInputHandler {
		
		private var _command:ICommand;
		
		public function InputHandler(command:ICommand) {
			_command = command;
		}
		
		public function handleMouseUp(evt:MouseEvent):void {
			if (_command != null) {
				_command.execute();
			}else {
				throw new IllegalOperationError("Command not set.");
			}
		}
		
		public function handleCall():void {
			if (_command != null) {
				_command.execute();
			}else {
				throw new IllegalOperationError("Command not set.");
			}
		}
	}
}