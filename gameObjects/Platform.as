package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	
	public class Platform extends MovieClip
	{
		//the width of the platform
		public var w:Number;
		//the height of the platform
		public var h:Number;
		//the visuals for the cloud (as I want the platforms to have snow on the top of them)
		public var cloudTile:CloudTile;
		//the mask used to hide any tiles outside of the platform's border
		public var maskObj:MaskObj;
		//the visuals for the platform 
		public var platformTile:PlatformTile;
		
		public function Platform(xp:Number,yp:Number,wd:Number,hi:Number):void
		{
			//set the x and y of the platform to the passed parameters
			this.x = xp;
			this.y = yp;
			//Set the width of the platform
			this.width = wd;
			w = wd;
			//Set the height of the platform
			this.height = hi;
			h = hi;
			
			//Add the mask and scale it appropriately
			maskObj = new MaskObj();
			maskObj.width = w / this.scaleX;
			maskObj.height = h / this.scaleY;
			addChild(maskObj);
			
			//Tesselate the platforms and clouds in the correct positions
			tilePlatform();
			tileCloud();
		}
		
		private function tilePlatform():void
		{
			platformTile = new PlatformTile();
			//Calculate how many platforms are needed horizontally to cover the width of the platform
			var amountOfTilesWide:int = Math.floor(1 + w / platformTile.width);
			//Calculate how many platforms are needed vertically to cover the height of the platform
			var amountOfTilesHigh:int = Math.floor(1 + h / platformTile.height);
			platformTile = null;
			
			for (var i:int = 0; i < amountOfTilesWide; i++)
			{	
				for (var j:int = 0; j < amountOfTilesHigh; j++)
				{
					//Declare the platform tile
					platformTile = new PlatformTile();
					//Move the tile to the appropriate x and y coordinates
					platformTile.x = i * (platformTile.width/this.scaleX);
					platformTile.y = j * (platformTile.height / this.scaleY);
					/* Scale the tile, as the tile is added through 
					a scaled object and will inherit the platform's scale */
					platformTile.scaleX = 1 / this.scaleX;
					platformTile.scaleY = 1 / this.scaleY;
					//Add the platform tile
					addChild(platformTile);
				}
			}
			
			//Add the mask to hide any tiles outside of the platform's border
			this.mask = maskObj;
		}
		
		private function tileCloud():void
		{
			//Calculate how many tiles are needed to cover the width of the platform
			cloudTile = new CloudTile();
			var amountOfTilesWide:int = Math.floor(1 + w / cloudTile.width);
			cloudTile = null;
			
			for (var i:int = 0; i < amountOfTilesWide; i++)
			{
				//Declare a new cloud tile
				cloudTile = new CloudTile();
				//Change its x coordinates appropriately
				cloudTile.x = i * (cloudTile.width / this.scaleX);
				/* Scale the tile, as the tile is added through 
				a scaled object and will inherit the platform's scale*/
				cloudTile.scaleX = 1 / this.scaleX;
				cloudTile.scaleY = 1 / this.scaleY;
				//Add the cloud tile
				addChild(cloudTile);
			}
			
			//Add the mask to hide any tiles outside of the platform's border
			this.mask = maskObj;
		}
	}
}