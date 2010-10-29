package com.godstroke.flixel
{
	import org.flixel.FlxButton;
	import flash.events.MouseEvent;
	import org.flixel.FlxG;
	
	
	public class GsFlxButton extends FlxButton
	{
		public var callbackParams:Object;
		
		public function GsFlxButton(X:int, Y:int, Callback:Function)
		{
			//TODO: implement function
			super(X, Y, Callback);
		}
		
		override protected function onMouseUp(event:MouseEvent):void
		{
			if(!exists || !visible || !active || !FlxG.mouse.justReleased() || (_callback == null)) return;
			if(overlapsPoint(FlxG.mouse.x,FlxG.mouse.y)) _callback(callbackParams ? callbackParams : null);
		}
	}
}