package code.PlayerStates {
	
	import flash.ui.Keyboard;
	import code.Player;
	import code.KeyboardState;
	
	public class PlayerStateRun extends PlayerState {
		/** 
		 * Update function. Checks if we need to jump.
		 * @return PlayerState Returns a new state if it needs to change, null if not.
		 */
		override public function update(): PlayerState
		{
			player.applyGravity();

			//transition
			if(KeyboardState.onKeyDown(Keyboard.SPACE))
			{
				player.doJumping();
				return new PlayerStateAir();
			}
			
			return null; 
		}
		/** 
		 *Called after the state is first changed to. 
		 *@param  playerInScene The player in the scene, stored in the player variable.
		 */
		override public function onEnter(newPlayer: Player): void 
		{
			player = newPlayer;
		}

	}
	
}
