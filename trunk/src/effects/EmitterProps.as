package effects
{
	public class EmitterProps
	{
		public var Explode:Boolean;
		public var Delay:Number;
		public var Quantity:uint;
		
		public function EmitterProps(Explode:Boolean=true,Delay:Number=0,Quantity:uint=0)
		{
			this.Explode = Explode;
			this.Delay = Delay;
			this.Quantity = Quantity;
		}
	}
}