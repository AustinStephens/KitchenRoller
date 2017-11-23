package code {
	
	import flash.display.MovieClip;
	
	
	public class Pillar extends GameObject {
		
		/** 
		 * Generates a random x coordinate, sets the collision boxes and y coordinate.
		 * @param newx X coordinate of the table under it.
		 * @param newy Y coordinate of the table under it.
		 */
		public function Pillar(newx: Number = NaN, newy: Number = NaN) { // default arguments for controls screen
			if(isNaN(newx)) return;
			x = newx;
			y = newy - (Table.WIDTH / 2) - (height / 2) + 15;
			setCollisionBoxes();
		}
	}
	
}
