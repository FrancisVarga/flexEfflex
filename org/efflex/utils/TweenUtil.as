package org.efflex.utils
{
	public class TweenUtil
	{
		public function TweenUtil()
		{
		}

		public static function normalizeValue( start:Number, end:Number, value:Number, min:Number = 0, max:Number = 1 ):Number
		{
			if( value < start ) return min;
			if( value > end ) return max;
			
			var zeroed:Number = value - start;
			var diff:Number = end - start;
			
			return min + ( ( max - min ) * ( zeroed / diff ) );;
		}
		
	}
}