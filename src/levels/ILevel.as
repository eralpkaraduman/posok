package levels
{
	import actors.Drone;
	import actors.ISpaceObject;
	import actors.Tractor;
	import actors.TractorProps;
	import org.flixel.FlxObject;
	
	import effects.EmitterProps;

	public interface ILevel
	{
		function displayAngle(angle:Number):void;
		function getTractorProps():TractorProps;
		function getTractor():Tractor;
		
		function muteTractor():void;
		function unmuteTractor():void;
		function changeFocusTo(o:FlxObject):void;
		
		function actorStatusChanged(so:ISpaceObject):void;
	}
}