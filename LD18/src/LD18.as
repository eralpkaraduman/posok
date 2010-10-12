package
{
	import org.flixel.*;
	[SWF(width="960", height="640", backgroundColor="#000000",frameRate="60")]
	[Frame(factoryClass="Preloader")]

	public class LD18 extends FlxGame
	{
		public function LD18()
		{
			super(480,320,MenuState,2);
		}
	}
}
