package gameObjects
{
	//Import libraries
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Bat extends MovieClip
	{
		//The magnitude of acceleration of the bat
		public var acceleration:Number; 
		//The bat's x velocity
		public var xv:Number = 0;
		//The bat's y velocity
		public var yv:Number = 0;
		
		//The bat's width
		public var w:Number;
		//The bat's height
		public var h:Number;
		
		//The bat's health
		public var health:int = 30;
		//The amount of damage the bat inflicts
		public var damage:int = 1;
		//The amount of exp gained from slaying a bat
		public var givenExp:int = 3;
		
		//A timer for how long the enemy flashes upon getting hit
		public var flashTimer:Timer = new Timer(80, 1);
		
		//Animations used for the bat
		private var batFlyingLeft:BatFlyingLeft;
		private var batFlyingRight:BatFlyingRight;
		private var currentVisual:MovieClip;
		
		public function Bat(xp:Number,yp:Number):void
		{
			//Set the bat's starting x and y coordinates to the given parameters
			this.x = xp;
			this.y = yp;
			
			//set the width
			w = this.width;
			//set the height
			h = this.height;
			//set the acceleration
			acceleration = 0.075 + (Math.random() * 0.05);
			
			//set the initial animation
			batFlyingRight = new BatFlyingRight();
			addChild(batFlyingRight);
			currentVisual = batFlyingRight;
		}
		
		public function checkDirection(charX:Number):void
		{
			//if the character is to the right of the bat...
			if (charX > this.x)
			{
				if (batFlyingLeft)
				{
					//remove any flying left animation
					removeChild(batFlyingLeft);
					batFlyingLeft = null;
					
					//add the flying right animation
					batFlyingRight = new BatFlyingRight();
					addChild(batFlyingRight);
					currentVisual = batFlyingRight;
				}
			}
			else
			//if the character is to the left of the bat...
			{
				if (batFlyingRight)
				{
					//remove any flying right animation
					removeChild(batFlyingRight);
					batFlyingRight = null;
					
					//add the flying left animation
					batFlyingLeft = new BatFlyingLeft();
					addChild(batFlyingLeft);
					currentVisual = batFlyingLeft;
				}
			}
		}
		
		public function flash():void
		{
			//0xFFFF00 - yellow!
			var c:Color = new Color();
   			c.setTint (0xFFFF00, 0.9);
 
			//Apply the yellow tint to the animation
   			this.transform.colorTransform = c;
			
			//Add a timer to remove the tint after a certain amount of time
			flashTimer.addEventListener(TimerEvent.TIMER_COMPLETE,stopFlash);
			flashTimer.start();
		}
		
		private function stopFlash(e:TimerEvent):void
		{
			//remove the listener
			flashTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,stopFlash);
			flashTimer.stop();
			
			//remove the yellow tint
			var c:Color = new Color();
   			c.setTint (0, 0);
   			this.transform.colorTransform = c;
		}
	}
}