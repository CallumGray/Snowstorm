package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	
	public class Snowball extends MovieClip
	{
		//x velocity of the snowball
		public var xv:Number = 0;
		//y velocity of the snowball
		public var yv:Number = 0;
		//The width of the snowball
		public var w:Number;
		//The height of the snowball
		public var h:Number;
		//The damage of the snowball
		public var damage:int = 0;
		//The animation of the snowball
		private var snowballProjectile:SnowballProjectile;
		
		public function Snowball(xp:Number,yp:Number,xVelocity:Number,yVelocity:Number,snowballDamage:int)
		{
			//Set the x and y positions of the character
			this.x = xp;
			this.y = yp;
			//set damage to the given snowball damage
			damage = snowballDamage;
			//Set the x and y velocities
			xv = xVelocity;
			yv = yVelocity;
			//Set width
			w = this.width;
			//Set height
			h = this.height;
			
			//Add the animation for the snowball
			snowballProjectile = new SnowballProjectile();
			addChild(snowballProjectile);
		}
	}
}