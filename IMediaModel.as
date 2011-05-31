package com.smp.media {
	
	
	public interface IMediaModel  {
		
		
		
		function setVolume(value:Number):void ;
	
		function getVolume():Number;
		
		function setTime(value:Number):void;
	
		function getTime():Number;
		
		function setMaxVolume(value:Number):void;
		
		function getMaxVolume():Number;
		
		function setMediaList(list:Array):void;
		
		function getListLength():uint;
		
		function getMediaFile(i:uint):String;
				
		function get activeId():int;
		
		
	}
}