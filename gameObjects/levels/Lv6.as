package gameObjects.levels
{
	public class Lv6
	{
		//The name of the level
		public var levelName:String = "SNOWPEAK CAVERN X";
		//The array containing each element of the level
		public var levelArray:Array = 
		[
		 //Barriers that will form the outside of the level
		 [0,0,-450,1600,450],
		 [0,0,450,1600,450],
		 [0,-800,-450,800,1350],
		 [0,1600,-450,800,1350],
		 
		 //Clouds
		 [1,650,150,300],
		 [1,400,250,300],
		 [1,900,250,300],
		 [1,150,350,300],
		 [1,650,350,300],
		 [1,1150,350,300],
		 
		 //Boss Bats
		 [4,1200,200],
		 [4,1000,300],
		 [4,1100,230]
		 ]
		 
		 //Coordinates of where the character will start
		public var spawnX:Number = 200;
		public var spawnY:Number = 200;
		//The music used for the level
		public var musicIndex:int = 3;
		//Constructor
		public function Lv6():void
		{
			
		}
	}
}