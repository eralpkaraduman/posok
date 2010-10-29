package com.godstroke.flixel
{
	import org.flixel.FlxSprite;
	
	public class SpaceThing extends FlxSprite
	{
		//[Embed(source="gfx/simpleStar.png")] protected var gfx_simpleStar:Class;
		
		public function SpaceThing(X:Number=0, Y:Number=0)
		{
			super(X, Y);
			createGraphic(1, 1, 0xffffffff);
			
		}
	}
}