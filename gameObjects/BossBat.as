package gameObjects
{
	//Import Libraries
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class BossBat extends MovieClip
	{
		//The boss bat's x velocity
		public var xv:Number = 0;
		//The boss bat's y velocity
		public var yv:Number = 0;
		
		//The width of the boss bat
		public var w:Number;
		//The height of the boss bat
		public var h:Number;
		
		//The health of the boss bat
		public var health:int = 250;
		//The damage the boss bat inflicts
		public var damage:int = 3;
		
		//The magnitude of the boss bat's acceleration
		public var acceleration = 0.1;
		
		//The amount of exp the boss bat gives when slayed
		public var givenExp:int = 12;
		
		//A timer for how long the boss bat flashes upon getting hit
		public var flashTimer:Timer = new Timer(80, 1);
		
		//Animations used for the boss bat
		private var bossBatFlyingLeft:BossBatFlyingLeft;
		private var bossBatFlyingRight:BossBatFlyingRight;
		private var currentVisual:MovieClip;
		
		public function BossBat(xp:Number,yp:Number):void
		{
			//Set the boss bat's starting x and y coordinates to the given parameters
			this.x = xp;
			this.y = yp;
			
			//set the width
			w = this.width;
			//set the height
			h = this.height;
			
			//set the initial animation
			bossBatFlyingRight = new BossBatFlyingRight();
			addChild(bossBatFlyingRight);
			currentVisual = bossBatFlyingRight;
		}
		
		
		public function checkDirection(charX:Number):void
		{
			//if the character is to the right of the boss bat...
			if (charX > this.x)
			{
				if (bossBatFlyingLeft)
				{
					//remove any flying left animation
					removeChild(bossBatFlyingLeft);
					bossBatFlyingLeft = null;
					
					//add the flying right animation
					bossBatFlyingRight = new BossBatFlyingRight();
					addChild(bossBatFlyingRight);
					currentVisual = bossBatFlyingRight;
				}
			}
			else
			{
				if (bossBatFlyingRight)
				{
					//remove any flying right animation
					removeChild(bossBatFlyingRight);
					bossBatFlyingRight = null;
					
					//add the flying left animation
					bossBatFlyingLeft = new BossBatFlyingLeft();
					addChild(bossBatFlyingLeft);
					currentVisual = bossBatFlyingLeft;
				}
			}
		}
		
		public function flash():void
		{
			//0xFFFF00 - yellow!
			var c:Color = new Color();
   			c.setTint (0xFFFF00, 0.9);
 
			//Apply the yellow tint to the animation
   			currentVisual.transform.colorTransform = c;
			
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
   			currentVisual.transform.colorTransform = c;
		}
	}
}