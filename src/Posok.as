package

{

	import org.flixel.*;

	//[SWF(width="960", height="640", backgroundColor="#000000",frameRate="32")]
	//[SWF(width="480", height="320", backgroundColor="#000000",frameRate="12")]

	[Frame(factoryClass="Preloader")]



	public class Posok extends FlxGame
	{
		[Embed(source = "../gfx/cursor.png")] private var gfx_cursor:Class;
		public function Posok()

		{
			super(480, 320, MenuState, 2);
			FlxG.mouse.show(gfx_cursor, 3, 3);
		}
	}

}

