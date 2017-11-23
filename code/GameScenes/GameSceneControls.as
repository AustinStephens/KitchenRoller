package code.GameScenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import code.Bar;
	
	public class GameSceneControls extends GameScene {
		/** Boolean determining whether or not the player hit the back button. */
		private var back: Boolean = false;
		
		public var backBtn: SimpleButton;
		public var qbar: Bar;
		
		private function backClick(e: MouseEvent): void
		{
			back = true;
		}
		
		/**
		 * Called every frame. Checks if we need to change scenes.
		 * @return GameScene Returns null or the title scene if we hit the back button.
		 */
		override public function update(): GameScene
		{
			if(back) return new GameSceneTitle();
			return null;
		}
		
		/** Called right after the scene is first changed to. */
		override public function onEnter(): void
		{
			backBtn.addEventListener(MouseEvent.CLICK, backClick);
			qbar.gotoAndStop(1);
		}
		/** Called right before the scene is changed. */
		override public function onExit() : void
		{
			backBtn.removeEventListener(MouseEvent.CLICK, backClick);
		}
	}
	
}
