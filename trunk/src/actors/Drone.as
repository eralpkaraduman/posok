package actors 
{
	import levels.ILevel;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class Drone extends FlxSprite implements ISpaceObject
	{
		private var currentStatus:String;
		//[Embed(source = "../../gfx/drone.png")] private var gfx_drone:Class;
		//[Embed(source = "../../gfx/broken_drone_idle.png")] private var gfx_drone:Class;
		[Embed(source = "../../gfx/drone_anims_joined_spritesheet.png")] private var gfx_drone:Class;
		public function Drone(X:Number = 0, Y:Number = 0) 
		{
			super(X, Y);
			//loadGraphic(gfx_drone, true, true, 15, 16);
			loadGraphic(gfx_drone, true, true, 16, 16);
			addAnimation("scaning", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 8, true);
			addAnimation("broken", [25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35], 8, true);
			//addAnimation("scaning", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 8, true);
			
			this.offset.x = 8;
			this.offset.y = 8;
			
			play("broken");
		}
		
		public function setStatus(string:String):Boolean {
			var success:Boolean = false;
			if (this[string]) {
				success = this[string]();
			}else {
				success = false;
			}
			if (success) ILevel(FlxG.state).actorStatusChanged(this);
			return success;
		}
		
		/// ACTOR STATUSES //
		/**
		 * All status switch functions must return true/false in meanin of success.
		 * 
		 */
		
		private function DRONE_ROUTINE():Boolean {
			play("scaning");
			currentStatus = ActorStatuses.DRONE_ROUTINE;
			return true; // success
		}
		
		private function DRONE_BROKEN():Boolean {
			play("broken");
			currentStatus = ActorStatuses.DRONE_BROKEN;
			return true; // success
		}
		
		public function getCurrentStatus():String {
			return currentStatus;
		}
		
	}

}