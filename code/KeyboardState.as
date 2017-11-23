package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	import flash.ui.Keyboard;
	
	public class KeyboardState {

		/** List of keys this game uses so I can initialize them to false */
		private static var usedKeys: Array = new Array(Keyboard.SPACE, Keyboard.LEFT, Keyboard.RIGHT);
		
		/** A booleam tp track the current state for each key */
		private static var keyStates: Array = new Array();
		/** A boolean to track the previous state of each key on the keyboard */
		private static var keyStatesPrev: Array = new Array();
		// Might change to one array made of custom objects { var keystate: boolean; var keystateprev: boolean; }
		
		/** 
		 * Adds event listeners, initializes keys to false.
		 * @param stage A reference to the stage variable for the game.
		 */
		public static function setup(stage:Stage): void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			initialize(usedKeys);
		}
		/** 
		 * Checks if the given key is being pressed.
		 * @param keyCode The key being pressed.
		 * @return Boolean Whether the key given is being pressed.
		 */
		public static function isKeyDown(keyCode: int): Boolean
		{
			if(keyCode < 0) return false;
			if(keyCode >= keyStates.length) return true;
			
			return keyStates[keyCode];
		}
		/** 
		 * Checks if the given key is being pressed and it wasn't pressed in the last frame.
		 * @param keyCode The key in question.
		 * @return Boolean Whether the key given is being pressed and wasn't pressed in the last frame.
		 */
		public static function onKeyDown(keyCode: int): Boolean 
		{
			if(keyCode < 0) return false;
			if(keyCode >= keyStates.length) return true;
			
			return (keyStates[keyCode] && !keyStatesPrev[keyCode]);
		}
		/** Caches the keystates into the previous keystates. */
		public static function update():void {
			
			for(var i: int = 0; i < keyStates.length; i++)
			{
				keyStatesPrev[i] = keyStates[i];
			}
		}
		// Sets the given key to the given boolean
		private static function changeKey(keyCode:uint, isDown:Boolean):void {
			keyStates[keyCode] = isDown;
		}
		// Changes the key pressed to true
		private static function handleKeyDown(e:KeyboardEvent):void {
			changeKey(e.keyCode, true);
		}
		// Changes the key pressed to false
		private static function handleKeyUp(e:KeyboardEvent):void {
			changeKey(e.keyCode, false);
		}
		
		private static function initialize(keys: Array): void
		{
			for(var i: int = 0; i < keys.length; i++)
			{
				keyStates[keys[i]] = false;
				keyStatesPrev[keys[i]] = false;
			}
			
		}

	}
	
}
