package levels
{
	import actors.Drone;
	import actors.Tractor;
	import actors.TractorProps;
	import actors.TractorShipThruster;
	import com.godstroke.flixel.SpaceThing;
	import com.godstroke.flixel.StarField;
	import com.godstroke.flixel.StarSpawner;
	
	import effects.EmitterProps;
	
	import flashx.textLayout.elements.OverflowPolicy;
	
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
		
		
		// pass any other actor here
		public var cameraFocus:FlxObject = new FlxObject(FlxG.width/2,FlxG.height/2);
		
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
			
			//FlxG.follow(cameraFocus,2);
			FlxG.follow(tractor,1);
			//changeFocusTo(tractor);
			
			hud = new HUD();
			hud.scrollFactor = new FlxPoint(0, 0); // glues it there;
			add(hud);
			
			// testing drones
			var drone:Drone = new Drone(150, 150);
			add(drone);
			//--
			
			
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
		
		
		
		
	}
	
	
	
	
}