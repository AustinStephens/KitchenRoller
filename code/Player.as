package code {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import code.PlayerStates.*;
	import code.CoinStates.*;
	
	
	public class Player extends GameObject {
		//states
		/** The State the player is in, in terms of running/jumping/idle. */
		public var state: PlayerState;
		/** The State the player is in, in terms of penny/nickel/quarter. */
		public var coinState: CoinState = new NickelState();
		
		/** The radius of the player, used for radial collision */
		public var radius: Number = 22.5;
		
		/** The constant gravity for the player */
		private const GRAVITY: int = 150;
		/** The speed the coin rotates, in degrees/second */
		private const ROTATION_SPEED: Number = 360;
		
		/** The y velocity of the player */
		public var vy: Number = 0;
		
		/** Is false if the player is in the descending part of the jump or is grounded. */
		public var isJumping: Boolean = false;
		/** Is true if the player is on the ground, can jump again if it is. */
		public var isGrounded: Boolean = false;
		
		/** Goes to the first frame */
		public function Player() {
			// constructor code
			gotoAndStop(1);
		}
		
		/** Checks for new states and coinstates, rotates, and applies physics. */
		override public function update(): void
		{
			
			if(state == null)
			{	
				state = new PlayerStateAir();
				state.onEnter(this);
			}
			var newState: PlayerState = state.update();
			if(newState != null)
			{
				state.onExit();
				state = newState;
				state.onEnter(this);
			}
			
			if(coinState == null)
			{
				coinState = new NickelState();
				coinState.onEnter(this);
			}
			var newCoinState: CoinState = coinState.update();
			if(newCoinState != null)
			{
				coinState.onExit();
				coinState = newCoinState;
				coinState.onEnter(this);
			}
			
			rotate();
			
			//if(isGrounded) vy = 0;
			
			applyPhysics();
			
			isGrounded = false;//so i cant jump if i fall off the table, this should be commented out
			
		}
		
		/** 
		 * Updates gravity 
		 * @param gravityScalar The scale for the gravity variable, default is 1.
		 */
		public function applyGravity(gravityScalar: Number = 1): void
		{
			// apply gravity
			vy += GRAVITY * gravityScalar * Game.deltaTime; // gravity scalar makes it so the longer you hold the jump button the higher you jump
		}
		
		/** Does the jumping ability */
		public function doJumping(): void
		{
			if(vy > 0 || !KeyboardState.isKeyDown(Keyboard.SPACE)) isJumping = false;
			//jump
			if(isGrounded && KeyboardState.onKeyDown(Keyboard.SPACE))
			{
				vy = -30;
				isGrounded = false;
				isJumping = true;
			}
		}
		
		/** Updates velocity and checks if the player has fallen off the screen */
		private function applyPhysics(): void
		{
			y += vy; // should be times delta time, since gravity is /sec^2 and vel is /sec, should be multiplying gravity by delta time twice.
			
			if(y > 800)
			{
				isDead = true;
			}
		}
		
		/** Rotates the player */
		private function rotate(): void
		{
			rotation += ROTATION_SPEED * Game.deltaTime;
		}
		
		/** 
		 * Apllies the fix if the player is overlapping with another object.
		 * @param fix A point object, the distance needed to move.
		 */
		public function applyFix(fix: Point): void
		{
			x += fix.x;  
			y += fix.y; 
			
			if(fix.y != 0)
			{
				if(fix.y < 0) vy = 0;
				isGrounded = true;
			}
			
		}
	}
	
}
