package titleObjects
{
	//---IMPORT LIBRARIES---//
	import flash.display.MovieClip;
	
	public class TitleScreen extends MovieClip
	{
		//Declare objects
		private var titleBackground:TitleBackground;
		
		//---CONSTRUCTOR---//
		public function TitleScreen():void
		{
			//Add the visuals to the stage
			titleBackground = new TitleBackground(0,0);
			addChild(titleBackground);
		}
	}
}