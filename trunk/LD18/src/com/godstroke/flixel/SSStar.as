package com.godstroke.flixel
{
	import org.flixel.FlxSprite;
	
	public class SSStar extends FlxSprite
	{
		[Embed(source="gfx/simpleStar.png")] protected var gfx_simpleStar:Class;
		
		public function SSStar(X:Number=0, Y:Number=0)
		{
			
			super(X, Y, gfx_simpleStar);
		}
	}
}