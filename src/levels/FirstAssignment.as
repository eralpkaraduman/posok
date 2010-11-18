package levels
{
	import actors.ActorStatuses;
	import actors.Drone;
	import actors.ISpaceObject;
	import actors.Tractor;
	import actors.TractorProps;
	import actors.TractorShipThruster;
	import com.godstroke.flixel.SpaceThing;
	import com.godstroke.flixel.StarField;
	import com.godstroke.flixel.StarSpawner;
	import flash.geom.Point;
	import org.flixel.FlxU;
	import ui.NaviCom;
	
	import effects.EmitterProps;
	
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import ui.HUD;
	
	
	public class FirstAssignment extends FlxState implements ILevel
	{
		private var tractor:Tractor;
		private var tractorThruster:TractorShipThruster;
		public var hud:HUD;
		
		//emitters
		[Embed(source = "../../gfx/thrusterBurst.png")] private var em_thrusterBurst:Class;
		private var tractorThrusterEmitter:FlxEmitter;
		private var scenery_1:StarSpawner;
		private var scenery_2:StarSpawner;
		private var scenery_3:StarSpawner;
		
		//hud
		private var naviCom:NaviCom;
		
		// pass any other actor here
		public var cameraFocus:FlxObject = new FlxObject(FlxG.width/2,FlxG.height/2);
		private var droneGroup:FlxGroup;
		
		override public function create():void
		{
			tractor = new Tractor(FlxG.width/2,FlxG.height/2);
			tractorThruster = new TractorShipThruster();
			tractor.thruster = tractorThruster;
			
			scenery_1 = new StarSpawner(.7);
			scenery_2 = new StarSpawner(.5);
			scenery_3 = new StarSpawner(.3);
			
			
			add(tractorThruster);
			add(tractor);
			
			FlxG.follow(tractor,1);
			FlxG.followAdjust(2, 2*(FlxG.height/FlxG.width));
			
			hud = new HUD();
			
			// testing drones
			droneGroup = new FlxGroup();
			var drone1:Drone = new Drone(400, 400);
			droneGroup.add(drone1);
			var drone2:Drone = new Drone(-510, -440);
			droneGroup.add(drone2);
			var drone3:Drone = new Drone(312, -652);
			droneGroup.add(drone3);
			var drone4:Drone = new Drone(-213, 521);
			droneGroup.add(drone4);
			//var drone5:Drone = new Drone(150, -350);
			var drone5:Drone = new Drone(50, 50);
			droneGroup.add(drone5);
			add(droneGroup);
			
			hud.addToTracker(drone1);
			hud.addToTracker(drone2);
			hud.addToTracker(drone3);
			hud.addToTracker(drone4);
			hud.addToTracker(drone5);
			
			add(hud);
			//-
			
		}
		
		//debug
		public function displayAngle(angle:Number):void{
			return;
			FlxG.log("angle: "+angle);
		}
		
		
		override public function update():void{
			
			
			super.update();
			scenery_1.draw();
			scenery_2.draw();
			scenery_3.draw();
			hud.step();
		}
		
		
		
		
		
		public function getTractorProps():TractorProps{
			return new TractorProps(tractor.x,tractor.y,tractor.facing,tractor.aimAngle());
		}
		
		public function getTractor():Tractor{
			return tractor;
		}
		
		public function changeFocusTo(o:FlxObject):void{
			cameraFocus = o;
			FlxG.followTarget = cameraFocus;
		}
		
		public function muteTractor():void {
			tractor.canMove = false;
			tractor.thruster.hideThrusterBurst();
		}
		
		public function unmuteTractor():void {
			tractor.canMove = true;
		}
		
		public function actorStatusChanged(so:ISpaceObject):void {
			if (so.getCurrentStatus() == ActorStatuses.DRONE_ROUTINE) {
				hud.removeFromTracker(FlxObject(so));
				//trace("hud.naviCom.trackList.length " + hud.naviCom.trackList.length);
				//trace("hud.naviCom.notNullTrackerListLength " + hud.naviCom.notNullTrackerListLength);
				if (hud.naviCom.notNullTrackerListLength <= 0) {
					levelClear();
				}
			}
		}
		
		private function levelClear():void
		{
			var levelClearTX:FlxText = new FlxText(0, FlxG.height / 2, FlxG.width, "MISSION SUCCESSFUL!");
			levelClearTX.alignment = "center";
			levelClearTX.scrollFactor = new FlxPoint(0, 0);
			add(levelClearTX);
			
			FlxG.fade.start(0xff000000, 3, onLevelCLearFadeComplete, true);
			
		}
		
		private function onLevelCLearFadeComplete():void
		{
			FlxG.state = new PlayState();
			return;
		}
		
		public function addEmitter(emitter:FlxEmitter):void {
			add(emitter);
		}
		
		
		
	}
	
	
	
	
}