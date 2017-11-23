package code.GameScenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	import flash.display.SimpleButton;
	
	public class GameSceneTitle extends GameScene {
		
		/** Boolean determining whether or not the player hit the play button. */
		private var playFlag: Boolean = false;
		/** Boolean determining whether or not the player hit the controls button. */
		private var controls: Boolean = false;
		
		public var playBtn: SimpleButton;
		public var qtBtn: SimpleButton;
		public var controlsBtn: SimpleButton;
		
		private function playClick(e: MouseEvent): void
		{
			playFlag = true;
		}
		
		private function controlsClick(e: MouseEvent): void
		{
			controls = true;
		}
		
		private function quitClick(event:MouseEvent):void {  
			fscommand("quit");  // Not sure why this isn't working, might just not work in swf files
		} 
		/**
		 * Called every frame. Checks if we need to change scenes.
		 * @return GameScene Returns a new game scene if necessary.
		 */
		override public function update(): GameScene
		{
			if(playFlag)
				return new GameScenePlay();
			if(controls)
				return new GameSceneControls();

			return null;
		}
		/** Called right after the scene is first changed to. */
		override public function onEnter(): void
		{
			playBtn.addEventListener(MouseEvent.CLICK, playClick);
			qtBtn.addEventListener(MouseEvent.CLICK, quitClick);
			controlsBtn.addEventListener(MouseEvent.CLICK, controlsClick);
		}
		/** Called right before the scene is changed. */
		override public function onExit(): void
		{
			playBtn.removeEventListener(MouseEvent.CLICK, playClick);
			qtBtn.removeEventListener(MouseEvent.CLICK, quitClick);
			controlsBtn.removeEventListener(MouseEvent.CLICK, controlsClick);
		}
	
	}
	
}
