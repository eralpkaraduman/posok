package actors 
{
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class Drone extends FlxSprite
	{
		[Embed(source = "../../gfx/drone.png")] private var gfx_drone:Class;
		public function Drone(X:Number = 0, Y:Number = 0) 
		{
			super(X, Y);
			loadGraphic(gfx_drone, true, true, 15, 16);
			addAnimation("scaning", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 8, true);
			play("scaning");
		}
		
	}

}