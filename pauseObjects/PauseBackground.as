package pauseObjects
{
	import flash.display.MovieClip;
	
	public class PauseBackground extends MovieClip
	{
		public function PauseBackground(xp:Number,yp:Number):void
		{
			//Change x and y positions to meet passed parameters
			this.x = xp;
			this.y = yp;
		}
	}
}