package code {
	
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * This is a simple superclass to extend AABB logic to any other
	 * MovieClip object through inheritance.
	 */
	public class ObjectAABB {
		/**
		 * The right edge of the axis-aligned bounding box.
		 * We update this each frame.
		 */
		public var edgeR:int = 0;
		/**
		 * The right edge of the axis-aligned bounding box.
		 * We update this each frame.
		 */
		public var edgeL:int = 0;
		/**
		 * The right edge of the axis-aligned bounding box.
		 * We update this each frame.
		 */
		public var edgeT:int = 0;
		/**
		 * The right edge of the axis-aligned bounding box.
		 * We update this each frame.
		 */
		public var edgeB:int = 0;
		/**
		 * The half-width of the box. Used when calculating the four edges of the box from its origin.
		 */
		private var halfW:Number;
		/**
		 * The half-height of the box. Used when calculating the four edges of the box from its origin.
		 */
		private var halfH:Number;
		
		/**
		 * This method sets the half-width and half-height of the box.
		 * @param w:Number	The width of the box
		 * @param h:Number	The height of the box
		 */
		public function setSize(w: Number, h: Number):void {
			halfW = w / 2;
			halfH = h / 2;
		}
		
		/**
		 * This method calculates a new AABB using the Rectangle class. This method should be called whenever the object's position or size have changed.
		 */
		public function calcAABB(x: Number, y: Number):void {
			edgeR = x + halfW;
			edgeL = x - halfW;
			edgeT = y - halfH;
			edgeB = y + halfH;
		}
		
		/**
		 * This method checks to see if this AABB is overlapping with another AABB.
		 * @param other:ObjectAABB	The other ObjectAABB to check against.
		 * @return Boolean	Whether or not the two AABBs are overlapping.
		 */
		public function checkOverlap(other:ObjectAABB):Boolean {
			if(edgeL > other.edgeR) return false;
			if(edgeR < other.edgeL) return false;
			if(edgeT > other.edgeB) return false;
			if(edgeB < other.edgeT) return false;
			return true;
		}
		
		/**
		 * This method finds the best way and how far to move this AABB so it doesn't overlap with another AABB
		 * @param other:ObjectAABB	The other box / AABB colliding with.
		 * @return Point  How far to move this AABB to fix the overlap.
		 */
		public function findBestFix(other: ObjectAABB): Point
		{
			var result: Point = new Point();
			
			var moveR: Number = other.edgeR - edgeL;
			var moveL: Number = other.edgeL - edgeR;
			var moveD: Number = other.edgeB - edgeT;
			var moveU: Number = other.edgeT - edgeB;
			
			result.x = (Math.abs(moveR) < Math.abs(moveL)) ? moveR : moveL;
			result.y = (Math.abs(moveU) < Math.abs(moveD)) ? moveU : moveD;
			
			if(Math.abs(result.y) < Math.abs(result.x))
				result.x = 0;
			else
				result.y = 0;
			
			return result;
		}
		
		/**
		 * This method checks if the object is overlapping with another given object using a radial-aabb collision detection.
		 * @param  other  A reference to the player variable.
		 * @return Boolean  Whether or not its overlapping.
		 */
		public function checkOverlapWithRadial(other: Player): Boolean
		{
			// Clamps the x and y of the center of the circle to the edge of the aabb
			// essentially checks the closest point of the aabb to to player
			var point: Point = new Point();
			
			if(other.x < edgeL) point.x = edgeL;
			else if(other.x > edgeR) point.x = edgeR;
			else point.x = other.x;
			
			if(other.y < edgeT) point.y = edgeT;
			else if(other.y > edgeB) point.y = edgeB;
			else point.y = other.y;
			
			// checks if the distance from the player to the closest point on the aabb is greater than the radius, if so it wont be overlapping.
			var distance: Number = Math.sqrt(Math.pow((other.x - point.x), 2) + Math.pow((other.y - point.y), 2));
			if(distance > other.radius) return false;
			
			return true;
		}
		
		/** 
		 * Finds the best fix to move the player so its not overlapping. 
		 * @param other A refernce to the player variable.
		 * @return Point How far the player should move to fix its position.
		 */
		public function findBestFixRadial(other: Player): Point
		{
			var result: Point = new Point();
			
			var moveD: Number = edgeB + other.radius - other.y;
			var moveU: Number = edgeT - other.y - other.radius;
			
			result.y = (Math.abs(moveU) <= Math.abs(moveD)) ? moveU : moveD;
			
			if(Math.abs(result.y) > 80) // removed the right and left fixes because they threw me off the edge of the table before I was actually off
				result.y = 0;           // replaced with this so if i hit the side falling off the screen I wont pop back up to the top
										// you can find the full version of this method in the folder "Code I want to keep" / Reused code
			result.x = 0;
			
			return result;

		}

	}
	
}
