package ui 
{
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class NaviComPointer extends FlxSprite
	{
		[Embed(source = "../../gfx/naviComPointer.png")] private var gfx_pointer:Class;
		public function NaviComPointer() 
		{
			//createGraphic(10, 10, 0x88ff0000);
			//loadRotatedGraphic(gfx_pointer, 4);
			loadGraphic(gfx_pointer, true, false, 5, 5);
			addAnimation("U", [0]);/**/
			addAnimation("D", [1]);/**/
			addAnimation("R", [2]);
			addAnimation("L", [3]);/**/
			addAnimation("UL", [4]);/**/
			addAnimation("UR", [5]);/**/
			addAnimation("DL", [6]);/**/
			addAnimation("DR", [7]);/**/
			//addAnimation("LOCK", [8,9],12,true);
			addAnimation("LOCK", [9]);
			play("U", true);
		}
		
		public function direct(deg:Number):void {
			var ints:Number = 360 / 8 ;
			if (deg > 0 && deg < ints * 1) { play("R"); return; }
			else if (deg > ints * 1 && deg < ints * 2) { play("DR"); return; }
			else if (deg > ints * 2 && deg < ints * 3) { play("D"); return; }
			else if (deg > ints * 3 && deg < ints * 4) { play("DL"); return; }
			else if (deg > ints * 4 && deg < ints * 5) { play("L"); return; }
			else if (deg > ints * 5 && deg < ints * 6) { play("UL"); return; }
			else if (deg > ints * 6 && deg < ints * 7) { play("U"); return; }
			else{ play("UR"); return;}
		}
		
	}

}