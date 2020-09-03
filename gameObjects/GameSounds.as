package gameObjects
{
	//Import libraries
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.events.Event;
	
	public class GameSounds
	{
		//Global sound volume for all music and effects
		public var soundVolume:Number = 100;
		
		//---------MUSIC----------------//
		private var music1:Sound = new Music1();
		private var music2:Sound = new Music2();
		private var music3:Sound = new Music3();
		private var music4:Sound = new Music4();
		private var musicChannel:SoundChannel = new SoundChannel();
		public var musicArray:Array = [music1,music2,music3,music4];
		public var currentMusic:int = 100;
		
		//------SFX---------//
		private var cageDestroyed:Sound = new CageDestroyed();
		private var charHit:Sound = new CharHit();
		private var charKilled:Sound = new CharKilled();
		private var batHit:Sound = new BatHit();
		private var blockHit:Sound = new BlockHit();
		private var batKilled:Sound = new BatKilled();
		private var levelCompleteSFX:Sound = new LevelCompleteSFX();
		private var sfxChannel:SoundChannel = new SoundChannel();
		
		//Constructor
		public function GameSounds():void
		{
			
		}
		
		public function stopMusic():void
		{
			//Stop any music that is playing
			musicChannel.stop();
		}
		
		public function stopSFX():void
		{
			//Stop any current sound effects being played
			sfxChannel.stop();
		}
		
		public function updateVolume():void
		{
			//Set the volume to the correct level
			var volumeTransform:SoundTransform = new SoundTransform(soundVolume / 100, 0);
			//Apply the volume setting to all music being played
			musicChannel.soundTransform = volumeTransform;
			//Apply the volume setting to all sound effects being played
			sfxChannel.soundTransform = volumeTransform;
		}
		
		public function playMusic(musicIndex:int):void
		{
			//Set the currentmusic to the passed index
			currentMusic = musicIndex;
			//play the music from the musicArray at the passed index
			musicChannel = musicArray[musicIndex].play();
			//add a listener for when the music is complete and requires repeating
			musicChannel.addEventListener(Event.SOUND_COMPLETE, repeatMusic(musicIndex));
			//Set the volume to the correct level
			updateVolume();
		}
		
		private function repeatMusic(musicIndex:int):Function
		{
			return function(e:Event)
			{
				//Play music from the musicArray based on the passed index in the parameters
				musicChannel = musicArray[musicIndex].play();
			}
		}
		
		public function playCageDestroyed():void
		{
			//Play the appropriate sound effect
			sfxChannel = cageDestroyed.play();
			//Set the volume to the correct level
			updateVolume();
		}
		
		public function playCharHit():void
		{
			//Play the appropriate sound effect
			sfxChannel = charHit.play();
			//Set the volume to the correct level
			updateVolume();
		}
		
		public function playCharKilled():void
		{
			//Play the appropriate sound effect
			sfxChannel = charKilled.play();
			//Set the volume to the correct level
			updateVolume();
		}
		
		public function playBatHit():void
		{
			//Play the appropriate sound effect
			sfxChannel = batHit.play();
			//Set the volume to the correct level
			updateVolume();
		}
		
		public function playBatKilled():void
		{
			//Play the appropriate sound effect
			sfxChannel = batKilled.play();
			//Set the volume to the correct level
			updateVolume();
		}
		
		public function playBlockHit():void 
		{
			//Play the appropriate sound effect
			sfxChannel = blockHit.play();
			//Set the volume to the correct level
			updateVolume();
		}
		
		public function playLevelCompleteSFX():void
		{
			//Play the appropriate sound effect
			sfxChannel = levelCompleteSFX.play();
			//Set the volume to the correct level
			updateVolume();
		}
	}
}