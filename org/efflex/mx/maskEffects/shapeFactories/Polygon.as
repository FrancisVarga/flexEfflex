package org.efflex.mx.maskEffects.shapeFactories
{
	import flash.display.Shape;
	
	import mx.core.IFactory;

	public class Polygon implements IFactory
	{
		public var x			: Number = 0;
		public var y			: Number = 0;
		public var numSides		: uint = 6;
		public var radius		: Number = 20;
		public var rotation		: Number = 0;
		
		public function Polygon()
		{
			super();
		}
		
		public function newInstance():*
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( 0x000000, 1 );
			
			var step:Number = ( Math.PI * 2 ) / numSides;
			var start:Number = ( rotation / 180 ) * Math.PI;
			shape.graphics..moveTo( x + ( Math.cos( start ) * radius ), y - ( Math.sin( start ) * radius ) );
			
			for (var i:int = 1; i <= numSides; i++ )
			{
				shape.graphics..lineTo( x + Math.cos( start + ( step * i ) ) * radius, y - Math.sin( start + ( step * i ) ) * radius );
			}
			
			return shape;
		}
		

		
	}
}