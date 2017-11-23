package code.CoinStates {
	
	import code.Player;
	import code.Game;
	import code.KeyboardState;
	import flash.ui.Keyboard;
	
	public class PennyState extends CoinState {
		/** How long the quarter state lasts. In seconds. */
		private var timeLeft: Number = 2;
		/** 
		 * Sets the frame and radius of the player.
		 * @param newPlayer A reference to the player variable.
		 */
		override public function onEnter(newPlayer: Player): void
		{
			newPlayer.gotoAndStop(3);
			newPlayer.radius = 10.5;
		}
		/** 
		 * Sets the frame and radius of the player.
		 * @return CoinState A reference to the player variable.
		 */
		override public function update(): CoinState
		{
			if(KeyboardState.onKeyDown(Keyboard.LEFT)) // allows you to stay in the penny state if you want, so you don't turn into a nickel under a pillar
				return new PennyState();
			
			timeLeft -= Game.deltaTime;
			if(timeLeft <= 0) // when the timers over, go back to a nickel
				return new NickelState();
			
			return null;
		}

	}
	
}
