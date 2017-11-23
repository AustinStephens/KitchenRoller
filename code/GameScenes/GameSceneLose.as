package code.GameScenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	
	
	public class GameSceneLose extends GameScene {
		/** Boolean determining whether or not the player hit the main menu button. */
		private var mmClicked: Boolean = false;
		/** Boolean determining whether or not the player hit the replay button. */
		private var replayClicked: Boolean = false;
		
		/** Displays the score. */
		//private var scoreText;
		
		public var mmBtn: SimpleButton;
		public var replayBtn: SimpleButton;
		
		/**
		 * Called every frame. Checks if we need to change scenes.
		 * @return GameScene Returns a new game scene if necessary.
		 */
		override public function update(): GameScene
		{
			if(mmClicked) 
				return new GameSceneTitle();
			if(replayClicked)
				return new GameScenePlay();
			
			return null;
		}
		/** Called right after the scene is first changed to. */
		override public function onEnter(): void
		{
			mmBtn.addEventListener(MouseEvent.CLICK, mmClick);
			replayBtn.addEventListener(MouseEvent.CLICK, replayClick);
			scoreText.text = "Score: " + int(score);
		}
		/** Called right before the scene is changed. */
		override public function onExit(): void
		{
			mmBtn.removeEventListener(MouseEvent.CLICK, mmClick);
			replayBtn.removeEventListener(MouseEvent.CLICK, replayClick);
			score = 0;
		}
		
		private function  mmClick(e: MouseEvent): void
		{
			mmClicked = true;
		}
		
		private function replayClick(e: MouseEvent): void
		{
			replayClicked = true;
		}
	}
	
}
