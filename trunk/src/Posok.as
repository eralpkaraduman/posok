package

{

	import org.flixel.*;

	[SWF(width="960", height="640", backgroundColor="#000000",frameRate="60")]

	[Frame(factoryClass="Preloader")]



	public class Posok extends FlxGame
	{
		public function Posok()

		{
			super(480,320,MenuState,2);
		}
	}

}

