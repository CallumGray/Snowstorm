package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Penguin extends MovieClip
	{
		//The current animation of the penguin
		private var currentAnimation:MovieClip;
		//The current state of the penguin
		private var state:String = "walkLeft";
		
		//The x velocity of the penguin (starts off negative as it walks to the left)
		public var xv:Number = -1;
		//They y velocity of the penguin
		public var yv:Number = 0;
		//The width of the penguin
		public var w:Number;
		//The height of the penguin
		public var h:Number;
		//Determines which direction the penguin is facing
		public var facingLeft:Boolean = true;
		
		public function Penguin(xp:Number, yp:Number)
		{
			//Set the x and y coordinates based on the passed parameters
			this.x = xp;
			this.y = yp;
			//Set the width of the penguin
			w = this.width;
			//Set the height of the penguin
			h = this.height;
			
			//Add the initial animation of the penguin
			currentAnimation = new PenguinWalkLeft();
			addChild(currentAnimation);
		}
		
		private function resetAnimation():void
		{
			//remove the current animation being used
			removeChild(currentAnimation);
			currentAnimation = null;
		}
		
		public function walkLeft():void
		{
			//If state is not walking left...
			if (state != "walkLeft")
			{
				//remove the current animation
				resetAnimation();
				//set the state to walking left
				state = "walkLeft";
				//add the animation for the penguin to walk left
				currentAnimation = new PenguinWalkLeft();
				addChild(currentAnimation);
			}
		}
		
		public function walkRight():void
		{
			//If state is not walking right...
			if (state != "walkRight")
			{
				//remove the current animation
				resetAnimation();
				//set the state to walking right
				state = "walkRight";
				//add the animation for the penguin to walk right
				currentAnimation = new PenguinWalkRight();
				addChild(currentAnimation);
			}
		}
		
		public function fallingLeft():void
		{
			//If the state is not falling left
			if (state != "fallLeft")
			{
				//remove the current animation
				resetAnimation();
				//set the state to falling left
				state = "fallLeft";
				//add the animation for the penguin to fall left
				currentAnimation = new PenguinFallingLeft();
				addChild(currentAnimation);
			}
		}
		
		public function fallingRight():void
		{
			//If the state is not falling right
			if (state != "fallRight")
			{
				//remove the current animation
				resetAnimation();
				//set the state to falling left
				state = "fallRight";
				//add the animation for the penguin to fall right
				currentAnimation = new PenguinFallingRight();
				addChild(currentAnimation);
			}
		}
	}
}