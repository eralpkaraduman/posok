package com.godstroke.flixel 
{
	import flash.geom.Rectangle;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class ProgressBar extends FlxGroup 
	{
		private var _rectangle:Rectangle;
		public var border:FlxGroup;
		public var bar:FlxSprite;
		public var border_n:FlxSprite;
		public var border_w:FlxSprite;
		public var border_e:FlxSprite;
		public var border_s:FlxSprite;
		
		public function ProgressBar(rect:Rectangle)
		{
			super();
			this._rectangle = rect;
			
			scrollFactor = new FlxPoint(0,0);
			border = new FlxGroup();
			border.scrollFactor= new FlxPoint(0,0);
			
			border_n = new FlxSprite(rect.x, rect.y);
			border_n.createGraphic(rect.width, 1);
			border_n.scrollFactor= new FlxPoint(0,0);
			border.add(border_n);
			
			border_w = new FlxSprite(rect.x, rect.y);
			border_w.createGraphic(1, rect.height);
			border_w.scrollFactor= new FlxPoint(0,0);
			border.add(border_w);
			
			border_e = new FlxSprite(rect.x+rect.width-1, rect.y);
			border_e.createGraphic(1, rect.height);
			border_e.scrollFactor= new FlxPoint(0,0);
			border.add(border_e);
			
			border_s = new FlxSprite(rect.x, rect.y+rect.height-1);
			border_s.createGraphic(rect.width, 1);
			border_s.scrollFactor= new FlxPoint(0,0);
			border.add(border_s);
			
			add(border);
			
			bar = new FlxSprite(rect.x + 1, rect.y + 1);
			bar.createGraphic(rect.width - (1 * 2), rect.height - (1 * 2));
			bar.scrollFactor = new FlxPoint(0, 0);
			bar.origin.x = 0;
			bar.origin.y = 0;
			add(bar);
			
			bar.scale.x = 0;
		}
		
		/**
		 * Displays passed percentage on progressbar
		 * @param	percent range 1.0 -> 0.0
		 */
		public function step(percent:Number):void
		{
			bar.scale.x = percent;
			//bar.x = (_rect.width-2)*percent;
		}
		
	}

}