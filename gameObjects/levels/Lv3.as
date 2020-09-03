package gameObjects.levels
{
	public class Lv3
	{
		//The name of the level
		public var levelName:String = "SNOWPEAK DRIFTS";
		//The array containing each element of the level
		public var levelArray:Array = 
		[
		 //Barriers that will form the outside of the level
		 [0,0,-450,4800,450],
		 [0,0,900,6400,450],
		 [0,-800,-450,800,1800],
		 [0,4500,-450,800,1800],
		 
		 //Platforms
		 [0,200,600,400,200],
		 [0,800,500,300,100],
		 [0,3000,400,200,300],
		 [0,3200,450,1300,200],
		 [0,1500,550,200,100],
		 [0,1800,500,200,600],
		 [0,2000,400,700,600],
		 
		 //Clouds
		 [1,2700,750,50],
		 [1,2700,600,50],
		 [1,2700,450,50],
		 [1,600,680,250],
		 [1,900,750,150],
		 [1,1400,600,100],
		 [1,1700,630,100],
		 
		 //Cages
		 [2,4000,395],
		 [2,4200,395],
		 [2,4400,395],
		 [2,1725,575],
		 [2,2400,345],
		 
		 //Bats
		 [3,1400,700],
		 [3,1700,200],
		 [3,2500,100],
		 [3,2400,100],
		 [3,3300,700],
		 [3,3400,700],
		 [3,3450,700],
		 [3,3600,700],
		 [3,3520,700],
		 [3,3550,700],
		 [3,3350,200],
		 [3,3800,200],
		 [3,500,200],
		 [3,1800,200]
		 ]
		 
		 //Coordinates of where the character will start
		public var spawnX:Number = 100;
		public var spawnY:Number = 600;
		//The music used for the level
		public var musicIndex:int = 1;
		//Constructor
		public function Lv3():void
		{
			
		}
	}
}