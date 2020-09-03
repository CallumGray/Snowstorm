package gameObjects
{
	//Import Libraries
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Death extends MovieClip
	{
		//Add a timer for how long the death should stay on screen
		public var deathTimer:Timer = new Timer(400,1);
		
		public function Death(xp:Number,yp:Number):void
		{
			//Set the x and y position to that of the passed parameters
			this.x = xp;
			this.y = yp;
			//Add a listener for when to remove the death animation
			deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeThis);
			//start the timer
			deathTimer.start();
		}
		
		private function removeThis(e:TimerEvent):void
		{
			//Remove the death animation
			parent.removeChild(this);
		}
	}
}