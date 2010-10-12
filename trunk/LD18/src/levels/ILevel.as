package levels
{
	import actors.Tractor;
	import actors.TractorProps;
	
	import effects.EmitterProps;

	public interface ILevel
	{
		function displayAngle(angle:Number):void;
		function getTractorProps():TractorProps;
		function getTractor():Tractor;
	}
}