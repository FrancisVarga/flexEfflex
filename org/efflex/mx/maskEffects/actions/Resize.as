package org.efflex.mx.maskEffects.actions
{
	import flash.display.DisplayObject;

	public class Resize implements IMaskAction
	{
		
		public var scaleFrom		: Number = 0;
		public var scaleTo			: Number = 1;
		public var scaleChange		: Number;
		
		public function Resize()
		{
		}
		
		public function register( mask:DisplayObject ):void
		{
			
		}
		
		public function update( mask:DisplayObject, value:Number ):void
		{
			if( isNaN( scaleChange ) ) scaleChange = scaleTo - scaleFrom;
			mask.scaleX = mask.scaleY = scaleFrom + ( scaleChange * value );
		}
	}
}