package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import code.GameScenes.*;
	import code.Sounds.BackgroundMusic;
	
	/**
	 * This game is the root class, entry point for the game and code. Manages the game state.
	 */
	// Possible fixes to the game:
	//    Make it so the powerups wont spawn right above an obstacle, right now if it does you cannot pick it up. Another fix is to make them spawn higher so it wont affect whether or not you can pick them up.
	public class Game extends MovieClip {
		
		/** Change in time */
		public static var deltaTime: Number;
		/** Scale of delta time */
		public static var timeScale: Number = 1;
		/** Time stamp of previous frame */
		private var prevTime: int = 0;
		/** Scene curerently being displayed */
		private var scene: GameScene;
		
		public var sound: BackgroundMusic = new BackgroundMusic();
		/**
		 * The constructor, here we setup event-listeners and initialize our game state.
		 */
		public function Game() {
			// constructor code
			setScene(new GameSceneTitle());
			addEventListener(Event.ENTER_FRAME, gameLoop);
			KeyboardState.setup(stage);
			playSound();
		}
		
		/**
		 * Calculates delta time and stores it in our static delta time variable
		 */
		public function getDeltaTime(): void
		{
			var currentTime: int = getTimer();
			deltaTime = (currentTime - prevTime) / 1000.0 * timeScale;
			prevTime = currentTime;
		}
		
		/**
		 * This event-handler runs every frame. This is the game loop.
		 * @param  e  The event that triggered this function
		 */
		private function gameLoop(e:Event): void
		{
			//delta time update
			getDeltaTime();
			
			// SCENE MANAGMENT / UPDATE SECTION
			if(scene != null)
			{
				var newScene: GameScene = scene.update();
				if(newScene != null)
					setScene(newScene);
			}
			
			// CACHING /////////////////
			KeyboardState.update();
		}
		
		/**
		 * Changes the scene, called when the update function for the scene returns a new scene.
		 * @param  newScene   The scene being changed to.
		 */
		private function setScene(newScene: GameScene): void
		{
			var newScore: Number; // score of the previous scene
			if(scene != null) 
			{
				removeChild(scene); // remove old scene
				scene.onExit();
				newScore = scene.score;
			}
			else
				newScore = 0;  // so its not undefined
			
			scene = newScene;
			addChild(scene); // add new scene
			scene.score = newScore; // so i can show the score on the game lose scene
			scene.onEnter();
			stage.focus = stage;
		}
		
		/** 
		  *Plays the sound and adds an event listener to loop it, just loops, doesn't change or restart when in a new scene or when you die.
		  *It's hard to find free and non royalty music.
		  */
		private function playSound():void
		{
			var channel:SoundChannel = sound.play(0, 1, new SoundTransform(.25));
			channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		/** Called when the sound is complete to loop it */
		private function onComplete(event:Event):void
		{
			SoundChannel(event.target).removeEventListener(event.type, onComplete);
			playSound();
		}
		
		
	}
	
}
