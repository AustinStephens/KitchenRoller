package code.PlayerStates {
	
	import code.Player;
	
	public class PlayerStateAir extends PlayerState{
		/** 
		 * Update function. Jumps, applies gravity, checks if we have landed yet.
		 * @return PlayerState Returns a new state if it needs to change, null if not.
		 */
		override public function update(): PlayerState
		{ 
			player.doJumping();
			player.applyGravity(player.isJumping ? .5 : 1);
			
			//transition
			if(player.isGrounded) return new PlayerStateRun();
			
			return null; 
		}
		/** 
		 * Called after the state is first changed to. 
		 * @param  playerInScene The player in the scene, stored in the player variable.
		 */	
		override public function onEnter(playerInScene: Player): void 
		{
			player = playerInScene;
		}

	}
	
}
