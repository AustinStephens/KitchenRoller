package code.GameScenes {
	import flash.geom.Point;
	import flash.display3D.IndexBuffer3D;
	import code.*;
	import code.Sounds.SoundDead;
	
	public class GameScenePlay extends GameScene{
		/** Speed the objects move to the left at. In pixels / second. */
		public static const MOVEMENT_SPEED: Number = 500;
		/** The sapce between each table. In pixels. */
		public const GAP: Number = 200;
		/** X coordinate the new tables are spawned at. */
		public const NEW_TABLE_LOCATION: Number = (Table.WIDTH + GAP) * 3 + 200;
		
		//constants for adding tables
		/** Minimum y coordinate the table can be spawned at. */
		private const TABLE_Y_MIN: int = 600;
		/** Maximum y coordinate the table can be spawned at. */
		private const TABLE_Y_MAX: int = 800;
		
		/**  Amount of seconds between each table being spawned. */
		public var tableDelayMax: Number = (Table.WIDTH + GAP) / MOVEMENT_SPEED;
		/** How long until next table is spawned. */
		public var tableDelay: Number = tableDelayMax;
		
		/** List of all objects in the scene, except the player. */
		public var sceneGraph: Array = new Array(); // just a list of objects in the scene, trying to relate it to features in other game Engines
		
		/** Reference the the player variable */
		public var player: Player;
		/** The first background */
		private var ground1: BackGround = new BackGround();
		/** The second background */
		private var ground2: BackGround = new BackGround();
		
		/** Displays the score. */
		private var scoreText: ScoreText = new ScoreText();
		/** Displays how much quarter power charge the player has. */
		private var quarterBar: Bar = new Bar();
		/** Used to keep track of how many coins have been picked up, also used to tell the quarter bar what frame to be at. */
		static public var quarterFrame: int = 1;
		
		/** How long the slow motion effect has left. */
		public var slowTimer: Number = 0;
		/** How long the double points effect has left. */
		public var dblTimer: Number = 0;
		/** The amount of seconds each effect lasts for. */
		public const POWER_UP_MAX: Number = 3;
		
		/** Called right after the scene is first changed to. Sets up the scene. */
		override public function onEnter(): void
		{
			stage.focus = stage;
			// SETTING UP UI /////////////////////////////
			scoreText.scoreTextField.text = "Score: 0";
			scoreText.x = 75;
			scoreText.y = 75;
			addChild(scoreText);
			
			quarterBar.x = 75;
			quarterBar.y = 150;
			quarterBar.gotoAndStop(1);
			addChild(quarterBar);
			
			// SETTING UP BACKGROUND /////////////////////////
			ground1.x = 0;
			ground2.x = ground1.width;
			ground1.alpha = .75;
			ground2.alpha = .75;
			addChildAt(ground1, 0);
			addChildAt(ground2, 1);
			
			var table: Table = new Table(200, 700);
			sceneGraph.push(table);
			addChildAt(table, 2);
			
			//SPAWNING TABLES /////////////////////////////
			for(var i: int = 1; i < 4; i++)
			{
				spawnNewTable((Table.WIDTH + GAP) * i + 200);
			}
			// SPAWNING PLAYER ////////////////////////////
			player = new Player();
			player.x = 75;
			player.y = 0;
			addChildAt(player, 3);
		}
		/** Called right before the scene is changed. */
		override public function onExit(): void
		{
			quarterFrame = 1;
		}
		/**
		 * Called every frame. Checks if we need to change scenes. Updates timers, calls objects' update functions, checks for collisions.
		 * @return GameScene Returns a new game scene if necessary.
		 */
		override public function update(): GameScene
		{
			// COUNTERS ////////////////////////////////////
			tableDelay -= Game.deltaTime;
			if(tableDelay <= 0)
			{
				spawnNewTable(NEW_TABLE_LOCATION);
				tableDelay = tableDelayMax;
			}
			
			slowTimer -= Game.deltaTime;
			Game.timeScale = (slowTimer > 0 ? .5 : 1);
			dblTimer -= Game.deltaTime;
			
			score += Game.deltaTime * 10 * (dblTimer > 0 ? 2 : 1);
			scoreText.scoreTextField.text = "Score: " + int(score);
			var i: int; //reusing the same iterator variable
			
			/// UPDATES ///////////////////////
			updateBackground();
			player.update();
			if(player.isDead)
			{
				quarterFrame = 1;
				var sound: SoundDead = new SoundDead();
				sound.play();
				return new GameSceneLose();
			}
			
	
			
			//COLLISION DETECTION AND UPDATE /////////
			
			for(i = sceneGraph.length - 1; i >= 0; i--)
			{
				sceneGraph[i].update();
				if(sceneGraph[i].isDead)
				{
					onIsDead(sceneGraph[i], i); // allows each gameobject to define their death response in their class
				} // This is discrete movement, not continuous.
				else if(sceneGraph[i].collisionBoxes[0].checkOverlapWithRadial(player))
				{
					sceneGraph[i].onCollision(player, this); // allows each gameobject to define their collision response in their class
				}
			}
			
			// Updating qbar
			updateQBarFrame();
			
			return null;
		}
		
		/** 
		 * Spawns new table and an obstacle on it.
		 * @param newx X coordinate of the new table.
		 */
		private function spawnNewTable(newx: Number): void
		{
			// orangeRNG is named poorly, it determines whether we spawn and obstacle or a pillar
			var orangeRNG: int = Math.floor(Math.random() * 4); // 0-3
			var powerUpRNG: int = Math.floor(Math.random() * 2); // 0-1
			
			var newy: Number = Math.random() * (TABLE_Y_MAX - TABLE_Y_MIN) + TABLE_Y_MIN;
			
			var table: Table = new Table(newx, newy);
			sceneGraph.push(table);
			addChildAt(table, 2);
			
			var obstacle: GameObject;
			if(orangeRNG != 0) { // want the orange to spawn 3/4 of the time
				var obstRNG: int = Math.random() * 2; // 50/50 for keys/orange
				if(obstRNG == 0)  
					obstacle = new Orange(newx, newy);
				else
					obstacle = new Keys(newx,newy);
				
				if(powerUpRNG == 0)  // dont want this to spawn if a barrier is there
				{
					var whichPowerUp: int = Math.floor(Math.random() * 5); // 0-2 = coin, 2 = dblPoints , 3 = slow time
					var powerUp: GameObject;
					if(whichPowerUp <= 2)
						powerUp = new CoinPickup(newx, newy - Table.WIDTH / 2 - 80);  //table is a square, so I can use width instead of height
					else if (whichPowerUp == 3)
						powerUp = new DblPoints(newx, newy - Table.WIDTH / 2 - 80);
					else
						powerUp = new Slow(newx, newy - Table.WIDTH / 2 - 80);
		
					sceneGraph.push(powerUp);
					addChild(powerUp);
				}
			}
			else {
				obstacle = new Pillar(newx, newy);
			}
			sceneGraph.push(obstacle);
			addChild(obstacle);
			
			
			
		}
		
		/** * Moves the backgrounds, when the first is offscreen switches the two backgrounds so the first is now behind the second */
		private function updateBackground(): void //did this so i never have a gap between the two backgrounds
		{
			ground1.x -= GameScenePlay.MOVEMENT_SPEED * Game.deltaTime * .75;
			if(ground1.x < -ground1.width) // when the first goes completely off the screen
			{	//makes the first background become the second, so it will be at the end of the second now
				var tempGround: BackGround = ground1;
				ground1 = ground2;
				ground2 = tempGround;
			}
			
			ground2.x = ground1.x + ground1.width;
		}
		
		public function updateQBar(): void
		{
			if(quarterFrame < 5)
				quarterFrame++;
		}
		
		public function updateQBarFrame(): void
		{
			if(quarterFrame <= 5 && quarterFrame >= 1)
				quarterBar.gotoAndStop(quarterFrame);
		}
		
		private function onIsDead(obj: GameObject, i: int): void
		{
			removeChild(obj);
			sceneGraph.removeAt(i);
		}
		

	}
	
}
