package actors
{
	import effects.EmitterProps;
	import effects.IEngine;
	import org.flixel.FlxPoint;
	
	import levels.ILevel;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	public class Tractor extends FlxSprite
	{
		//[Embed(source = "../../gfx/tractorShip.png")] private var gfx_tractorShip:Class;
		[Embed(source = "../../gfx/tractorShip-repaint.png")] private var gfx_tractorShip:Class;
		
		private var speed:Number = 0;
		private var maxSpeed:Number = 90;
		private var speed_incr:Number = 1.5;
		private var minSpeed:Number = 0;
		
		public var thruster:IEngine = null;
		public var canMove:Boolean = true;
		
		public function Tractor(x:Number=0, y:Number=0)
		{
			super()
			//offset = new FlxPoint(-5, 5);
			loadGraphic(gfx_tractorShip, false, true, 13, 15);
			//createGraphic(3, 3);
			//offset = new FlxPoint(-1, -1);
			//width = 13;
			width = 13;
			//width = 15;
			height = 15;
			offset.x = 0;
			offset.y = 0;
		}
		
		override public function update():void{
			
			if (!canMove) {
				speed-=(speed_incr*4);
				if (thruster) thruster.cutThrusters();
				return;
			}
			
			
			//variate speed
			if(FlxG.mouse.pressed()){
				speed+=speed_incr;
				
				//ILevel(FlxG.state).emitParticlesFrom("TRACTOR_THRUSTER",emitProps,false);
				
				if(thruster)thruster.burst();
				
			}else{
				speed-=(speed_incr*2);
				
				if(thruster)thruster.cutThrusters();
				//ILevel(FlxG.state).emitParticlesFrom("TRACTOR_THRUSTER",null,true);
			}
			
			speed = speed>maxSpeed ? maxSpeed : speed;
			speed = speed<minSpeed ? minSpeed : speed;
			
			if(speed>minSpeed){
				
				
				if(velocity.x <= 0){
					facing = RIGHT;
				}else{
					facing = LEFT;
				}
				
				/*
				if(FlxG.mouse.screenX < this.x){
					facing = RIGHT;
				}else{
					facing = LEFT;
				}
				*/
			}
			
			//go
			var aim_rads:Number = (aimAngle() * (Math.PI / 180)); //convert the fire angle from degrees into radians and apply that value to the radian fire angle variable
			this.velocity.x = Math.cos(aim_rads) * speed; //calculate a velocity along the x axis, multiply the result by our diagonalVelocity (just 100 here).
			this.velocity.y = Math.sin(aim_rads) * speed; //calculate a velocity along the y axis, ditto.
			
			//speed++;
			super.update();
		}
		
		
		public function aimAngle():Number
		{
			return FlxU.getAngle((FlxG.mouse.x - (x + (width/2))), (FlxG.mouse.y - (y + (height/2))));
		}
	}
}