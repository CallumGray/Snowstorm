package
{
	//---IMPORT LIBRARIES---//
	import titleObjects.TitleScreen;
	import gameObjects.GameScreen;
	import pauseObjects.PauseScreen;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Main extends MovieClip
	{
		//---DECLARE OBJECTS---//
		public var titleScreen:TitleScreen;
		public var gameScreen:GameScreen;
		public var pauseScreen:PauseScreen;
		
		//---CONSTRUCTOR---//
		public function Main():void
		{
			//Makes sure the stage has loaded before executing any code 
			if(stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE,onAdd);
			}
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
			init();
		}
		
		
		//---INITIAL SUBROUTINE---//
		private function init():void
		{
			//Adds the title screen
			titleScreen = new TitleScreen();
			addChild(titleScreen);
			
			//Adds a listener for any keyboard interaction
			stage.addEventListener(KeyboardEvent.KEY_DOWN,startGame);
		}
		
		//---BEGIN THE GAME---//
		private function startGame(e:KeyboardEvent):void
		{
			//Remove the title screen along with all objects and events associated with it
			removeChild(titleScreen);
			titleScreen = null;
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,startGame);
			
			//Add the game screen
			gameScreen = new GameScreen();
			addChild(gameScreen);
			//Start checking for keyboard input for the game
			stage.addEventListener(KeyboardEvent.KEY_DOWN,gameKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,gameKeyUp);
		}
		
		
		
		//---PAUSE AND UNPAUSE THE GAME---//
		private function pauseGame():void
		{
			//if the pause screen exists, remove it, along with all events and objects associated with it
			if(pauseScreen)
			{
				//remove the pause screen and its events
				removeChild(pauseScreen);
				pauseScreen = null;
				removeEventListener(Event.ENTER_FRAME,pauseEnter);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,pauseKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP,pauseKeyUp);
				//start the game's timer
				gameScreen.gameTimer.start();
			}
			//if the pause screen doesn't exist, add the pause screen to the stage, and add events for keyboard input.
			else if(!gameScreen.gameCompleteScreen && !gameScreen.levelCompleteScreen && !gameScreen.startScreen)
			{
				//Add the paus screen
				pauseScreen = new PauseScreen();
				addChild(pauseScreen);
				//Excecute pauseEnter function each frame to check for keys being held down
				addEventListener(Event.ENTER_FRAME, pauseEnter);
				//Listen for keyboard presses and releases
				stage.addEventListener(KeyboardEvent.KEY_DOWN,pauseKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, pauseKeyUp);
				//update the visuals for the quality bar in the pause screen
				pauseScreen.updateQualityVisuals(stage.quality);
				//update the visuals for the volume bar in the pause screen
				pauseScreen.updateVolumeVisuals(gameScreen.gameSounds.soundVolume);
				//stop the game's timer
				gameScreen.gameTimer.stop();
			}
		}
		
		//---CHANGE PAUSE SCREEN MENU IF KEYBOARD INPUTS ARE HELD---//
		private function pauseEnter(e:Event):void
		{
			//If a or left are held down while the volume menu is selected, decrease it.
			if(pauseScreen.aDown || pauseScreen.leftDown)
			{
				if(pauseScreen.currentMenu == "volumeMenu")
				{
					//makes sure it doesn't decrease when at a value of 0
					if (gameScreen.gameSounds.soundVolume > 0)
					{
						//decrease the volume
						gameScreen.gameSounds.soundVolume -= 2;
						//update the visuals on the pause screen
						pauseScreen.updateVolumeVisuals(gameScreen.gameSounds.soundVolume);
						//apply the new volume to each sound
						gameScreen.gameSounds.updateVolume()
					}
				}
			}
			//If d or right are held down while the volume menu is selected, increase it.
			if(pauseScreen.dDown || pauseScreen.rightDown)
			{
				if(pauseScreen.currentMenu == "volumeMenu")
				{
					//makes sure it doesn't increase when at a value of 100
					if(gameScreen.gameSounds.soundVolume < 100)
					{
						//increase the volume
						gameScreen.gameSounds.soundVolume += 2;
						//update the visuals on the pause screen
						pauseScreen.updateVolumeVisuals(gameScreen.gameSounds.soundVolume);
						//apply the new volume to each sound
						gameScreen.gameSounds.updateVolume();
					}
				}
			}
		}
		
		//---CHANGE PAUSE SCREEN MENU IF KEYBOARD INPUTS ARE PRESSED---//
		
		//Change the currently selected menu
		private function wsUpDownPressed():void
		{
			pauseScreen.changeMenu();
		}
		
		//Decrease the quality if a or left is pressed
		private function aLeftPressed():void
		{
			if(pauseScreen.currentMenu == "qualityMenu")
			{
				if(stage.quality == "MEDIUM")
				{
					//change the quality
					stage.quality = "LOW"
					//update the visuals on the pause screen
					pauseScreen.updateQualityVisuals(stage.quality);
				}
				else if(stage.quality == "HIGH")
				{
					//change the quality
					stage.quality = "MEDIUM";
					//update the visuals on the pause screen
					pauseScreen.updateQualityVisuals(stage.quality);
				}
				else if(stage.quality == "BEST")
				{
					//change the quality
					stage.quality = "HIGH";
					//update the visuals on the pause screen
					pauseScreen.updateQualityVisuals(stage.quality);
				}
			}
		}
		
		//Increase the quality if d or right is pressed
		private function dRightPressed():void
		{
			if(pauseScreen.currentMenu == "qualityMenu")
			{
				if(stage.quality == "LOW")
				{
					//change the quality
					stage.quality = "MEDIUM"
					//update the visuals on the pause screen
					pauseScreen.updateQualityVisuals(stage.quality);
				}
				else if(stage.quality == "MEDIUM")
				{
					//change the quality
					stage.quality = "HIGH";
					//update the visuals on the pause screen
					pauseScreen.updateQualityVisuals(stage.quality);
				}
				else if(stage.quality == "HIGH")
				{
					//change the quality
					stage.quality = "BEST";
					//update the visuals on the pause screen
					pauseScreen.updateQualityVisuals(stage.quality);
				}
			}
		}
		
		//---KEYBOARD INPUT FOR GAME---//
		private function gameKeyDown(e:KeyboardEvent):void
		{
			//When a key is pushed down, change the boolean value and priority appropriately.
			switch(e.keyCode)
			{
				//a
				case 65:
				gameScreen.aDown = true;
				//Give priority to the a key
				gameScreen.aPriority = true;
				gameScreen.dPriority = false;
				break;
				
				//d
				case 68:
				gameScreen.dDown = true;
				//give priority to the d key
				gameScreen.dPriority = true;
				gameScreen.aPriority = false;
				break;
				
				//w
				case 87:
				gameScreen.wDown = true;
				break;
				
				//left
				case 37:
				gameScreen.leftDown = true;
				//give priority to the left key
				gameScreen.leftPriority = true;
				gameScreen.rightPriority = false;
				gameScreen.upPriority = false;
				gameScreen.downPriority = false;
				break;
				
				//up
				case 38:
				gameScreen.upDown = true;
				//give priority to the up key
				gameScreen.upPriority = true;
				gameScreen.leftPriority = false;
				gameScreen.rightPriority = false;
				gameScreen.downPriority = false;
				break;
				
				//right
				case 39:
				gameScreen.rightDown = true;
				//give priority to the right key
				gameScreen.rightPriority = true;
				gameScreen.leftPriority = false;
				gameScreen.upPriority = false;
				gameScreen.downPriority = false;
				break;
				
				//down
				case 40:
				gameScreen.downDown = true;
				//give priority to the down key
				gameScreen.downPriority = true;
				gameScreen.leftPriority = false;
				gameScreen.rightPriority = false;
				gameScreen.upPriority = false;
				break;
				
				//escape
				case 27:
				//Add the pause screen once the escape key is pressed.
				if(!gameScreen.escDown)pauseGame();
				gameScreen.escDown = true;
				break;
			}
		}
		
		private function gameKeyUp(e:KeyboardEvent):void
		{
			//When a key is lifted up, change the boolean value and priority appropriately.
			switch(e.keyCode)
			{
				//a
				case 65:
				gameScreen.aDown = false;
				//give priority to the d key
				gameScreen.aPriority = false;
				gameScreen.dPriority = true;
				break;
				
				//d
				case 68:
				gameScreen.dDown = false;
				//give priority to the a key
				gameScreen.dPriority = false;
				gameScreen.aPriority = true;
				break;
				
				//w
				case 87:
				gameScreen.wDown = false;
				break;
				
				//left
				case 37:
				gameScreen.leftDown = false;
				gameScreen.leftPriority = false;
				break;
				
				//up
				case 38:
				gameScreen.upDown = false;
				gameScreen.upPriority = false;
				break;
				
				//right
				case 39:
				gameScreen.rightDown = false;
				gameScreen.rightPriority = false;
				break;
				
				//down
				case 40:
				gameScreen.downDown = false;
				gameScreen.downPriority = false;
				break;
				
				//escape
				case 27:
				gameScreen.escDown = false;
				break;
			}
		}
		
		private function pauseKeyDown(e:KeyboardEvent):void
		{
			//When a key is pushed down, change the boolean value and priority appropriately.
			switch(e.keyCode)
			{
				//if a is not being held down, a is pressed
				case 65:
				if(!pauseScreen.aDown)aLeftPressed();
				pauseScreen.aDown = true;
				break;
				
				//if d is not being held down, d is pressed
				case 68:
				if(!pauseScreen.dDown)dRightPressed();
				pauseScreen.dDown = true;
				break;
				
				//if w is not being held down, w is pressed
				case 87:
				if(!pauseScreen.wDown)wsUpDownPressed();
				pauseScreen.wDown = true;
				break;
				
				//if s is not being held down, s is pressed
				case 83:
				if(!pauseScreen.sDown)wsUpDownPressed();
				pauseScreen.sDown = true;
				break;
				
				//if left is not being held down, left is pressed
				case 37:
				if(!pauseScreen.leftDown)aLeftPressed();
				pauseScreen.leftDown = true;
				break;
				
				//if up is not being held down, up is pressed
				case 38:
				if(!pauseScreen.upDown)wsUpDownPressed();
				pauseScreen.upDown = true;
				break;
				
				//if right is not being held down, right is pressed
				case 39:
				if(!pauseScreen.rightDown)dRightPressed();
				pauseScreen.rightDown = true;
				break;
				
				//if down is not being held down, down is pressed
				case 40:
				if(!pauseScreen.downDown)wsUpDownPressed();
				pauseScreen.downDown = true;
				break;
			}
		}
		
		private function pauseKeyUp(e:KeyboardEvent):void
		{
			//When a key is lifted up, change the boolean value and priority appropriately.
			switch(e.keyCode)
			{
				//a
				case 65:
				pauseScreen.aDown = false;
				break;
				
				//d
				case 68:
				pauseScreen.dDown = false;
				break;
				
				//w
				case 87:
				pauseScreen.wDown = false;
				break;
				
				//s
				case 83:
				pauseScreen.sDown = false;
				break;
				
				//left
				case 37:
				pauseScreen.leftDown = false;
				break;
				
				//up
				case 38:
				pauseScreen.upDown = false;
				break;
				
				//right
				case 39:
				pauseScreen.rightDown = false;
				break;
				
				//down
				case 40:
				pauseScreen.downDown = false;
				break;
			}
		}
	}
}