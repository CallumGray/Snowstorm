package pauseObjects
{
	//---IMPORT LIBRARIES
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	
	public class PauseScreen extends MovieClip
	{
		//Declare variables
		private var pauseBackground:PauseBackground;
		private var volumeBarEmpty:VolumeBarEmpty;
		private var volumeBar:VolumeBar;
		private var qualityBarEmpty:QualityBarEmpty;
		private var qualityBar:QualityBar;
		private var glow:GlowFilter;
		
		public var aDown:Boolean = false;
		public var dDown:Boolean = false;
		public var wDown:Boolean = false;
		public var sDown:Boolean = false;
		public var upDown:Boolean = false;
		public var downDown:Boolean = false;
		public var leftDown:Boolean = false;
		public var rightDown:Boolean = false;
		
		public var currentMenu:String = "volumeMenu";
		
		//---CONSTRUCTOR---//
		public function PauseScreen():void
		{
			//Add Objects
			pauseBackground = new PauseBackground(0,0);
			volumeBarEmpty = new VolumeBarEmpty(100,200);
			volumeBar = new VolumeBar(100,200);
			qualityBarEmpty = new QualityBarEmpty(100,350);
			qualityBar = new QualityBar(100,350);
			addChild(pauseBackground);
			addChild(volumeBarEmpty);
			addChild(volumeBar);
			addChild(qualityBarEmpty);
			addChild(qualityBar);
			
			//Specify glow effect
			glow = new GlowFilter();
			glow.color = 0xFFFFFF;
			glow.blurX = 64;
			glow.blurY = 16;
			volumeBarEmpty.filters = [glow];
		}
		
		//---CHANGE SIZE OF MENU BARS---//
		public function updateQualityVisuals(quality:String):void
		{
			if(quality == "LOW")
			{
				qualityBar.width = 0.1;
			}
			else if(quality == "MEDIUM")
			{
				qualityBar.width = qualityBarEmpty.width * 1/3;
			}
			else if(quality == "HIGH")
			{
				qualityBar.width = qualityBarEmpty.width * 2/3;
			}
			else
			{
				qualityBar.width = qualityBarEmpty.width;
			}
		}
		
		public function updateVolumeVisuals(volPerc:Number):void
		{
			volumeBar.width = volumeBarEmpty.width * volPerc/100;
		}
		
		//---APPLY VISUAL EFFECT FOR CURRENTLY SELECTED MENU---//
		public function changeMenu():void
		{
			if(currentMenu == "volumeMenu")
			{
				currentMenu = "qualityMenu";
				volumeBarEmpty.filters = [];
				qualityBarEmpty.filters = [glow];
			}
			else 
			{
				currentMenu = "volumeMenu";
				qualityBarEmpty.filters = [];
				volumeBarEmpty.filters = [glow];
			}
		}
	}
}