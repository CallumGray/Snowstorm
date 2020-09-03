package gameObjects.levels
{
	public class Lv5
	{
		//The name of the level
		public var levelName:String = "SNOWPEAK CAVERN";
		//The array containing each element of the level
		public var levelArray:Array = 
		[
		 //Barriers that will form the outside of the level
		 [0,0,-450,4800,450],
		 [0,0,900,6400,450],
		 [0,-800,-450,800,1800],
		 [0,4800,-450,800,1800],
		 
		 //Platforms
		 [0,801,450,800,200],
		 [0,800,451,200,500],
		 [0,1800,350,200,450],
		 [0,2000,700,450,100],
		 [0,2050,350,100,300],
		 [0,2150,550,250,100],
		 [0,2200,350,150,150],
		 [0,2550,250,600,450],
		 [0,3950,350,400,300],
		 [0,4350,350,60,125],
		 [0,4350,525,60,125],
		 
		 //Clouds
		 [1,400,800,250],
		 [1,600,700,200],
		 [1,450,600,100],
		 [1,600,500,200],
		 [1,1700,780,100],
		 [1,1600,620,100],
		 [1,1700,460,100],
		 [1,2450,750,100],
		 [1,2350,400,200],
		 [1,3150,600,800],
		 [1,3150,400,800],
		 [1,4650,675,150],
		 [1,4550,800,150],
		 
		 //Cages
		 [2,1000,845],
		 [2,2150,495],
		 [2,2000,645],
		 [2,4350,475],
		 [2,745,845],
		 
		 //Bats
		 [3,1700,800],
		 [3,1500,650],
		 [3,3150,450],
		 [3,3200,450],
		 [3,3250,450],
		 [3,3150,500],
		 [3,3200,500],
		 [3,3250,500],
		 [3,3150,550],
		 [3,3200,550],
		 [3,3250,550],
		 [3,2650,200]
		 ];
		
		 //Coordinates of where the character will start
		public var spawnX:Number = 100;
		public var spawnY:Number = 800;
		//The music used for the level
		public var musicIndex:int = 2;
		//Constructor
		public function Lv5():void
		{
			trace(levelName);
		}
	}
}