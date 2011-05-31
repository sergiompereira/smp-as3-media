package com.smp.media.video{

	import flash.display.BitmapData;
	import flash.display.Sprite
	
	import flash.media.Camera
	import flash.media.Video
	
	
	public class WebCamera extends Sprite {

		private var cam		:Camera;
		private var video	:Video;
		private var _mirror:Boolean = false;
	

		public function WebCamera (width:Number = 250, height:Number = 190, fps:Number = 15) {

			cam = Camera.getCamera();
			//Sets the camera capture mode to the native mode that best meets the specified requirements.
			cam.setMode(width, height, fps);

			if (cam == null) {
				//
			} else {
				video = new Video(cam.width, cam.height);
				video.attachCamera(cam);
				addChild(video);
			}
		}
		
		
		public function get webVideo():Video {
			if (cam != null) {
				return video;
			}
			return null;
		}
		
		public function mirror(value:Boolean):void 
		{
			
			_mirror = value;
			
			if (value) {
				video.scaleX = -1;
				video.x = cam.width;
			}else {
				video.scaleX = 1;
				video.x = 0;
			}
		}
	
		
		public function get camWidth():Number {
			return cam.width;
		}
		
		public function get camHeight():Number {
			return cam.height;
		}
		
		public function grab():BitmapData 
		{			
			var bmd:BitmapData = new BitmapData(cam.width, cam.height);
			bmd.draw(video, video.transform.matrix, video.transform.colorTransform);
						
			return bmd;
		}
		
		public function destroy():void 
		{
			video.attachCamera(null);
			cam = null;
		}
		
		
	}
}