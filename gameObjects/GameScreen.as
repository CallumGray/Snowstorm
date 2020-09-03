package gameObjects
{
	//---IMPORT LIBRARIES---//
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameObjects.levels.Lv1;
	import gameObjects.levels.Lv2;
	import gameObjects.levels.Lv3;
	import gameObjects.levels.Lv4;
	import gameObjects.levels.Lv5;
	import gameObjects.levels.Lv6;
	
	public class GameScreen extends MovieClip
	{
		
		//---------------GLOBAL VARIABLES---------------//
		
		//---SCREENS TO BE ADDED FROM THE GAMESCREEN---//
		public var startScreen:StartScreen;
		public var levelCompleteScreen:LevelCompleteScreen;
		public var gameCompleteScreen:GameCompleteScreen;
		
		//---SOUND EFFECTS AND MUSIC---//
		public var gameSounds:GameSounds = new GameSounds();
		
		//---CAMERA AND TIMER---//
		private var camera:Cam;
		public var gameTimer:Timer;
		
		//---ADDING LEVELS---//
		
		//The current level the player is on
		public var currentLevel:int = 1;
		//An array containing a string for each object that can be added to the stage
		private var objectDatabase:Array = ["platform", "cloud", "cage", "bat", "bossBat"];
		//Array containing a class for each level
		private var levelFileArray:Array = [Lv1,Lv2,Lv3,Lv4,Lv5,Lv6];
		
		//----GAME OBJECTS------//
		private var char:Char;
		private var platform:Platform;
		private var platformArray:Array=[];
		private var cage:Cage;
		private var cageArray:Array=[];
		private var cloud:Cloud;
		private var cloudArray:Array=[];
		private var bat:Bat;
		private var batArray:Array=[];
		private var bossBat:BossBat;
		private var bossBatArray:Array = [];
		private var snowball:Snowball;
		private var snowballExplode:SnowballExplode;
		private var snowballArray:Array=[];
		private var penguin:Penguin;
		private var penguinArray:Array = [];
		private var death:Death;
		private var background:Background;
		
		//---GAMEPLAY VARIABLES---//
		
		//The acceleration applied to objects that can fall (character/penguin)
		private var gravity:Number = 0.5;
		//The fastest an object can fall
		private var terminalVelocity:Number = 10;
		//The velocity applied to the character upon jumping
		private var jumpVelocity:Number = -12;
		//A boolean used when testing if the character is touching the ground or not
		private var touchingGround:Boolean;
		//The acceleration applied to the character when running
		private var runAcceleration:Number = 0.3;
		//The rate at which the character slows down when on the ground (lower is a more sudden decrease)
		private var friction:Number = 0.90;
		//The accelration applied to the character when moving in the air
		private var airAcceleration:Number = 0.2;
		//The rate at which the character slows down when in the air (lower is a more sudden decrease)
		private var airResistance:Number = 0.95;
		//The fastest the character can run
		private var xCharCap:Number = 6;
		
		//Boolean used when testing invincibility
		private var invincible:Boolean = false;
		//Timer for how long the character stays invincible
		private var invincibilityTimer:Timer;
		private var invincibilityDelay:int = 500;
		
		//Character's health
		private var health:int = 10;
		//The health given at the start of the level
		private var startingHealth:int = health;
		//The Lv of the character, which determines its strength
		private var currentLv:int = 1;
		//The total amount of experience the character has
		private var totalExp:int = 0;
		//The amount of experience the character had at the start of the level
		private var startingExp:int = 0;
		
		//The maginitude of acceleration for each bat
		private var batAcceleration:Number = 0.1;
		//The maxiumum speed a bat can travel horizontally
		private var xBatCap:Number = 8;
		//The maximum speed a bat can travel vertically
		private var yBatCap:Number = 8;
		
		//The speed at which a snowball travels
		private var snowballSpeed:Number = 12;
		//The damage that a snowball does to an enemy or cage
		private var snowballDamage:int = 3;
		
		//Timer used to give a delay between each shot
		private var gunDelay:int = 150;
		private var gunTimer:Timer;
		//Boolean used to test if the character is ready to fire or not
		private var gunReady:Boolean = true;
		
		//HUD
		//Bar used to show the character's health
		private var healthBar:HealthBar;
		private var healthBarEmpty:HealthBarEmpty;
		//Bar used to show the character's experience
		private var expBar:ExpBar;
		private var expBarEmpty:ExpBarEmpty;
		//Value showing the character's Lv
		private var lvDisplay:LvDisplay
		
		//KEYBOARD
		//Booleans used when testing the keyboard
		public var escDown:Boolean = false;
		public var aDown:Boolean = false;
		public var dDown:Boolean = false;
		public var wDown:Boolean = false;
		public var upDown:Boolean = false;
		public var downDown:Boolean = false;
		public var leftDown:Boolean = false;
		public var rightDown:Boolean = false;
		//Priority booleans used when multiple keys are pressed to determine which one should take precedence
		public var aPriority:Boolean = false;
		public var dPriority:Boolean = false;
		public var leftPriority:Boolean = false;
		public var rightPriority:Boolean = false;
		public var upPriority:Boolean = false;
		public var downPriority:Boolean = false;
		
		
		
		//-------------------------------------------------------//
		
		//-----------------INITIALISATION------------------------//
		
		//-------------------------------------------------------//
	
		public function GameScreen():void
		{
			//Adds the first level
			addLevel(currentLevel);
			
			//Creates a game timer that executes every 1/60th of a second
			gameTimer = new Timer(16.6,0);
			gameTimer.addEventListener(TimerEvent.TIMER,gameTick);
		}
		
		
		
		
		
		
		//--------------------------------------------//
		
		//--------------GAME CONTROL TIMER------------//
		
		//--------------------------------------------//
		
		
		//Function to be executed every 1/60th of a second
		private function gameTick(e:TimerEvent):void
		{
			//------------OBJECT CONTROL-----------------//
			
			//Objects Move
			characterMovement();
			batMovement();
			bossBatMovement();
			penguinMovement();
			
			//Character shoots
			shooting();
			
			//Snowball Movement
			snowballMovement();
			
			//---block colliding with objects---//
			blockCollision(char);
			cloudCollision(char);
			//tests each bat
			for (var b:int = 0; b < batArray.length; b++)blockCollision(batArray[b]);
			//tests each bossbat
			for (var bb:int = 0; bb < bossBatArray.length; bb++)blockCollision(bossBatArray[bb]);
			//tests each penguin
			for (var pe:int = 0; pe < penguinArray.length; pe++)
			{
				blockCollision(penguinArray[pe]);
				cloudCollision(penguinArray[pe]);
			}
			
			//Move the background
			backgroundMovement();
			
			//Update the camera position
			camera.x = char.x - 400 + char.w / 2;
			camera.y = char.y - 225 + char.h / 2;
						
			//Snowball hitting objects//			
			snowballBatCollision();
			snowballBossBatCollision();
			snowballPlatformCollision();
			snowballCageCollision();
			
			//Character colliding with enemies
			charBatCollision();
			charBossBatCollision();
			
			//Update the HUD
			updateHud();
			
			//Update the camera
			camera.update();
		}				

		
		
		
		//--------------------------------------------//
		
		//-------------ADDING OBJECTS-----------------//
		
		//--------------------------------------------//
		
		//--------------ADD LEVEL -------------------//
		
		public function addLevel(curLvl:int):void
		{
			//If the current level number is less than or equal to the total amount of levels
			if(currentLevel <= levelFileArray.length)
			{
				//Find the current level from an external file
				var tempLvl:Object = new levelFileArray[curLvl-1](); 

				//Extract the level array from the file
				var levelArray:Array = tempLvl.levelArray;
				
				//Extract the spawn points of the character from the file
				var spawnX:Number = tempLvl.spawnX;
				var spawnY:Number = tempLvl.spawnY;
				
				//Extract the level's name from the file
				var levelName:String = tempLvl.levelName;
				
				//Add the camera to the stage
				addCamera();
				
				//Add the background
				background = new Background();
				addChild(background);
				
				//Add the character at the spawn point
				char = new Char(spawnX, spawnY);
				addChild(char);
				
				//Set the character's gun to be ready
				gunReady = true;
				
				//Test each object in the level array
				for(var i:int=0;i<levelArray.length;i++)
				{
					//The object's type is the first field in the obejct's array
					var objectType:String = objectDatabase[levelArray[i][0]];
					
					//Check the type of the object and add it
					switch (objectType)
					{
						//Add Platform
						case "platform":
						platform = new Platform(levelArray[i][1],levelArray[i][2],levelArray[i][3],levelArray[i][4]);
						platformArray.push(platform);
						addChild(platform);
						break;
						
						//Add Cloud
						case "cloud":
						cloud = new Cloud(levelArray[i][1],levelArray[i][2],levelArray[i][3]);
						cloudArray.push(cloud);
						addChild(cloud);
						break;
						
						//Add Cage
						case "cage":
						cage = new Cage(levelArray[i][1],levelArray[i][2]);
						cageArray.push(cage);
						addChild(cage);
						break;
						
						//Add Bat
						case "bat":
						bat = new Bat(levelArray[i][1],levelArray[i][2]);
						batArray.push(bat);
						addChild(bat);
						break;
						
						//Add Boss Bat
						case "bossBat":
						bossBat = new BossBat(levelArray[i][1],levelArray[i][2]);
						bossBatArray.push(bossBat);
						addChild(bossBat);
						break;
					}
				}
				
				//If the level has changed, then change the music
				if(gameSounds.currentMusic != tempLvl.musicIndex)gameSounds.playMusic(tempLvl.musicIndex);
				
				//Add the HUD
				addHud();
				
				//Add the start screen, with the appropriate level name
				addStartScreen(levelName);
			}
			
			//If the current level is greater than the amount of levels then show the game complete screen
			else
			{
				gameCompleteScreen = new GameCompleteScreen();
				addChild(gameCompleteScreen);
			}
		}
		
		
		//---------------ADD PENGUIN---------------//
		private function addPenguin(xp:Number,yp:Number):void
		{
			penguin = new Penguin(xp,yp);
			penguinArray.push(penguin);
			addChild(penguin);
		}
		
		//---------------ADD CAMERA------------------//
		private function addCamera():void
		{
			camera = new Cam();
			addChild(camera);
		}
		
		//-------------ADD HUD---------------------//
		private function addHud():void
		{
			lvDisplay = new LvDisplay();
			healthBarEmpty = new HealthBarEmpty();
			expBarEmpty = new ExpBarEmpty();
			healthBar = new HealthBar();
			expBar = new ExpBar();
			addChild(lvDisplay);
			addChild(healthBarEmpty);
			addChild(expBarEmpty);
			addChild(healthBar);
			addChild(expBar);
		}
		
		//---------------ADD SNOWBALL----------------------//
		private function addSnowball(xp:Number,yp:Number,xv:Number,yv:Number,damage:int):void
		{
			snowball = new Snowball(xp,yp,xv,yv,damage);
			snowballArray.push(snowball);
			addChild(snowball);
		}
		
		//--------------ADD START SCREEN----------//
		private function addStartScreen(levelNames):void
		{
			startScreen = new StartScreen(levelNames);
			startScreen.screenTimer.addEventListener(TimerEvent.TIMER_COMPLETE,startLevel);
			addChild(startScreen);
		}
		
		//--------ADD LEVEL COMPLETE SCREEN---------//
		private function addLevelCompleteScreen(bonusExp:int):void
		{
			levelCompleteScreen = new LevelCompleteScreen(bonusExp);
			levelCompleteScreen.screenTimer.addEventListener(TimerEvent.TIMER_COMPLETE,afterLevelCompleteScreen);
			addChild(levelCompleteScreen);
		}
		
		
		//-----------ADD DEATH ANIMATION-----------//
		private function addDeath(xp:Number,yp:Number):void
		{
			death = new Death(xp,yp);
			addChild(death);
		}
		
		//----------ADD SNOWBALL BURST---------//
		private function addSnowballExplode(xp:Number,yp:Number):void
		{
			snowballExplode = new SnowballExplode(xp, yp);
			addChild(snowballExplode);
		}
		
		//--------------------------------------------//
		
		//-------------REMOVING OBJECTS---------------//
		
		//--------------------------------------------//
		
		//---------REMOVE START SCREEN AND START THE GAME------------//
		private function startLevel(e:TimerEvent):void
		{
			removeChild(startScreen);
			startScreen = null;
			gameTimer.start();
		}		
		
		//---------REMOVE THE CHARACTER----------//
		private function removeChar():void
		{
			removeChild(char);
			char = null;
		}
		
		//-------REMOVE BAT-----------//
		
		private function removeBat(b:int):void
		{
			removeChild(batArray[b]);
			batArray.splice(b,1);
		}
		
		//-------REMOVE BOSS BAT------//
		private function removeBossBat(bb:int):void
		{
			removeChild(bossBatArray[bb]);
			bossBatArray.splice(bb,1);
		}
		
		//-------REMOVE CAGE---------------//
		private function removeCage(c:int):void
		{
			removeChild(cageArray[c]);
			cageArray.splice(c,1);
		}
		
		//---------------REMOVE SNOWBALL----------------------//		
		private function removeSnowball(s:int):void
		{
			//If the snowball exists, add a snowball burst animation and remove the snowball
			if (snowballArray[s])
			{	
				addSnowballExplode(snowballArray[s].x, snowballArray[s].y);
				removeChild(snowballArray[s]);
				snowballArray.splice(s,1);
			}
		}
		
		//-----------REMOVE A PLATFORM-------------//
		private function removePlatform(p:int):void
		{
			removeChild(platformArray[p]);
			platformArray.splice(p,1);
		}
		
		private function removeCamera():void
		{
			removeChild(camera);
			camera = null;
		}
		
		//----------REMOVE THE HUD------------//
		private function removeHud():void
		{
			removeChild(expBarEmpty);
			removeChild(expBar);
			removeChild(healthBarEmpty);
			removeChild(healthBar);
			removeChild(lvDisplay);
			
			expBarEmpty = null;
			expBar = null;
			healthBarEmpty = null;
			healthBar = null;
			lvDisplay = null;
		}
		
		//------REMOVE BACKGROUND-----//
		private function removeBackground():void
		{
			if(background)
			{	
				removeChild(background);
				background = null;
			}
		}
		
		
		//--------REMOVE EVERYTHING-------
		private function removeLevel():void
		{
			//stop the game timer
			gameTimer.stop();
			
			//Remove all objects and clear all arrays
			
			if(char)removeChar();
			removeBackground();
			removeCamera();
			removeHud();
			
			for(var s:int = 0;s<snowballArray.length;s++)removeChild(snowballArray[s]);
			snowballArray.splice(0,snowballArray.length);
			
			for(var b:int = 0;b<batArray.length;b++)removeChild(batArray[b]);
			batArray.splice(0,batArray.length);
			
			for(var bb:int = 0;bb<bossBatArray.length;bb++)removeChild(bossBatArray[bb]);
			bossBatArray.splice(0,bossBatArray.length);
			
			for(var p:int = 0;p<platformArray.length;p++)removeChild(platformArray[p]);
			platformArray.splice(0,platformArray.length);
			
			for(var c:int = 0;c<cageArray.length;c++)removeChild(cageArray[c]);
			cageArray.splice(0,cageArray.length);
			
			for(var cl:int = 0;cl<cloudArray.length;cl++)removeChild(cloudArray[cl]);
			cloudArray.splice(0, cloudArray.length);
			
			for (var pe:int = 0; pe < penguinArray.length; pe++) removeChild(penguinArray[pe]);
			penguinArray.splice(0, penguinArray.length);
		}
		
		
		
		// -------------------------------------------//
		
		//--------------OBJECT DAMAGE----------------//
		
		//-------------------------------------------//
		
		
		//---------DAMAGE CHAR-------------//
		private function damageChar(damage:int):void
		{
			//Decrease the health by the given damage
			health -= damage;
			//Update the HUD
			updateHud();
			
			//If health fully depleted, then add the death animation
			if (health <= 0)
			{
				//set health to 0
				health = 0;
				//remove the character and add a death animation
				charDeath();
				//play a sound effect
				gameSounds.playCharKilled();
			}
			//If health not fully depleted then make the character invincible
			else
			{
				//start the invincibility
				invincibilityStart();
				//apply a visual effect to the character for the length of the invinciblity
				char.flash(invincibilityDelay);
				//play a sound effect
				gameSounds.playCharHit();
			}
		}
		
		//---------CHAR HEALTH DEPLETED-----------//
		private function charDeath():void
		{
			//Stop the game's timer
			gameTimer.stop();
			//reset health
			health = startingHealth;
			//Drop exp back to starting value
			totalExp = startingExp;
			decreaseLv();
			
			//Add a death animation
			death = new Death(char.x, char.y);
			//give a timer to the death, after which the level will restart
			death.deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE,afterCharDeath);
			addChild(death);
			
			//Remove the character
			removeChar();
		}
		private function afterCharDeath(e:TimerEvent):void
		{
			//reset the level
			removeLevel();
			addLevel(currentLevel);
		}
		
		
		//---------DAMAGE BAT-------------//
		private function damageBat(damage:int,batIndex:int)
		{
			//Decrease the bat's health
			batArray[batIndex].health -= damage;
			trace("Bat" + (batIndex + 1) + ": " + batArray[batIndex].health);
			
			//If the bat's health is less than 0, remove it and increase experience
			if(batArray[batIndex].health <= 0)
			{
				//play a sound effect
				gameSounds.playBatKilled();
				//increase the character's experience and update the character's Lv
				totalExp += batArray[batIndex].givenExp;
				increaseLv();
				//add a death animation to the bat's position
				addDeath(batArray[batIndex].x, batArray[batIndex].y);
				//remove the bat
				removeBat(batIndex);
			}
			//If the bat is not yet defeated, play a sound effect
			else
			{
				gameSounds.playBatHit();
			}
		}
		
		//-----------DAMAGE BOSS BAT-----//
		private function damageBossBat(damage:int,batIndex:int)
		{
			//Decrease the boss bat's health
			bossBatArray[batIndex].health -= damage;
			trace("Bat" + (batIndex + 1) + ": " + bossBatArray[batIndex].health);			
			
			//If the boss bat's health reaches 0 then increase experience and remove it
			if(bossBatArray[batIndex].health <= 0)
			{
				//If all boss bats have been defeated
				if(bossBatArray.length == 1)
				{
					//add a timer to one of the death animations that will add the next level
					death = new Death(bossBatArray[batIndex].x + (Math.random()*100),bossBatArray[batIndex].y + (Math.random()*100));
					death.deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE,levelComplete);
					//add the death animation
					addChild(death);
					
					//Adds multiple death animations for a large explosion effect
					for (var i:int = 0; i < 10; i++)
					{
						//Animations spawned at random points around the bat
						death = new Death(bossBatArray[batIndex].x + (Math.random()*100),bossBatArray[batIndex].y + (Math.random()*100));
						addChild(death);
					}
				}
				else
				{
					//Adds multiple death animations for a large explosion effect
					for (var j:int = 0; j < 10; j++)
					{
						//Animations spawned at random points around the bat
						death = new Death(bossBatArray[batIndex].x + (Math.random()*100),bossBatArray[batIndex].y + (Math.random()*100));
						addChild(death);
					}
				}
				
				//play a sound effect
				gameSounds.playBatKilled();
				//increase the character's experience by the given exp and update the character's Lv
				totalExp += bossBatArray[batIndex].givenExp;
				increaseLv();
				//remove the boss bat
				removeBossBat(batIndex);
			}
			//If the boss bat hasn't been defeated, play a sound effect
			else
			{
				gameSounds.playBatHit();
			}
		}
		
		
		//----------DAMAGE CAGE-------------//
		private function damageCage(damage:int,cageIndex:int)
		{
			//Decrease the health of the cage
			cageArray[cageIndex].health -= damage;
			
			//If the cage has been defeated
			if(cageArray[cageIndex].health <= 0)
			{
				//If all cages have been defeated
				if(cageArray.length == 1)
				{
					//Add an event to the death animation to complete the level
					death = new Death(cageArray[cageIndex].x,cageArray[cageIndex].y);
					death.deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE, levelComplete);
					//Add the death animation
					addChild(death);
				}
				//If not the last cage, add a death animation
				else
				{
					addDeath(cageArray[cageIndex].x,cageArray[cageIndex].y);
				}
				
				//Add a penguin to the stage
				addPenguin(cageArray[cageIndex].x, cageArray[cageIndex].y);
				
				//Increase experience , update the character's Lv, and remove the cage, while 
				totalExp += cageArray[cageIndex].givenExp; 
				increaseLv();
				removeCage(cageIndex);
				//Play a sound effect
				gameSounds.playCageDestroyed();
			}
			//If the cage hasn't been defeated play a sound effect
			else 
			{
				gameSounds.playBlockHit();
			}
		}
		
		//-------LEVEL COMPLETED-----//
		private function levelComplete(e:TimerEvent):void
		{
			//Stops the game timer and music
			gameTimer.stop();
			gameSounds.stopMusic();
			//Play a sound effect signalling that the level has been completed
			gameSounds.playLevelCompleteSFX();
			
			//Calculates the bonus experience
			var bonusExp = calculateBonusExp();
			
			//Adds the bonus exp to total experience and calculates the lv
			totalExp += bonusExp;
			increaseLv();
			
			//removes the old level
			removeLevel();
			
			//Adds the level complete screen (with the amount of bonus exp gained
			addLevelCompleteScreen(bonusExp);	
		}
		private function afterLevelCompleteScreen(e:TimerEvent):void
		{
			//Remove the level complete screen
			removeChild(levelCompleteScreen);
			levelCompleteScreen = null;
			
			//Increase the current level
			currentLevel += 1;
			//Reset starting experience
			startingExp = totalExp;
			//Reset health
			health = startingHealth;
			//add the new level
			addLevel(currentLevel);
		}
		
		//------------INVINCIBILITY----------------//
		private function invincibilityStart():void
		{
			//Create a timer for the invincibility
			invincibilityTimer = new Timer(invincibilityDelay,1);
			invincibilityTimer.addEventListener(TimerEvent.TIMER_COMPLETE,invincibilityStop);
			invincibilityTimer.start();
			//Set invincible to true
			invincible = true;
		}
		
		private function invincibilityStop(e:TimerEvent):void
		{
			//remove the timer for invincibility
			invincibilityTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,invincibilityStop);
			invincibilityTimer = null;
			//Set invincible to false
			invincible = false;
		}
		

		
		// -------------------------------------------//
		
		//-------------HEALTH/EXPERIENCE--------------//
		
		//-------------------------------------------//
		
		//---UPDATE THE HUD---//
		private function updateHud():void
		{
			//Update each object in the HUD to display the correct values
			//Alter each objects position so the HUD remains in the top left corner
			
			lvDisplay.x = camera.x;
			lvDisplay.y = camera.y;
			lvDisplay.currentLvText.text = currentLv.toString();
			
			healthBarEmpty.x = camera.x;
			healthBarEmpty.y = camera.y + lvDisplay.height;
			
			expBarEmpty.x = camera.x + healthBar.width;
			expBarEmpty.y = camera.y + lvDisplay.height;
			
			healthBar.x = camera.x;
			healthBar.height = healthBarEmpty.height * health/startingHealth;
			healthBar.y = healthBarEmpty.y + (healthBarEmpty.height - healthBar.height);
			
			expBar.x = healthBar.x + healthBar.width;
			
			expBar.height = expBarEmpty.height * (totalExp - calculateExpToReachLv(currentLv)) /
			(calculateExpToReachLv(currentLv + 1) - calculateExpToReachLv(currentLv));
			
			expBar.y = expBarEmpty.y + (expBarEmpty.height - expBar.height);
		}
		
		//Checks for an increase in Lv
		private function increaseLv():void
		{
			//if the experience to reach the next lv is less than the total exp, increase the lv
			//loop required for large experience games that cover multiple increases in lv's
			while(calculateExpToReachLv(currentLv+1) < totalExp)
			{
				currentLv += 1;
			}
			
			//Change the damage of the snowball
			snowballDamage = (3 + (currentLv - 1));
		}
		
		//Puts the lv back down to the value at the start of the level
		private function decreaseLv():void
		{
			while(calculateExpToReachLv(currentLv) > totalExp)
			{
				currentLv -= 1;
			}
			
			//Change the damage of the snowball
			snowballDamage = (3 + (currentLv - 1));
		}
		
		//Calculates the experience needed to reach a lv
		private function calculateExpToReachLv(lv:int):int
		{
			var experience:int = 0;
			
			for(var i:int = 1; i<=lv;i++)
			{
				//experience for each level is 10
				experience += 10 * (i-1);
			}
			
			return experience;
		}
		
		//Calculates the bonus experience gained at the end of the level
		private function calculateBonusExp():int
		{
			//experience is calculated by the amount of health remaining at the end of the level
			var bonusExp:int = Math.floor(10*health/startingHealth);
			return bonusExp;
		}
		
		
		// -------------------------------------------//
		
		//---------------OBJECT MOVEMENT--------------//
		
		//-------------------------------------------//
		
		
		//----CHARACTER MOVEMENT-----//
		
		private function characterMovement():void
		{
			//Increase the character's y velocity by gravity
			char.yv += gravity;
			
			//if the character is touching the ground, then...
			if(testTouchingGround(char))
			{
				if(dDown && dPriority)
				{
					//Accelerate the character to the right
					char.xv += runAcceleration;
					//Apply the approrpriate animation
					if(gunReady && !leftDown)char.horizontal = "right";
				}
				
				if(aDown && aPriority)
				{
					//Accelerate the character to the left
					char.xv -= runAcceleration;
					//Apply the appropriate animation
					if(gunReady && !rightDown)char.horizontal = "left";
				}
				
				if(!aDown && !dDown)
				{
					//Apply friction
					char.xv *= friction;
				}
				
				if(wDown)
				{
					//Make the character jump
					char.yv = jumpVelocity;
				}
				
				//Stop the character if travelling at slow velocities
				if (Math.abs(char.xv) < 0.1)char.xv = 0;
				
				//If the character is moving slowly, treat it as standing
				if(Math.abs(char.xv) < 1)
				{
					char.state = "standing";
				}
				//Otherwise treat it as running
				else
				{
					char.state = "running";
				}
			}
			//if the character is in the air....
			else
			{
				//treat them as falling
				char.state = "falling";
				
				if(dDown && dPriority)
				{
					//Accelerate them to the right
					char.xv += airAcceleration;
					//Give the appropriate animation
					if(gunReady && !leftDown)char.horizontal = "right";
				}
				else if(aDown && aPriority)
				{
					//Accelerate them to the left
					char.xv -= airAcceleration;
					//Give the appropriate animation
					if(gunReady && !rightDown)char.horizontal = "left";
				}
				else
				{
					//Apply air resistance to them
					char.xv *= airResistance;
				}
			}
			
			//update the animations of the character
			char.updateVisuals();
			
			//Apply the maximum speeds at which the character can move
			if(char.xv > xCharCap)char.xv = xCharCap;
			if(char.xv < -xCharCap)char.xv = -xCharCap;
			if(char.yv > terminalVelocity)char.yv = terminalVelocity;
			
			//Move the character
			char.x += char.xv;
			char.y += char.yv;
		}
		
		
		//-----BACKGROUND MOVEMENT---//
		private function backgroundMovement():void
		{
			//Make the background follow the character
			background.x = char.x - 400;
			background.y = char.y - 225;
		}
		
		//----PENGUIN MOVEMENT---//
		private function penguinMovement():void
		{
			//Test each penguin
			for (var pe:int = 0; pe < penguinArray.length; pe++)
			{
				//If the velocity is less than 1 (Which will occur when the penguin hits a wall) then change direction
				if (Math.abs(penguinArray[pe].xv) < 1)
				{
					//FACE RIGHT
					if (penguin.facingLeft)
					{
						//Push the penguin out of the wall
						penguinArray[pe].x += 5;
						//Apply the correct velocity to the penguin
						penguinArray[pe].xv = 1;
						//Apply the correct animation
						penguinArray[pe].facingLeft = false;
						penguinArray[pe].walkRight();
					}
					else
					//FACE LEFT
					{
						//Push the penguin out of the wall
						penguinArray[pe].x -= 5;
						//Apply the correct velocity to the penguin
						penguinArray[pe].xv = -1;
						//Apply the correct animation
						penguinArray[pe].facingLeft = true;
						penguinArray[pe].walkLeft();
					}
				}
				
				//if the penguin is touching the ground...
				if (testTouchingGround(penguinArray[pe]))
				{
					if (penguinArray[pe].facingLeft)
					{
						//Apply the correct animation
						penguinArray[pe].walkLeft();
					}
					else
					{
						//Apply the correct animation
						penguinArray[pe].walkRight();
					}
				}
				//if the penguin is in the air then start to fall
				else
				{
					if (penguinArray[pe].facingLeft)
					{
						//Apply the correct animation
						penguinArray[pe].fallingLeft();
					}
					else 
					{
						//Apply the correct animation
						penguinArray[pe].fallingRight();
					}
					
					//Apply gravity to the penguin to make it fall
					penguinArray[pe].yv += gravity;
				}
				
				//Apply maximum fall speed of the penguin
				if (penguinArray[pe].yv > terminalVelocity)	penguinArray[pe].yv = terminalVelocity;
				
				//Move the penguin horizontally
				penguinArray[pe].x += penguinArray[pe].xv;
				//Move the penguin vertically
				penguinArray[pe].y += penguinArray[pe].yv;
			}
		}
		
		//-----TEST IF THE OBJECT IS TOUCHING THE GROUND-----//
		private function testTouchingGround(obj:MovieClip):Boolean
		{
			//Create a rectangle positioned at the bottom of the object
			var objRectBot:Rectangle = new Rectangle(obj.x,obj.y + obj.h,obj.w,2);
			var tempTouchingGround:Boolean = false;
			
			//Make an array with each platform/cage/cloud
			var blockArray:Array = [];
			
			for(var p:int = 0;p<platformArray.length;p++)
			{
				blockArray.push(platformArray[p]);
			}
			for(var cl:int = 0;cl<cloudArray.length;cl++)
			{
				blockArray.push(cloudArray[cl]);
			}
			
			for(var c:int = 0;c<cageArray.length;c++)
			{
				blockArray.push(cageArray[c]);
			}
			
			//Check if the bottom of the object intersects with any of the clouds/cages/platforms
			for(var b:int = 0;b<blockArray.length;b++)
			{
				var blockRect:Rectangle = new Rectangle(blockArray[b].x, blockArray[b].y, blockArray[b].w, blockArray[b].h);
				
				//set touching ground to true if it intersects
				if(objRectBot.intersects(blockRect))
				{
					tempTouchingGround = true;
				}
			}
			
			//Return value of temp touching ground
			return tempTouchingGround;
		}
		
		//---------BAT MOVEMENT---------//
		
		private function batMovement():void
		{
			//Check each bat on screen
			for(var i:int=0;i<batArray.length;i++)
			{
				//Find the velocity of the bat based on it's position and apply it
				batArray[i].xv += calculateBatX(batArray[i].x,batArray[i].y,batArray[i].xv,batArray[i].yv,batArray[i].acceleration);
				batArray[i].yv += calculateBatY(batArray[i].x,batArray[i].y,batArray[i].xv,batArray[i].yv,batArray[i].acceleration);
				
				//Apply maximum speeds to the bat
				if(batArray[i].xv > xBatCap)batArray[i].xv = xBatCap;
				if(batArray[i].xv < -xBatCap)batArray[i].xv = -xBatCap;
				if(batArray[i].yv > yBatCap)batArray[i].yv = yBatCap;
				if(batArray[i].yv < -yBatCap)batArray[i].yv = -yBatCap;
				
				//Move the bat
				batArray[i].x += batArray[i].xv;
				batArray[i].y += batArray[i].yv;
				
				//Update the direction that the bat is facing
				batArray[i].checkDirection(char.x);
			}
		}
		
		//---BOSS BAT MOVEMENT----//
		private function bossBatMovement():void
		{
			//Loop used to check each boss bat on screen
			for(var i:int=0;i<bossBatArray.length;i++)
			{
				//Find the velocity of the bat based on it's position and apply it
				bossBatArray[i].xv += calculateBatX(bossBatArray[i].x, bossBatArray[i].y, bossBatArray[i].xv,
				bossBatArray[i].yv,bossBatArray[i].acceleration);
				bossBatArray[i].yv += calculateBatY(bossBatArray[i].x, bossBatArray[i].y, bossBatArray[i].xv,
				bossBatArray[i].yv,bossBatArray[i].acceleration);
				
				//Apply maximum speeds to the boss bat
				if(bossBatArray[i].xv > xBatCap)bossBatArray[i].xv = xBatCap;
				if(bossBatArray[i].xv < -xBatCap)bossBatArray[i].xv = -xBatCap;
				if(bossBatArray[i].yv > yBatCap)bossBatArray[i].yv = yBatCap;
				if(bossBatArray[i].yv < -yBatCap)bossBatArray[i].yv = -yBatCap;
				
				//Move the boss bat
				bossBatArray[i].x += bossBatArray[i].xv;
				bossBatArray[i].y += bossBatArray[i].yv;
				
				//Update the direction that the boss bat is facing
				bossBatArray[i].checkDirection(char.x);
			}
		}
		
		//-------CALCULATE THE ACCELERATION FOR THE BAT---------//
		private function calculateBatX(batX:Number,batY:Number,batXV:Number,batYV:Number,batAccel:Number):Number
		{
			//Find the distance between the bat and the character
			var distanceX:Number = Math.abs(batX - char.x);
			var distanceY:Number = Math.abs(batY - char.y);
			
			//If the bat is ahead of the character by less than 800 pixels, don't accelerate the bat
			if ((batX - char.x) > 800)return 0;
			
			//If the bat is within 1 pixel of the character, continue accelerating at the same rate.
			if(distanceX < 1)return batAccel;
			//Otherwise, find the angle between the bat and the character
			else var angle:Number = Math.atan(distanceY/distanceX);
			
			//Using the angle, find out what proportion of the acceleration 
			//to distribute to the horizontal plane.
			if(batX > char.x)
			{
				if(batXV >= 0)
				{
					return -batAccel * Math.cos(angle) * 2;
				}
				else
				{
					return -batAccel * Math.cos(angle);
				}
			}
			else
			{
				if(batXV <= 0)
				{
					return batAccel * Math.cos(angle) * 2;
				}
				else
				{
					return batAccel * Math.cos(angle);
				}
			}
		}
		
		private function calculateBatY(batX:Number,batY:Number,batXV:Number,batYV:Number,batAccel:Number):Number
		{
			//Find the distance between the bat and the character
			var distanceX:Number = Math.abs(batX - char.x);
			var distanceY:Number = Math.abs(batY - char.y);
			
			//If the bat is ahead of the character by less than 800 pixels, don't accelerate the bat
			if ((batX - char.x) > 800)return 0;
			
			//If the bat is within 1 pixel of the character, continue accelerating at the same rate.
			if(distanceY < 1)return batAccel;
			//Otherwise, calculate the angle between the character and the bat
			else var angle:Number = Math.atan(distanceY/distanceX);
			
			//Using the angle, find out what proportion of the acceleration 
			//to distribute to the vertical plane.
			if(batY > char.y)
			{
				if(batYV >= 0)
				{
					return -batAccel * Math.sin(angle) * 2;
				}
				else
				{
					return -batAccel * Math.sin(angle);
				}
			}
			else
			{
				if(batYV <= 0)
				{
					return batAccel * Math.sin(angle) * 2;
				}
				else
				{
					return batAccel * Math.sin(angle);
				}
			}
		}
		
		//----------SNOWBALL MOVEMENT------------//
		
		private function snowballMovement():void
		{
			//Loop so every snowball is moved
			for(var i:int = 0; i<snowballArray.length;i++)
			{
				snowballArray[i].x += snowballArray[i].xv;
				snowballArray[i].y += snowballArray[i].yv;
				
				//Remove the snowball if it goes offscreen
				if((snowballArray[i].x > char.x + 650)||(snowballArray[i].x < char.x - 650))
				{
					removeSnowball(i);
				}
			}
		}
		
		
		
		// -------------------------------------------//
		
		//-----------------SHOOTING -----------------//
		
		//-------------------------------------------//		
		
		
		//-----CALCULATE SHOOTING DIRECTION-------//
		private function shooting():void
		{
			//If the gun is ready to be used, then shoot in the correct direction and apply the correct animation
			if(gunReady)
			{
				if(leftDown || rightDown || upDown || downDown)
				{
					if(leftPriority)
					{
						shootLeft();
						char.horizontal = "left";
					}
					else if(rightPriority)
					{
						shootRight();
						char.horizontal = "right";
					}
					else if(upPriority)
					{
						shootUp();
						char.vertical = "up";
					}					
					else if(downPriority)
					{
						shootDown();
						char.vertical = "down";
					}
					
					
					//Key still held down after another key has been lifted
					else if(leftDown)
					{
						shootLeft();
						char.horizontal = "left";
					}
					else if(rightDown)
					{
						shootRight();
						char.horizontal = "right";
					}
					else if(upDown)
					{
						shootUp();
						char.vertical = "up";
					}
					else if(downDown)
					{
						shootDown();
						char.vertical = "down";
					}
				}
			}
		}
		
		//--------SHOOTS IN A PARTICULAR DIRECTION---------//
		private function shootRight():void
		{
			//Add a snowball moving right
			addSnowball(char.x+char.w+10,char.y+char.h*0.5-10,snowballSpeed,0,snowballDamage);
			//Add a delay before the gun can be fired again
			startGunDelay();
		}
		
		private function shootLeft():void
		{
			//Add a snowball moving left
			addSnowball(char.x-10,char.y+char.h*0.5-10,-snowballSpeed,0,snowballDamage);
			//Add a delay before the gun can be fired again
			startGunDelay();
		}
		
		private function shootUp():void
		{
			//Add a snowball moving up
			addSnowball(char.x+char.w*0.5,char.y-20,0,-snowballSpeed,snowballDamage);
			//Add a delay before the gun can be fired again
			startGunDelay();
		}
		
		private function shootDown():void
		{
			//Add a snowball moving down
			addSnowball(char.x+char.w*0.5,char.y+char.h,0,snowballSpeed,snowballDamage);
			//Add a delay before the gun can be fired again
			startGunDelay();
		}
		
		//-----------CREATE A DELAY FOR THE GUN--------------------//
		
		private function startGunDelay():void
		{
			//Set the gun to not ready
			gunReady = false;
			//Add a timer, and stop the gun once it is complete
			gunTimer = new Timer(gunDelay,1);
			gunTimer.addEventListener(TimerEvent.TIMER_COMPLETE,stopGunDelay);
			gunTimer.start();
		}
		
		//---------PUT THE GUN BACK INTO A READY STATE------------//
		private function stopGunDelay(e:TimerEvent):void
		{
			if(char)
			{
				//Set the correct animation for the character
				if(upDown)char.vertical = "up";
				else if(downDown)char.vertical = "down";
				else char.vertical = "neutral";
			}
			
			//Set the gun to ready
			gunReady = true;
			//Remove the timer
			gunTimer = null;
		}

		
	
		// -------------------------------------------//
		
		//--------------COLLISION---------------------//
		
		//-------------------------------------------//
		
		//----MOVING OBJECT VS PLATFORM/CAGE---//
		private function blockCollision(obj:MovieClip):void
		{
			//Create an array containing all platforms and cages
			var blockArray:Array = [];
			
			for(var p=0;p<platformArray.length;p++)
			{
				blockArray.push(platformArray[p]);
			}
			for(var c=0;c<cageArray.length;c++)
			{
				blockArray.push(cageArray[c]);
			}
		
			//Test each platform/cage
			for(var i:int = 0; i < blockArray.length; i++)
			{
				//Create a rectangle based on where the object will be
				var objRect:Rectangle = new Rectangle(obj.x, obj.y, obj.w, obj.h);
				objRect.x += obj.xv;
				objRect.y += obj.yv;
				
				//Create a rectangle based on where the platform/cage is
				var blockRect:Rectangle = new Rectangle(blockArray[i].x, blockArray[i].y, blockArray[i].w, blockArray[i].h);
				
				//If the rectangles intersect, use displacement = velocity/time to find out which side of the platform/cage
				//the object comes into contact with first. Move the object to that side.
				if(objRect.intersects(blockRect))
				{
					var xDistance:Number;
					var yDistance:Number;
					var xTime:Number;
					var yTime:Number;
					
					if(obj.xv > 0)
					{
					   //Down Right
					   if(obj.yv > 0)
					   {
						   xDistance = (objRect.x + objRect.width) - (blockRect.x);
						   yDistance = (objRect.y + objRect.height) - (blockRect.y);
						   xTime = Math.abs(xDistance/obj.xv);
						   yTime = Math.abs(yDistance/obj.yv);
						   
						   if (xTime < yTime)
						   {
							   obj.x = blockRect.x - obj.w - 1;
							   obj.xv = 0;
						   }
						   else
						   {
							   obj.y = blockRect.y - obj.h - 1;
							   obj.yv = 0;
						   }
					   }
					   //Up Right
					   else if(obj.yv < 0)
					   {
							xDistance = (objRect.x + objRect.width) - (blockRect.x);
							yDistance = (blockRect.y + blockRect.height) - objRect.y;
							xTime = Math.abs(xDistance/obj.xv);
							yTime = Math.abs(yDistance/obj.yv);
							
							if(xTime < yTime)
							{
								obj.x = blockRect.x - obj.w - 1;
								obj.xv = 0;
							}
							else
							{
								obj.y = blockRect.y + blockRect.height + 1;
								obj.yv = 0;
							}
					   }
					   //Right
					   else if(obj.yv == 0)
					   {
						   obj.x = blockRect.x - obj.w - 1;
						   obj.xv = 0;
					   }
					}
					else if(obj.xv < 0)
					{
						//Down Left
						if(obj.yv > 0)
						{
							xDistance = (blockRect.x + blockRect.width) - objRect.x;
							yDistance = (objRect.y + objRect.height) - blockRect.y;
							xTime = Math.abs(xDistance/obj.xv);
							yTime = Math.abs(yDistance/obj.yv);
							
							if(xTime < yTime)
							{
								obj.x = blockRect.x + blockRect.width + 1;
								obj.xv = 0;
							}
							else
							{
								obj.y = blockRect.y - obj.h - 1;
								obj.yv = 0;
						   	}
						}
						//Up Left
						else if(obj.yv < 0)
						{
							xDistance = (blockRect.x + blockRect.width) - objRect.x;
							yDistance = (blockRect.y + blockRect.height) - objRect.y;
							xTime = Math.abs(xDistance/obj.xv);
							yTime = Math.abs(yDistance/obj.yv);				
							
							if(xTime < yTime)
							{
								obj.x = blockRect.x + blockRect.width + 1;
								obj.xv = 0;
							}
							else
							{
								obj.y = blockRect.y + blockRect.height + 1;
								obj.yv = 0;
							}
						}
						//Left
						else if(obj.yv == 0)
						{
							obj.x = blockRect.x + blockRect.width + 1;
							obj.xv = 0;
						}
					}
					else if(obj.xv == 0)
					{
						//Up
						if(obj.yv < 0)
						{
							obj.y = blockRect.y + blockRect.height + 1;
							obj.yv = 0;
						}
						
						//Down
						else if(obj.yv > 0)
						{
							obj.y = blockRect.y - obj.h - 1;
							obj.yv = 0;
						}	
					}
				}
			}
		}
		
		//------OBJECT VS CLOUD--------//
		
		private function cloudCollision(obj:MovieClip):void
		{
			//Only apply cloud collision if the object is moving downwards
			if(obj.yv > 0)
			{
				//create a temprorary rectangle and move it into the position the object will be in
				var objRectBot:Rectangle = new Rectangle(obj.x,obj.y + obj.h,obj.w,2);
				objRectBot.x += obj.xv;
				objRectBot.y += obj.yv;
				
				//Test each cloud
				for(var i:int = 0;i < cloudArray.length;i++)
				{
					//create a rectangle for the current cloud being tested
					var cloudRect:Rectangle = new Rectangle(cloudArray[i].x,cloudArray[i].y,cloudArray[i].w,cloudArray[i].h);
					
					//if the object intersects the cloud, move the object appropriately
					if(objRectBot.intersects(cloudRect))
					{
						obj.y = cloudRect.y - obj.h - 1;
						obj.yv = 0;
					}
				}
			}
		}
		
		//--------CHAR VS BAT---------//
		private function charBatCollision():void
		{
			//If the character exists and aren't invincible...
			if(char && !invincible)
			{
				//Create a temporary rectangle and move it to where the character will be
				var charRect:Rectangle = new Rectangle(char.x, char.y, char.w, char.h); 
				charRect.x += char.xv;
				charRect.y += char.yv;
				
				//Test each bat
				charBatLoop:for(var i:int=0;i<batArray.length;i++)
				{
					//Create a temporary rectangle and move it to where the bat will be
					var batRect:Rectangle = new Rectangle(batArray[i].x, batArray[i].y, batArray[i].w, batArray[i].h);
					batRect.x += batArray[i].xv;
					batRect.y += batArray[i].yv;
					
					/* If the rectangles intersect damage the character and break out of the loop
					 so the character can't be hit by multiple bats at once */
					if(charRect.intersects(batRect))
					{
						damageChar(batArray[i].damage);
						break charBatLoop;
					}
				}
			}
		}
		
		//--------CHAR VS BOSS BAT---------//
		private function charBossBatCollision():void
		{
			//If the character exists and aren't invincible...
			if(char && !invincible)
			{
				//Create a temporary rectangle and move it to where the character will be
				var charRect:Rectangle = new Rectangle(char.x, char.y, char.w, char.h); 
				charRect.x += char.xv;
				charRect.y += char.yv;
				
				//Test each bat
				charBossBatLoop:for(var i:int=0;i<bossBatArray.length;i++)
				{
					//Create a temporary rectangle and move it to where the bat will be
					var batRect:Rectangle = new Rectangle(bossBatArray[i].x, bossBatArray[i].y, bossBatArray[i].w, bossBatArray[i].h);
					batRect.x += bossBatArray[i].xv;
					batRect.y += bossBatArray[i].yv;
					
					//If the rectangles intersect damage the character and break out of the loop
					// so the character can't be hit by multiple bats at once
					if(charRect.intersects(batRect))
					{
						damageChar(bossBatArray[i].damage);
						break charBossBatLoop;
					}
				}
			}
		}
		
		
		//----------SNOWBALL VS BAT------------------//
		private function snowballBatCollision():void
		{
			//Test each snowball
			for(var i:int=0;i<snowballArray.length;i++)
			{
				//Create a rectangle based on where the snowball will be
				var snowballRect:Rectangle = new Rectangle(snowballArray[i].x, snowballArray[i].y, snowballArray[i].w, snowballArray[i].h);
				snowballRect.x += snowballArray[i].xv;
				snowballRect.y += snowballArray[i].yv;
				
				//Test each bat
				for(var j:int=0;j<batArray.length;j++)
				{
					//if the snowball and bat both exist
					if(snowballArray[i] && batArray[j])
					{
						//Create a rectangle based on where the bat will be
						var batRect:Rectangle = new Rectangle(batArray[j].x, batArray[j].y, batArray[j].w,batArray[j].h);
						batRect.x += batArray[j].xv;
						batRect.y += batArray[j].yv;
						
						//If the rectangles intersect, then...
						if(snowballRect.intersects(batRect))
						{
							//apply a visual effect to the bat
							batArray[j].flash();
							//damage the bat
							damageBat(snowballArray[i].damage, j);
							//remove the snowball
							removeSnowball(i);
						}
					}
				}
			}
		}
		
		//----------SNOWBALL VS BOSS BAT------------------//
		private function snowballBossBatCollision():void
		{
			//Test each snowball
			for(var i:int=0;i<snowballArray.length;i++)
			{
				//Create a rectangle based on where the snowball will be
				var snowballRect:Rectangle = new Rectangle(snowballArray[i].x, snowballArray[i].y, snowballArray[i].w, snowballArray[i].h);
				snowballRect.x += snowballArray[i].xv;
				snowballRect.y += snowballArray[i].yv;
				
				//Test each bat
				for(var j:int=0;j<bossBatArray.length;j++)
				{
					//if the snowball and bat both exist
					if(snowballArray[i] != null && bossBatArray[j] != null)
					{
						//Create a rectangle based on where the bat will be
						var batRect:Rectangle = new Rectangle(bossBatArray[j].x, bossBatArray[j].y, bossBatArray[j].w,bossBatArray[j].h);
						batRect.x += bossBatArray[j].xv;
						batRect.y += bossBatArray[j].yv;
						
						//If the rectangles intersect, then...
						if(snowballRect.intersects(batRect))
						{
							//Apply a visual effect to the boss bat
							bossBatArray[j].flash();
							//Damage the boss bat
							damageBossBat(snowballArray[i].damage, j);
							//Remove the snowball
							removeSnowball(i);
						}
					}
				}
			}
		}
		
		//------------SNOWBALL VS PLATFORM---------------//
		private function snowballPlatformCollision():void
		{
			//Test each snowball
			for(var i:int=0;i<snowballArray.length;i++)
			{
				//create a rectangle based on where the snowball will be
				var snowballRect:Rectangle = new Rectangle(snowballArray[i].x, snowballArray[i].y, snowballArray[i].w, snowballArray[i].h);
				snowballRect.x += snowballArray[i].xv;
				snowballRect.y += snowballArray[i].yv;
				
				//test each platform
				for(var j:int=0;j<platformArray.length;j++)
				{
					//Create a rectangle based on where the platform will be
					var platformRect:Rectangle = new Rectangle(platformArray[j].x, platformArray[j].y, platformArray[j].w, platformArray[j].h);
					
					//If the rectangles intersect then...
					if(snowballRect.intersects(platformRect))
					{
						//play a sound effect
						gameSounds.playBlockHit();
						// remove the snowball
						removeSnowball(i);
					}
				}
			}
		}
		
		//-----------SNOWBALL VS CAGE--------------//
		private function snowballCageCollision():void
		{
			//Test each snowball
			for(var i:int=0;i<snowballArray.length;i++)
			{
				//Create a rectangle based on where the snowball will be
				var snowballRect:Rectangle = new Rectangle(snowballArray[i].x, snowballArray[i].y, snowballArray[i].w, snowballArray[i].h);
				snowballRect.x += snowballArray[i].xv;
				snowballRect.y += snowballArray[i].yv;
				
				//Test each cage
				for(var j:int=0;j<cageArray.length;j++)
				{
					//If the snowball and the cage exist
					if(snowballArray[i] && cageArray[j])
					{
						//Create a rectangle based on where the cage will be
						var cageRect:Rectangle = new Rectangle(cageArray[j].x, cageArray[j].y, cageArray[j].w, cageArray[j].h);
						
						//If the rectangles intersect then...
						if(snowballRect.intersects(cageRect))
						{
							//apply a visual effect
							cageArray[j].flash();
							//damage the cage
							damageCage(snowballArray[i].damage, j);
							//remove the snowball
							removeSnowball(i);
						}
					}
				}
			}
		}
	}
}