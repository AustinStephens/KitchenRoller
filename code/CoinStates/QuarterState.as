package code.CoinStates {
	
	import code.Player;
	import code.GameObject;
	import code.Game;
	
	public class QuarterState extends CoinState {
		/** How long the quarter state lasts, in seconds. */
		private var timeLeft: Number = 3;
		/** 
		 * Called after the state is first changed to.
		 * @param newPlayer A reference to the player variable.
		 */
		override public function onEnter(newPlayer: Player): void
		{
			newPlayer.gotoAndStop(2);
			newPlayer.radius = 34;
		}
		/** 
		 * Update function. Updates counter.
		 * @return CoinState Returns a new state if it needs to change, null if not.
		 */
		override public function update(): CoinState
		{
			timeLeft -= Game.deltaTime;
			if(timeLeft <= 0)// when the timers over, go back to a nickel
			{
				return new NickelState();
			}
			
			return null;
		}
		
		/** 
		 * Called when a game object collides with the player.
		 * @param obj A reference to the game object.
		 * @param player A reference to the player variable.
		 */
		override public function onCollision(obj: GameObject, player: Player): void
		{
			obj.isDead = true; // destroys the object instead of the player
		}

	}
	
}
