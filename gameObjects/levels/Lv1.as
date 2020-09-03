package gameObjects.levels
{
	public class Lv1
	{
		//The name of the level
		public var levelName:String = "SNOWPEAK RUINS";
		
		//The array containing each element of the level
		public var levelArray:Array = 
		[
		 //Barriers that will form the outside of the level
		 [0,0,-450,4800,450],
		 [0,0,900,6400,450],
		 [0,-800,-450,800,1800],
		 [0,4500,-450,800,1800],
		 
		 //Platforms
		 [0, 200, 800, 200, 200],
		 [0,800,800,200,200],
		 [0, 1000, 500, 200, 500],
		 [0,1600,700,400,300],
		 [0, 2400, 700, 400, 300],
		 [0, 3200, 600, 400, 400],
		 [0,3800,600,500,100],
		
		 //Clouds
		 [1, 400, 800, 400],
		 [1, 1200, 800, 400],
		 [1, 2000, 800, 400],
		 [1,700,500,200],
		 [1,1400,600,200],
		 [1,2100,600,200],
		 [1,2900,600,200],
		 [1,3600,600,200],
		 [1,3700,680,100],
		 [1,300,700,200],
		 [1, 500, 600, 200],
		 [1, 3600, 800, 400],
		 [1,2800,800,400],
		 [1, 4100, 800, 400],
		 
		 //Cages
		 [2,4450,845],
		 [2,3600,845],
		 [2, 550, 545],
		 [2, 1800, 645],
		 [2,2600,645],
		 
		 //Bats
		 [3,500,820],
		 [3,600,820],
		 [3,1100,820],
		 [3, 1400, 820],
		 [3,1700,820],
		 [3,1900,820],
		 [3,2900,820],
		 [3,3000,820],
		 [3,3700,820],
		 [3,3900,820], 
		 [3,4200,820],
		 [3,4150,820]
		 ]
		
		//Coordinates of where the character will start
		public var spawnX:Number = 100;
		public var spawnY:Number = 750;
		//The music used for the level
		public var musicIndex:int = 0;
		
		//Constructor
		public function Lv1():void
		{
				
		}
	}
}