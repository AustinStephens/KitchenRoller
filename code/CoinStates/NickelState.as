package code.CoinStates {
	
	import code.GameScenes.GameScenePlay;
	import code.Player;
	import code.KeyboardState;
	import flash.ui.Keyboard;
	
	public class NickelState extends CoinState {
		/** 
		 * Sets the frame and radius of the player.
		 * @param newPlayer A reference to the player variable.
		 */
		override public function onEnter(newPlayer: Player): void
		{
			newPlayer.gotoAndStop(1);
			newPlayer.radius = 22.5;
		}
		/** 
		 * Called every frame, checks if the player has changed states.
		 * @return CoinState Returns a new coinstate if necessary.
		 */
		override public function update(): CoinState
		{
			if(KeyboardState.onKeyDown(Keyboard.LEFT)) return new PennyState();
			if(KeyboardState.onKeyDown(Keyboard.RIGHT) && GameScenePlay.quarterFrame == 5)
			{
				GameScenePlay.quarterFrame = 1;
				return new QuarterState();
			}
			
			return null;
		}
	}
	
}
