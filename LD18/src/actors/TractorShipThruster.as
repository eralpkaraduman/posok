package actors
{
	import effects.IEngine;
	
	import levels.ILevel;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.data.FlxPanel;
	
	public class TractorShipThruster extends FlxSprite implements IEngine
	{
		[Embed(source = "gfx/tractorShipThrusterRotatedSprites.png")] private var gfx_tractorShipThruster:Class;
		[Embed(source = "gfx/thrusterBurst.png")] private var em_thrusterBurst:Class;
		
		
		private var rotationQuarters:Vector.<Number> = new Vector.<Number>(10,true);
		
		private var thrusters:FlxEmitter;
		
		public function TractorShipThruster(x:Number=0, y:Number=0)
		{
			super(x, y);
			
			rotationQuarters[0] = 22.5;
			rotationQuarters[1] = 57.5;
			rotationQuarters[2] = 112.5;
			rotationQuarters[3] = 157.5;
			
			rotationQuarters[4] = 202.5; // impossible interval
			rotationQuarters[5] = -202.5;
			
			rotationQuarters[6] = -157.5;
			rotationQuarters[7] = -112.5;
			rotationQuarters[8] = -67.5;
			rotationQuarters[9] = -22.5;
			
			loadGraphic(gfx_tractorShipThruster,true,true,13,13);
			
			
			addAnimation("q1",[4],0,false);
			addAnimation("q2",[5],0,false);
			addAnimation("q3",[6],0,false);
			addAnimation("q4",[7],0,false);
			
			addAnimation("q5",[7],0,false); // impossible interval
			addAnimation("q6",[0],0,false);
			
			addAnimation("q7",[0],0,false);
			addAnimation("q8",[1],0,false);
			addAnimation("q9",[2],0,false);
			addAnimation("q10",[3],0,false);
			
			//emitters
			thrusters = FlxG.state.add(new FlxEmitter(0,0)) as FlxEmitter;
			thrusters.gravity = 0;
			thrusters.createSprites(em_thrusterBurst,50,4,true);
			thrusters.delay = 0.01;
			thrusters.height = 4;
			thrusters.width = 4;
			//thrusters.kill();
			
			
		}
		
		override public function update():void{
			snapToTractor();
			super.update();
		}
		
		public function snapToTractor():void{
			var trac:TractorProps = ILevel(FlxG.state).getTractorProps();
			var f:uint = trac.facing;
			var f_left:Boolean = (f==LEFT);
			
			var adjustx:Number = 2;
			this.x = f? trac.x +adjustx: trac.x-adjustx;
			//this.angle = trac.aimAngle;
			this.y = trac.y - 3;
			
			
			
			var sx:Number = ILevel(FlxG.state).getTractor().velocity.x;
			var sy:Number = ILevel(FlxG.state).getTractor().velocity.y;
			
			sx*=.15;
			sy*=.15;
			
			thrusters.setXSpeed(-sx,-sx);
			thrusters.setYSpeed(-sy,-sy);
			
			var q:String = pickQuarter(trac.aimAngle);
			play(q,true);
			pickEmitterPos(q);
			
		}
		
		// emit particles
		public function burst():void{
			thrusters.start(false,0.01,150);
		}
		
		public function cutThrusters():void{
			thrusters.stop(0);
		}
		
		//utils
		private function pickQuarter(ang:Number):String{
			for(var i:Number = 0 ; i<rotationQuarters.length ; i++){
				var prev:int = (i-1 < 0) ? rotationQuarters.length-1 : i-1;
				
				if(rotationQuarters[prev]<ang && ang<rotationQuarters[i]){
					var s:String = "q"+(i+1);
					//FlxG.log("found"+s);
					return s; 
				}
			}
			FlxG.log("outscope");
			return "outscope";
		}
		
		private function pickEmitterPos(q:String):void{
			var m:FlxPoint = new FlxPoint(0,4)
			var p:FlxPoint = new FlxPoint(0,0);
			var u:Number = 4;
			var u_2:Number = u*2;
			
			switch(q){
				case "q1"  : p.x=0; 	p.y=0; 	break;
				case "q2"  : p.x=0; 	p.y=-u; break;
				case "q3"  : p.x=u; 	p.y=-u; break;
				case "q4"  : p.x=u_2; 	p.y=-u; break;
				
				case "q5"  : p.x=u_2; 	p.y=-u; break;
				case "q6"  : p.x=u_2; 	p.y=0; break;
				
				case "q7"  : p.x=u_2; 	p.y=0; break;
				case "q8"  : p.x=u_2; 	p.y=u; break;
				case "q9"  : p.x=u; 	p.y=u; break;
				case "q10"  : p.x=0; 	p.y=u; break;
			}
			
			thrusters.x = this.x + p.x +m.x;
			thrusters.y = this.y + p.y +m.y; 
		}
	}
}