package levels
{
	import actors.Tractor;
	import actors.TractorProps;
	import actors.TractorShipThruster;
	
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
		public var scenery:L1_scenery;
		
		//emitters
		[Embed(source = "../../gfx/thrusterBurst.png")] private var em_thrusterBurst:Class;
		private var tractorThrusterEmitter:FlxEmitter;
		
		// pass any other actor here
		public var cameraFocus:FlxObject = new FlxObject(FlxG.width/2,FlxG.height/2);
		
		override public function create():void
		{
			 scenery = new L1_scenery();
			 add(scenery);
			
			
			tractor = new Tractor(FlxG.width/2,FlxG.height/2);
			tractorThruster = new TractorShipThruster();
			tractor.thruster = tractorThruster;
			add(tractorThruster);
			add(tractor);
			
			FlxG.follow(cameraFocus,2);
			
			changeFocusTo(tractor);
			
			hud = new HUD();
			add(hud);
			
			
		}
		
		//debug
		public function displayAngle(angle:Number):void{
			return;
			FlxG.log("angle: "+angle);
		}
		
		
		override public function update():void{
			
			
			
			super.update();
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