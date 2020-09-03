package gameObjects
{
	//Import Libraries
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Cage extends MovieClip
	{
		//Health of the cage
		public var health:Number = 50;
		//Amount of exp gained from destroying a cage
		public var givenExp:int = 5;
		
		//Timer used for how long the flashing effect lasts once the cage is hit
		public var flashTimer:Timer = new Timer(80, 1);
		
		//Width of the cage
		public var w:Number;
		
		//Height of the cage
		public var h:Number;
		
		//Animations used to display the cage
		private var penguinCrying:PenguinCrying;
		private var cageBars:CageBars;
		
		public function Cage(xp:Number,yp:Number):void
		{
			//Set the x and y position to the parameters given
			this.x = xp;
			this.y = yp;
			
			//set the width and height
			w = this.width;
			h = this.height;
			
			//Add the penguin crying animation
			penguinCrying = new PenguinCrying();
			penguinCrying.x += 10;
			penguinCrying.y = h - penguinCrying.height;
			addChild(penguinCrying);
			
			//Add the cage visuals
			cageBars = new CageBars();
			addChild(cageBars);
			
		}
		
		public function flash():void
		{
			//0xFFFF00 - yellow!
			var c:Color = new Color();
   			c.setTint (0xFFFF00, 0.9);
			
			//Apply the yellow tint to the cage (but not the penguin inside)
   			cageBars.transform.colorTransform = c;
			
			//Give the timer a listener for when the effect needs to stop
			flashTimer.addEventListener(TimerEvent.TIMER_COMPLETE, stopFlash);
			//start the timer
			flashTimer.start();
		}
		
		private function stopFlash(e:TimerEvent):void
		{
			//remove the listener
			flashTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,stopFlash);
			//stop the timer
			flashTimer.stop();
			
			//remove the visual effect from the cage
			var c:Color = new Color();
   			c.setTint (0, 0);
   			cageBars.transform.colorTransform = c;
		}
	}
}