package com.smp.media.video
{
	import flash.events.IEventDispatcher;
	import flash.net.NetStream;
	import flash.media.Video;
	
	public interface  IVideoOutput extends IEventDispatcher
	{
		function load(file:String, loop:Boolean = false, autoplay:Boolean = true, verbose:Boolean = true):void;
		//function get streamer():NetStream;
		//function get video():Video;
		function get loadPercent():int;
		function get loaded():Boolean;
		function get length():Number;
		function get time():Number;
		function set time(value:Number):void;
		//function get fpSecond():Number;
		function set videoWidth(largura:Number);
		function set videoHeight(altura:Number);
		function get videoWidth():Number;
		function get videoHeight():Number;
		function setSize(width:Number, height:Number):void;
		function rescale(width:Number = 0, height:Number = 0):void;
		//function setSourceSize(centerVideo:Array = null):void;
		function init():void;
		function stop():void;
		function clear():void;
		function togglePause():void;
		function get playing():Boolean;
		function set volume(value:Number):void;
		function get volume():Number;
		function set loop(value:Boolean):void;
		function get loop():Boolean;
		
	}
	
}