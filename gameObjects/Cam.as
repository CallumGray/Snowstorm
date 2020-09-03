package gameObjects
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	public class Cam extends MovieClip
	{
		public var sh:Number=450;
		public var sw:Number=800;
		public var camH:Number;
		public var camW:Number;
		
		public function Cam():void
		{
			this.mouseEnabled=false;
			this.mouseChildren=false;
			this.visible=false;
			
			if(stage)init();
			else addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		public function onAdd(e:Event):void
		{
			init();
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		public function init():void
		{
			/**
			* Get the bounds of the camera
			**/
			var bounds_obj:Object=this.getBounds(this);
			camH=bounds_obj.height;
			camW=bounds_obj.width;

			/**
			* Get the stage dimensions
			**/
			sh=450;
			sw=800;
	
			addEventListener(Event.REMOVED_FROM_STAGE,reset);
		}
		
		public function update():void
		{
			/**
			* If no parent exists then ignore transformation
			**/
			if(!parent || !stage)
			return;

			/**
			* Gets the current scale of the vCam
			**/
			var h:Number=camH * scaleY;
			var w:Number=camW * scaleX;
	
			/**
			* Gets the stage to vCam scale ratio
			**/
			var _scaleY:Number=sh / h;
			var _scaleX:Number=sw / w;
	
			/**
			* Copies the cam's matrix and transforms it
			**/
			var matrix:Matrix=this.transform.matrix.clone();
			matrix.invert();
			matrix.scale(scaleX,scaleY);
			//matrix.translate(w/2,h/2);
			matrix.scale(_scaleX,_scaleY);

			/**
			* Apply transformation matrix and filters to parent
			**/
			parent.transform.matrix=matrix;
			parent.transform.colorTransform=this.transform.colorTransform;
			parent.filters=this.filters;
		}
		
		public function reset(e:Event):void
		{
			/**
			* Clean up for garbage collection
			**/
			removeEventListener(Event.REMOVED_FROM_STAGE,reset);
	
			/**
			* Resets parent properties
			**/
			var matrix:Matrix=new Matrix();
			parent.transform.matrix=matrix;
	
			parent.filters=[];

			var ct:ColorTransform=new ColorTransform();
			parent.transform.colorTransform=ct;
		}
	}
}