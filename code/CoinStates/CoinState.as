package code.CoinStates {
	
	import code.Player;
	import code.GameObject;
	
	public class CoinState { //could be an interface but it's easier not to so I don't have to implement onExit() to {} in all subclasses
                             // also oncollision will be the same for both penny and nickel so just have it defined here and override it for quarter
		public function CoinState() {
		}
		
		/** 
		 * Called right after the state is changed to.
		 * @param newPlayer A reference to the player variable.
		 */
		public function onEnter(newPlayer: Player): void {}
		/** Called right before the state is changed. */
		public function onExit(): void {}
		/**
		 * Called every frame.
		 * @return CoinState Returns null as a default.
		 */
		public function update(): CoinState { return null; }
		/**
		 * Called when a collision happens.
		 * @param obj A reference to the game object.
		 * @param player A reference to the player.
		 */
		public function onCollision(obj: GameObject, player: Player): void
		{
			player.isDead = true;
		}
		
	}
	
}
