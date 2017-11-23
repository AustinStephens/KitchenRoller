package code {
	import flash.display.MovieClip;
	import code.GameScenes.GameScenePlay;
	/* Choosing to do inheritence over implementation for now, might change it */
	public class GameObject extends MovieClip{

		/** Determines when the object should be removed from the scene. */
		public var isDead: Boolean = false;
		/** ObjectAABB's, in case I want more than one. */
		public var collisionBoxes: Array = new Array();
		
		public function GameObject() {
			//setCollisionBoxes(); would have this here but parent object's constructor is called first
		}
		
		/** Called every function, calls the move and check function. */
		public function update(): void 
		{
			moveAndCheck();
		}
		/** Adds a objectAABB to the array of collision boxes. */
		protected function setCollisionBoxes(): void
		{
			collisionBoxes.push(new ObjectAABB());
			collisionBoxes[0].setSize(width, height);
			collisionBoxes[0].calcAABB(x,y);
		}
		/** Calculates the new edges for the objectAABB, moves the object sideways, checks if its off the screen. */
		protected function moveAndCheck(): void
		{
			x -= GameScenePlay.MOVEMENT_SPEED * Game.deltaTime;
			collisionBoxes[0].calcAABB(x,y);
			if(collisionBoxes[0].edgeR < 0)
			{
				isDead = true;
			}
		}
		/** 
		 * Called when this object collides with the player.
		 * @param player Reference to the play variable to called its on collision function.
		 * @param gameScene Regerence to the game scene to call some of its functions.
		 */
		public function onCollision(player: Player, gameScene: GameScenePlay): void
		{
			player.coinState.onCollision(this, player);
		}
		
		

	}
	
}
