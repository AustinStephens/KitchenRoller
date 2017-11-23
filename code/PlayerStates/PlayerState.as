package code.PlayerStates {
	
	import code.Player;
	/**
	 * This is an abstract class, defines PlayerState Interface
	 * Shouldn't be instantiated
	 */
	public class PlayerState {
		/** Instance of the player. */
		protected var player: Player;
		
		/** 
		 * Update function.
		 * @return PlayerState Returns a new state if it needs to change, null if not.
		 */
		public function update(): PlayerState
			{ return null; }
			
		/** 
		 *Called after the state is first changed to. 
		 *@param  playerInScene The player in the scene, stored in the player variable.
		 */
		public function onEnter(playerInScene: Player): void {}
		/** Called before the state is changed to another scene. */
		public function onExit(): void {}
		

	}
	
}
