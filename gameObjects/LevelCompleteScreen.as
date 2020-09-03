package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class LevelCompleteScreen extends MovieClip
	{
		//Set a timer for how long the screen should stay before getting removed
		public var screenTimer:Timer = new Timer(3000,1);
		
		//Constructor
		public function LevelCompleteScreen(bonusExp):void
		{
			//Start the timer
			screenTimer.start();
			
			//Display the amount of bonus experience gained based on the passed parameters
			this.expText.text = "Bonus Exp:" + bonusExp.toString();
		}
	}
}