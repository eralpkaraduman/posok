package ui 
{
	import actors.Tractor;
	import flash.geom.Point;
	import org.flixel.data.FlxMouse;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import actors.ISpaceObject;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class NaviCom extends FlxGroup
	{
		private var _trackList:Vector.<FlxObject> = new Vector.<FlxObject>()
		private var _pointerList:Vector.<NaviComPointer>  = new Vector.<NaviComPointer>();
		private var _tractor:Tractor;
		private var _trackerEnum:uint = 0;
		
		private var _trackTarget:FlxSprite;
		
		
		
		public function NaviCom(tractorRef:Tractor) 
		{
			_tractor = tractorRef;
			
			
		}
		
		public function addToTracker(flxObj:FlxSprite):void {
			
			// make pointer
			var ptr:NaviComPointer = new NaviComPointer();
			ptr.scrollFactor = new FlxPoint(0,0);
			_pointerList[_trackerEnum] = ptr;
			add(ptr);
			// add to list
			_trackList[_trackerEnum] = flxObj;
			_trackerEnum++;
			
		}
		
		public function scan():void {
			for (var i:int = 0; i <_trackList.length ; i++) 
			{
				var trackTarget:FlxObject = _trackList[i];
				var trackPointer:NaviComPointer = _pointerList[i];
				var ttp:Point = new Point(trackTarget.getScreenXY().x, trackTarget.getScreenXY().y);
				
				var lmin:Number = 5;
				var lmax_v:Number = FlxG.height - 10;
				var lmax_h:Number = FlxG.width - 10;
				
				trackPointer.x = ttp.x < lmin ? lmin : ttp.x;
				trackPointer.x = trackPointer.x > lmax_h ? lmax_h : trackPointer.x;
				
				trackPointer.y = ttp.y > lmax_v ? lmax_v : ttp.y;
				trackPointer.y = trackPointer.y < lmin ? lmin : trackPointer.y;
				
				if(trackPointer.y == lmin && trackPointer.x == lmax_h) trackPointer.play("UR", true);
				else if(trackPointer.y == lmin && trackPointer.x == lmin) trackPointer.play("UL", true);
				else if(trackPointer.y == lmax_v && trackPointer.x == lmax_h)trackPointer.play("DR", true);
				else if(trackPointer.y == lmax_v && trackPointer.x == lmin)trackPointer.play("DL", true);
				else if (trackPointer.y == lmin) trackPointer.play("U", true);
				else if (trackPointer.y == lmax_v) trackPointer.play("D", true);
				else if (trackPointer.x == lmax_h) trackPointer.play("R", true);
				else if (trackPointer.x == lmin) trackPointer.play("L", true);  
				else trackPointer.play("LOCK", true)
				
				//trackPointer.y = 50;
				
				/*
				var out_left:Boolean = false;
				var out_right:Boolean = false;
				var out_top:Boolean = false;
				var out_bottom:Boolean = false;
				*/
				// out of left bounds?
				
				//if (trackTarget.getScreenXY().x < 0) out_left = true;
				//if()
				
				//out of right bounds?
				
				//out of top bounds?
				
				// out of bottom bounds?
				
				/*
				if (_pointerList[i].dead) {
					_pointerList[i].visible = false;
					continue;
				}else {
					_pointerList[i].visible = true;
				}
				
				
				//if (_trackList[i].onScreen()) {
				if (_trackList[i].onScreen()) {
					_pointerList[i].x = _trackList[i].getScreenXY().x + _trackList[i].width/2 - 2;
					_pointerList[i].y = _trackList[i].getScreenXY().y + _trackList[i].height/2 - 2;
					_pointerList[i].play("LOCK",true);
				}else{
				
					//////////////////
					//////////////////
					
					// check proximity
					var len:Number = 20; // some ridiculously large number.. will be trimmed later
					var aim_degs:Number = aimAngle(_trackList[i]);
					var aim_rads:Number = aim_degs * (Math.PI / 180); //convert the fire angle from degrees into radians and apply that value to the radian fire angle variable
					
					var x_targ:Number = (Math.cos(aim_rads) * len);
					var y_targ:Number = (Math.sin(aim_rads) * len);
					
					var x_center:Number = _tractor.getScreenXY().x + _tractor.width / 2;
					var y_center:Number = _tractor.getScreenXY().y + _tractor.height / 2;
					
					x_targ = x_targ + x_center; 
					y_targ = y_targ + y_center; 
					
					_pointerList[i].x = x_targ - 5; 
					_pointerList[i].y = y_targ - 5;
					
					_pointerList[i].direct(aim_degs);
					
				}
				*/
				
			}
		}
		
		public function aimAngle(target:FlxSprite):Number
		{
			/*
			var from:Point= FlxG.scroll;
			var to:FlxSprite = target;
			*/
			var from:FlxSprite= _tractor;
			var to:FlxSprite = target;
			
			return FlxU.getAngle((to.x - from.x), (to.y - from.y));
		}
		
		public function get trackList():Vector.<FlxObject> { return _trackList; }
		
	}

}