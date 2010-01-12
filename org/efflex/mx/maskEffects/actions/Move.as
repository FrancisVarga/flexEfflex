package org.efflex.mx.maskEffects.actions
{
	import flash.display.DisplayObject;

	public class Resize implements IMaskAction
	{
		
		public var xFrom			: Number = 0;
		public var xTo				: Number = 0;
		public var xChange			: Number;
		
		public var yFrom			: Number = 0;
		public var yTo				: Number = 0;
		public var yChange			: Number;
		
		public function Move()
		{
		}
		
		public function register( mask:DisplayObject ):void
		{
			
		}
		
		public function update( mask:DisplayObject, value:Number ):void
		{
			if( isNaN( xChange ) ) xChange = xTo - xFrom;
			if( isNaN( yChange ) ) yChange = yTo - yFrom;
			
			mask.x = xFrom + ( xChange * value );
			mask.y = yFrom + ( yChange * value );
		}
	}
}