package actors 
{
	import levels.ILevel;
	import org.flixel.FlxButton;
	import org.flixel.FlxEmitter;
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
		[Embed(source = "../../gfx/electric_sparks.png")] private var gfx_electric_sparks:Class;
		private var statusChangeGlow_thanPlay:String = null;
		private var statusChangeGlow_thanPlay_timer:Number = 0;
		private var emitter:FlxEmitter;
		private var sparking:Boolean = false;
		public function Drone(X:Number = 0, Y:Number = 0) 
		{
			super(X, Y);
			//loadGraphic(gfx_drone, true, true, 15, 16);
			loadGraphic(gfx_drone, true, true, 16, 16);
			addAnimation("scaning", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 8, true);
			addAnimation("broken", [25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35], 8, true);
			addAnimation("flicker", [5, 24], 8, true);
			//addAnimation("scaning", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 8, true);
			
			this.offset.x = 8;
			this.offset.y = 8;
			
			// broken drone electric spark particle emitter
			emitter = new FlxEmitter(0, 0);
			emitter.createSprites(gfx_electric_sparks, 3, 1, true, 0);
			emitter.delay = .2;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			var speed:Number = 50;
			emitter.setXSpeed( -speed, speed);
			emitter.setYSpeed( -speed, speed);
			emitter.x = this.x;
			emitter.y = this.y; //TODO: I may need to update emitters position if drone moves
			
			ILevel(FlxG.state).addEmitter(emitter); 
			
			play("broken");
			toggleSparks(true);
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
			//play("scaning");
			statusChangeGlow("scaning");
			toggleSparks(false);
			currentStatus = ActorStatuses.DRONE_ROUTINE;
			return true; // success
		}
		
		private function DRONE_BROKEN():Boolean {
			//play("broken");
			statusChangeGlow("broken");
			toggleSparks(true);
			currentStatus = ActorStatuses.DRONE_BROKEN;
			return true; // success
		}
		
		public function getCurrentStatus():String {
			return currentStatus;
		}
		
		// sub statuses, transitions etc.
		public function statusChangeGlow(thanPlay:String):void {
			play("flicker");
			statusChangeGlow_thanPlay = thanPlay;
			//play("broken");
			
		}
		
		override public function update():void{
			
			if (statusChangeGlow_thanPlay) { // if an animation is queued after flickering animation, wait for it.
				statusChangeGlow_thanPlay_timer += FlxG.elapsed;
				if (statusChangeGlow_thanPlay_timer >= 2) {
					play(statusChangeGlow_thanPlay); // play the queued animation
					statusChangeGlow_thanPlay = null;
					statusChangeGlow_thanPlay_timer = 0;
				}
			}
			/*
			if (currentStatus == ActorStatuses.DRONE_BROKEN) {
				if (this.onScreen() && !sparking) {
					toggleSparks(true);
				}
				//emitter.emitParticle();
			}
			*/
			super.update();
		}
		
		private function toggleSparks(on:Boolean):void {
			if (on && !sparking) {
				sparking = true;
				emitter.start(false, .2,0 );
			}else if(!on && sparking){
				sparking = false;
				emitter.stop(3);
			}
		}
	}

}