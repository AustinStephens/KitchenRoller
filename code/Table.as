package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import code.GameScenes.GameScenePlay;

	
	
	public class Table extends GameObject {
		/** Width (and height) of table, so I don't need a reference to one to get it. */
		public static const WIDTH: Number = 600; //doubles as height, the movieclip is a square
		
		
		/** 
		 * Sets the coordinates of the table and the collision box.
		 * @param newx X coordinate of the table.
		 * @param newy Y coordinate of the table.
		 */
		public function Table(newx: Number, newy: Number) {
			y = newy;
			x = newx;
			setCollisionBoxes();
		}
		/** 
		 * Called when this object collides with the player. Calculates a fix for the player, applies it.
		 * @param player Reference to the play variable to called its on collision function.
		 * @param gameScene Regerence to the game scene to call some of its functions.
		 */
		override public function onCollision(player: Player, gameScene: GameScenePlay): void
		{
			var fix: Point = collisionBoxes[0].findBestFixRadial(player);
			player.applyFix(fix);
		}
	}
	
}
