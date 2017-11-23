package code {
	
	import flash.display.MovieClip;
	import code.GameScenes.GameScenePlay;
	import code.CoinStates.QuarterState;
	import code.Sounds.SoundCoin;
	
	public class CoinPickup extends GameObject {
		
		/** 
		 * Generates a random x coordinate, sets the collision boxes.
		 * @param newx X coordinate of the table under it.
		 * @param newy Y coordinate of where it should be.
		 */
		public function CoinPickup(newx: Number = NaN, newy: Number = NaN) { // default arguments for controls screen
			if(isNaN(newx)) return;
			x = newx + Math.random() * 150 - 75;
			y = newy;
			setCollisionBoxes();
		}
		
		/** 
		 * Called when this object collides with the player. If the player isnt a quarter, update the qbar, removes it from the screen.
		 * @param player Reference to the play variable to called its on collision function.
		 * @param gameScene Regerence to the game scene to call some of its functions.
		 */
		override public function onCollision(player: Player, gameScene: GameScenePlay): void
		{
			if(!(player.coinState is QuarterState)) gameScene.updateQBar();
			isDead = true;
			var sound: SoundCoin = new SoundCoin();
			sound.play();
		}
	}
	
}
