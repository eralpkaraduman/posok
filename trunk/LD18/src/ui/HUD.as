package ui
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	
	public class HUD extends FlxGroup
	{
		private var w:Number = FlxG.width;
		private var h:Number = FlxG.width;
		
		private var minimap:FlxGroup;
		private var healthBar:FlxGroup;
		private var guide:FlxObject;
		
		public function HUD()
		{
			
			
			
			/*
			
			var hud:FlxSprite = new FlxSprite(10,10)
			
			hud.createGraphic(150,150,0x880000ff);
			add(hud);
			
			*/
			super();
		}
		
	}
}