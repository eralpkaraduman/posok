package ui
{
	import actors.Drone;
	import actors.ISpaceObject;
	import com.godstroke.flixel.ProgressBar;
	import com.godstroke.flixel.SpaceThing;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import levels.ILevel;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	public class HUD extends FlxGroup
	{
		private var w:Number = FlxG.width;
		private var h:Number = FlxG.width;
		
		private var minimap:FlxGroup;
		private var healthBar:FlxGroup;
		private var guide:FlxObject;
		private var naviCom:NaviCom;
		private var connectionTimer:Number;
		private var connecting:Boolean = false;
		private var connectingTo:FlxObject;
		private var connectEDTo:FlxObject;
		private var connectionStatusProgressBar:ProgressBar;
		private var connectionTimeOut:Number = 4;
		
		public function HUD()
		{
			super();
			this.scrollFactor = new FlxPoint(0, 0);
			
			
			/*
			
			var hud:FlxSprite = new FlxSprite(10,10)
			
			hud.createGraphic(150,150,0x880000ff);
			add(hud);
			
			*/
			
			//connection status progressbar
			var pb_w:Number = 200;
			var pb_h:Number = 20;
			connectionStatusProgressBar= new ProgressBar(new Rectangle(FlxG.width / 2 - pb_w / 2, FlxG.height - pb_h - 5, pb_w, pb_h));
			add(connectionStatusProgressBar);
			connectionStatusProgressBar.visible = false;
			//
			
			
			
		}
		
		public function addToTracker(flxObj:FlxSprite):void {
			if (!naviCom) {
				naviCom = new NaviCom(ILevel(FlxG.state).getTractor());
				add(naviCom);
			}
			
			naviCom.addToTracker(flxObj);
		}
		
		
		public function checkClick(screenXY:Point):void {
			trace(screenXY);
		}
		
		public function step():void
		{
			if (naviCom) naviCom.scan();
			
			// check clickz  ////////////////////////////////////////////////////////////////
			if (FlxG.mouse.justPressed() && !connectingTo) {
				//count
				
				// hold to connect
				//ILevel(FlxG.state).muteTractor();
				if (naviCom) {
					for (var i:int = 0; i <naviCom.trackList.length ; i++) 
					{
						if (FlxG.mouse.cursor.overlaps(naviCom.trackList[i])) {
							//ILevel(FlxG.state).muteTractor();
							beginConnectionTo(naviCom.trackList[i]);
							break;
						}
					}
				}
				
				
			}else if (FlxG.mouse.justReleased()) {
				/*
				connecting = false;
				//evaluate
				trace(connectionTimer);
				connectionTimer = 0;
				*/
				checkConnectionStatus();
			}
			
			if (connecting) connectionTimer += FlxG.elapsed;
			
			//display status on progressbar
			if (connecting) {
				if (!connectionStatusProgressBar.visible) connectionStatusProgressBar.visible = true;
				connectionStatusProgressBar.step(connectionTimer / connectionTimeOut);
			}
			
			// timeout
			if (connectionTimer >= connectionTimeOut) checkConnectionStatus();
			
			///////////////////////////////////////////////////////////////////////////////////
		}
		
		private function checkConnectionStatus():void
		{
			if (connectionTimer >= connectionTimeOut) {
				connectionEstablished();
			}else {
				connectionBroken();
			}
			
			connecting = false;
			connectionTimer = 0;
			connectionStatusProgressBar.visible = false;
		}
		
		private function connectionBroken():void
		{
			connectingTo = null
			connectEDTo = null
			ILevel(FlxG.state).unmuteTractor();
		}
		
		private function connectionEstablished():void
		{
			connectEDTo = connectingTo;
			connectingTo = null
			ILevel(FlxG.state).unmuteTractor();
		}
		
		private function beginConnectionTo(item:FlxObject):void
		{
			connectingTo = item;
			connectionTimer = 0;
			connecting = true;
			ILevel(FlxG.state).muteTractor();
		}
		
		
	}
}