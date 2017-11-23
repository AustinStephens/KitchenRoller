package code {
	
	import flash.display.MovieClip;
	
	
	public class Orange extends GameObject {
		
		/** 
		 * Generates a random x coordinate, sets the collision boxes and y coordinate.
		 * @param newx X coordinate of the table under it.
		 * @param newy Y coordinate of the table under it.
		 */
		public function Orange(newX: Number = NaN, newY: Number = NaN) { // default arguments for controls screen
			if(isNaN(newX)) return;
			x = newX + (Math.random() * (Table.WIDTH - 300) - (Table.WIDTH / 2) + 150);
			y = newY - (height / 2) - 250; // 250 = table's height / 2
			setCollisionBoxes();
		}
		
	}
	
}
