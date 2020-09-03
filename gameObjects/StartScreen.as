package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class StartScreen extends MovieClip
	{
		//Timer for how long the screen should last
		public var screenTimer:Timer = new Timer(3000,1);
		
		public function StartScreen(levelName:String):void
		{
			//Start the timer
			screenTimer.start();
			//Set the text to the name of the level
			this.nameText.text = levelName;
		}
	}
}