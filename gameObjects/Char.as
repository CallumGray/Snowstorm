package gameObjects
{
	//Import Libraries
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Char extends MovieClip
	{
		//Timer for use when the character is hit
		public var flashTimer:Timer;
		
		//X velocity of the character
		public var xv:Number = 0;
		//Y vecloity of the character
		public var yv:Number = 0;
		
		//Setting a defualt animation
		private var currentAnimation:MovieClip;		
		public var currentVisual:String = "fallingRight";
		
		//Different "states" used to determine what animation should be displayed for the character
		public var state:String = "standing";
		public var horizontal:String = "right"; 
		public var vertical:String = "neutral";
		
		//Character's width
		public var w:Number;
		//Character's height
		public var h:Number;
		
		public function Char(xp:Number,yp:Number):void
		{
			//Set the x and y position of the character to meet the passed parameters
			this.x = xp;
			this.y = yp;
			
			//set the width of the character
			w = this.width;
			//set the height of the character
			h = this.height;
			
			//Add the initial animation
			currentAnimation = new CharStandRight();
			addChild(currentAnimation);
		}
		
		//Correct animation is displayed based on the current states of the character
		public function updateVisuals():void
		{
			switch(state)
			{
				case "standing":
					switch (horizontal) 
					{
						case "right":
							switch(vertical)
							{
								case "neutral":
									if (currentVisual != "standingRight")
									{
										standRight();
										currentVisual = "standingRight";
									}
								break;
								
								case "up":
									if (currentVisual != "standingUpRight")
									{
										standUpRight();
										currentVisual = "standingUpRight";
									}
								break;
									
								case "down":
									if (currentVisual != "standingDownRight")
									{
										standDownRight();
										currentVisual = "standingDownRight";
									}
								break;
							}
						break;
						
						case "left":
							switch(vertical)
							{
								case "neutral":
									if (currentVisual != "standingLeft")
									{
										standLeft();
										currentVisual = "standingLeft";
									}
								break;
								
								case "up":
									if (currentVisual != "standingUpLeft")
									{
										standUpLeft();
										currentVisual = "standingUpLeft";
									}
								break;
									
								case "down":
									if (currentVisual != "standingDownLeft")
									{
										standDownLeft();
										currentVisual = "standingDownLeft";
									}
								break;
							}
						break;
					}
				break;
				
				case "falling":
					switch (horizontal) 
					{
						case "right":
							switch(vertical)
							{
								case "neutral":
									if (currentVisual != "fallingRight")
									{
										fallRight();
										currentVisual = "fallingRight";
									}
								break;
								
								case "up":
									if (currentVisual != "fallingUpRight")
									{
										fallUpRight();
										currentVisual = "fallingUpRight";
									}
								break;
									
								case "down":
									if (currentVisual != "fallingDownRight")
									{
										fallDownRight();
										currentVisual = "fallingDownRight";
									}
								break;
							}
						break;
						
						case "left":
							switch(vertical)
							{
								case "neutral":
									if (currentVisual != "fallingLeft")
									{
										fallLeft();
										currentVisual = "fallingLeft";
									}
								break;
								
								case "up":
									if (currentVisual != "fallingUpLeft")
									{
										fallUpLeft();
										currentVisual = "fallingUpLeft";
									}
								break;
									
								case "down":
									if (currentVisual != "fallingDownLeft")
									{
										fallDownLeft();
										currentVisual = "fallingDownLeft";
									}
								break;
							}
						break;
					}
				break;
				
				case "running":
					switch (horizontal) 
					{
						case "right":
							switch(vertical)
							{
								case "neutral":
									if (currentVisual != "runningRight")
									{
										runRight();
										currentVisual = "runningRight";
									}
								break;
								
								case "up":
									if (currentVisual != "runningUpRight")
									{
										runUpRight();
										currentVisual = "runningUpRight";
									}
								break;
									
								case "down":
									if (currentVisual != "runningUpRight")
									{
										runDownRight();
										currentVisual = "runningUpRight";
									}
								break;
							}
						break;
						
						case "left":
							switch(vertical)
							{
								case "neutral":
									if (currentVisual != "runningLeft")
									{
										runLeft();
										currentVisual = "runningLeft";
									}
								break;
								
								case "up":
									if (currentVisual != "runningUpLeft")
									{
										runUpLeft();
										currentVisual = "runningUpLeft";
									}
								break;
									
								case "down":
									if (currentVisual != "runningDownLeft")
									{
										runDownLeft();
										currentVisual = "runningDownLeft";
									}
								break;
							}
						break;
					}
				break;
			}
		}
		
		
		
		
		public function flash(invinciblityDelay:int):void
		{
			//0xFF0000 - red!
			var c:Color = new Color();
   			c.setTint (0xFF0000, 0.9);
			
			//Apply the colour to the character
   			this.transform.colorTransform = c;
			
			//Set a timer for how long the visual effect should last
			flashTimer = new Timer(invinciblityDelay,1);
			flashTimer.addEventListener(TimerEvent.TIMER_COMPLETE, stopFlash);
			//start the timer
			flashTimer.start();
		}
		
		private function stopFlash(e:TimerEvent):void
		{
			//remove the listener and timer
			flashTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,stopFlash);
			flashTimer = null;
			
			//Remove the colour
			var c:Color = new Color();
   			c.setTint (0, 0);
   			this.transform.colorTransform = c;
		}
		
		private function resetAnimation():void
		{
			//Remove the current animation
			removeChild(currentAnimation);
			currentAnimation = null;
		}
		
		public function standRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandRight();
			addChild(currentAnimation);
		}
		
		public function standLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandLeft();
			addChild(currentAnimation);
		}
		
		public function standUpRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandUpRight();
			addChild(currentAnimation);
		}
		
		public function standUpLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandUpLeft();
			addChild(currentAnimation);
		}
		
		public function standDownRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandDownRight();
			addChild(currentAnimation);
		}
		
		public function standDownLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandDownLeft();
			addChild(currentAnimation);
		}
		
		public function fallRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandRight();
			addChild(currentAnimation);
		}
		
		public function fallLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandLeft();
			addChild(currentAnimation);
		}
		
		public function fallUpRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandUpRight();
			addChild(currentAnimation);
		}
		
		public function fallUpLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandUpLeft();
			addChild(currentAnimation);
		}
		
		public function fallDownRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandDownRight();
			addChild(currentAnimation);
		}
		
		public function fallDownLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharStandDownLeft();
			addChild(currentAnimation);
		}
		
		public function runLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharRunLeft();
			addChild(currentAnimation);
		}
		
		public function runRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharRunRight();
			addChild(currentAnimation);
		}
		
		public function runUpLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharRunUpLeft();
			addChild(currentAnimation);
		}
		
		public function runUpRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharRunUpRight();
			addChild(currentAnimation);
		}
		
		public function runDownLeft():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharRunDownLeft();
			addChild(currentAnimation);
		}
		
		public function runDownRight():void
		{
			//Remove the current animation
			resetAnimation();
			//Add the correct animation
			currentAnimation = new CharRunDownRight();
			addChild(currentAnimation);
		}
	}
}