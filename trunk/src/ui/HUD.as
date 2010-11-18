package ui
{
	import actors.ActorStatuses;
	import actors.Drone;
	import actors.ISpaceObject;
	import com.godstroke.flixel.GsFlxButton;
	import com.godstroke.flixel.ProgressBar;
	import com.godstroke.flixel.SpaceThing;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	import levels.ILevel;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	
	public class HUD extends FlxGroup
	{
		private var w:Number = FlxG.width;
		private var h:Number = FlxG.width;
		
		private var minimap:FlxGroup;
		private var healthBar:FlxGroup;
		private var guide:FlxObject;
		private var _naviCom:NaviCom;
		private var connectionTimer:Number;
		private var connecting:Boolean = false;
		private var connectingTo:FlxObject = null;
		private var _connectEDTo:FlxObject = null;
		private var connectionStatusProgressBar:ProgressBar;
		private var connectionTimeOut:Number = 3;
		
		// -diagnostic mode items-
		private var diagnosticModeGroup:FlxGroup;
		
		private var crossHairGreen:FlxSprite;
		
		[Embed(source = "../../gfx/crossHairGreen.png")] private var gfx_crossHairGreen:Class;
		
		public function HUD()
		{
			super();
			this.scrollFactor = new FlxPoint(0, 0);
			
			
			diagnosticModeGroup = new FlxGroup();
			
			crossHairGreen = new FlxSprite(-2000, -2000, gfx_crossHairGreen);
			crossHairGreen.offset.x = 12;
			crossHairGreen.offset.y = 12;
			diagnosticModeGroup.add(crossHairGreen);
			
			var btn_disconnect:FlxButton = new FlxButton(20, 20, onDisconnectClick);
			btn_disconnect.scrollFactor = new FlxPoint(0, 0);
			var btn_disconnect_up:FlxText = new FlxText(0, 0, 100, "DISCONNECT");
			var btn_disconnect_down:FlxText = new FlxText(0, 0, 100, "DISCONNECT");
			btn_disconnect_up.color = 0x2a6e04;
			btn_disconnect_down.color = 0x41ab07;
			btn_disconnect.loadGraphic(btn_disconnect_up, btn_disconnect_down);
			
			var btn_reAssemble:FlxButton = new FlxButton(20, 20+10, onReAssembleClick);
			btn_reAssemble.scrollFactor = new FlxPoint(0, 0);
			var btn_reAssemble_up:FlxText = new FlxText(0, 0, 100, "REASSEMBLE");
			var btn_reAssemble_down:FlxText = new FlxText(0, 0, 100, "REASSEMBLE");
			btn_reAssemble_up.color = 0x2a6e04;
			btn_reAssemble_down.color = 0x41ab07;
			btn_reAssemble.loadGraphic(btn_reAssemble_up, btn_reAssemble_down);
			
			
			diagnosticModeGroup.add(btn_disconnect);
			diagnosticModeGroup.add(btn_reAssemble);
			
			
			//connection status progressbar
			var pb_w:Number = 200;
			var pb_h:Number = 10;
			connectionStatusProgressBar= new ProgressBar(new Rectangle(FlxG.width / 2 - pb_w / 2, FlxG.height - pb_h - 5, pb_w, pb_h),"CONNECTING");
			add(connectionStatusProgressBar);
			connectionStatusProgressBar.visible = false;
			//
			
		}
		
		private function onReAssembleClick():void
		{
			
			if (!_connectEDTo) {
				FlxG.log("REASSEMBLE FAILED!");
				return;
			}
			ISpaceObject(_connectEDTo).setStatus(ActorStatuses.DRONE_ROUTINE);
			setFlightMode();
			
			FlxG.log("REASSEMBLE SUCCEED!");
		}
		
		private function onDisconnectClick():void
		{
			//trace("disconnect");
			setFlightMode();
		}
		
		public function addToTracker(flxObj:FlxSprite):void {
			if (!naviCom) {
				_naviCom = new NaviCom(ILevel(FlxG.state).getTractor());
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
			checkClicksForConnection();
		}
		
		public function removeFromTracker(flxObj:FlxObject):void
		{
			trace("remove");
			naviCom.removeFromTracker(flxObj);
		}
		
		private function checkClicksForConnection():void 
		{
			if (FlxG.mouse.justPressed() && !connectingTo) {
				if (naviCom) {
					
					for (var i:int = 0; i <naviCom.trackList.length ; i++) 
					{
						if (!naviCom.trackList[i]) continue;
						
						if (FlxG.mouse.cursor.overlaps(naviCom.trackList[i])) {
							beginConnectionTo(naviCom.trackList[i]);
							break;
						}
					}
				}
				
				
			}else if (FlxG.mouse.justReleased()) {
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
		}
		
		
		private function checkConnectionStatus():void
		{
			if (connectEDTo) {
				trace("already connected");
				
				crossHairGreen.x = connectEDTo.x;
				crossHairGreen.y = connectEDTo.y;
				
				return; // if tractor is connected to any drone, cannot connect anything else at this time
			}
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////.
			
			
			
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
			_connectEDTo = null
			ILevel(FlxG.state).unmuteTractor();
			ILevel(FlxG.state).changeFocusTo(ILevel(FlxG.state).getTractor());
		}
		
		private function connectionEstablished():void
		{
			_connectEDTo = connectingTo;
			trace("connectEDTo " + connectEDTo);
			connectingTo = null
			ILevel(FlxG.state).muteTractor();
			
			setDiagnosticMode();
		}
		
		private function setDiagnosticMode():void
		{
			FlxState.bgColor = 0xFF1d2613;
			
			add(diagnosticModeGroup);
			//crossHairGreen.flicker(2);
			ILevel(FlxG.state).changeFocusTo(connectEDTo);
		}
		
		private function setFlightMode():void
		{
			FlxState.bgColor = 0xFF000000;
			remove(diagnosticModeGroup);
			connectionBroken();
		}
		
		private function beginConnectionTo(item:FlxObject):void
		{
			if (connectEDTo) {
				trace("already connected");
				return; // if tractor is connected to any drone, cannot connect anything else at this time
			}
			
			connectingTo = item;
			connectionTimer = 0;
			connecting = true;
			ILevel(FlxG.state).muteTractor();
		}
		
		public function get naviCom():NaviCom { return _naviCom; }
		
		public function get connectEDTo():FlxObject { return _connectEDTo; }
		
		
	}
}