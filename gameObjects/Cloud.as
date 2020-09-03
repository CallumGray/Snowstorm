package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	
	public class Cloud extends MovieClip
	{
		//Width of the cloud
		public var w:Number;
		//Height of the cloud
		public var h:Number;
		//Visual used for the cloud
		public var cloudTile:CloudTile;
		//Mask used to "fit" the cloud visuals on top of the cloud, even after it is stretched
		public var maskObj:MaskObj;
		
		public function Cloud(xp:Number,yp:Number,wd:Number):void
		{
			//set x and y position of the cloud
			this.x = xp;
			this.y = yp;
			
			//set the width 
			this.width = wd;
			w = wd;
			
			//set the height
			h = this.height;
			
			//Add the mask, making it the length of the cloud
			maskObj = new MaskObj();
			maskObj.width = w / this.scaleX;
			maskObj.height = h / this.scaleY;
			addChild(maskObj);
			
			/* Tesselate the visuals for the cloud, so visuals will always be shown correctly, regardless 
			of the cloud's size */
			tile();
		}
		
		private function tile():void
		{
			//Set a total width for the amount of clouds currently added
			var totalWidth:Number = 0;
			
			//Keep lining up the cloud visuals until their width is greater than that of the cloud
			while (totalWidth < w)
			{
				//Add a knew cloud tile
				cloudTile = new CloudTile();
				//Set the tile's x position to be on the end of the collection of tiles
				cloudTile.x = totalWidth;
				/*Scale the visuals of the cloud, as the cloud has undergone
				scaling and any scale will carry over to objects added by the cloud*/
				cloudTile.scaleX = 1 / this.scaleX;
				cloudTile.scaleY = 1 / this.scaleY;
				//update the total width appropriately
				totalWidth += cloudTile.width;
				//add the tile
				addChild(cloudTile);
			}
			
			//Hide any of the cloud tiles that are going outside the border of the cloud
			this.mask = maskObj;
		}
	}
}