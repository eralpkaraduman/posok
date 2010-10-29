package actors
{
	public class TractorProps
	{
		public var x:Number;
		public var y:Number;
		public var facing:uint;
		public var aimAngle:Number
		
		public function TractorProps(x:Number,y:Number,facing:uint,aimAngle:Number)
		{
			this.x = x;
			this.y = y;
			this.facing = facing;
			this.aimAngle = aimAngle;
		}
	}
}