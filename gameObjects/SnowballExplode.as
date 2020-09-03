package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class SnowballExplode extends MovieClip
	{
		//Set a timer for how long it takes to remove the explosion
		public var explodeTimer:Timer = new Timer(250, 1);
		
		public function SnowballExplode(xp:Number, yp:Number):void
		{
			//set x and y coordinates of the snowball to the passed parameters
			this.x = xp;
			this.y = yp;
			
			//Add a listener for the timer to remove the snowball explosion
			explodeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeThis);
			//Start the timer
			explodeTimer.start();
		}
		
		private function removeThis(e:TimerEvent):void
		{
			//remove the snowball explosion
			parent.removeChild(this);
		}
	}
}