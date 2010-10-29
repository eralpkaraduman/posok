package com.godstroke.flixel
{
	import actors.Tractor;
	import flash.accessibility.Accessibility;
	import levels.ILevel;
	import org.flixel.*;
	
	public class StarSpawner extends FlxObject {
		private var _stars:FlxGroup;
		private var _starBag:Vector.<SpaceThing> = new Vector.<SpaceThing>();
		private var level:FlxState;
		private var _numThingsOnScreen:Number;
		private var _drag:Number;
		private var testt_hing:SpaceThing;
		private var disp:FlxText;
		
		
		
		override public function StarSpawner(drag:Number,numThingsOnScreen:Number=9):void {
			super();
			this._drag = drag;
			this._numThingsOnScreen = numThingsOnScreen;
			level = FlxG.state as FlxState;
			init();
		}
		
		private function init():void {
			for (var i:int = 0; i < _numThingsOnScreen; i++) 
			{
				var thing:SpaceThing = new SpaceThing();
				thing.x = getRandomPosInScreen().x;
				thing.y = getRandomPosInScreen().y;
				thing.alpha = _drag;
				thing.scrollFactor = new FlxPoint(_drag, _drag);
				_starBag.push(thing);
				level.add(thing);
			}
		}
		
		public function draw() :void{
			
			for (var i:int = 0; i < _starBag.length; i++) 
			{
				var thing:SpaceThing = _starBag[i];
				
				if (!thing.onScreen()) {
					if (thing.getScreenXY().x < 0) thing.x += FlxG.width;
					if (thing.getScreenXY().x > FlxG.width) thing.x -= FlxG.width;
					
					if (thing.getScreenXY().y < 0) thing.y += FlxG.height;
					if (thing.getScreenXY().y > FlxG.height) thing.y -= FlxG.height;
				}
			}
		}
		
		private function isInScreen(thing:SpaceThing):Boolean
		{
			if (!thing.onScreen()) {
				thing.flicker(5);
			}
			return false;
		}
		
		private function getRandomPosInScreen():FlxPoint {
			return new FlxPoint(Math.random()*FlxG.width,Math.random()*FlxG.height);
		}
	}
	
}