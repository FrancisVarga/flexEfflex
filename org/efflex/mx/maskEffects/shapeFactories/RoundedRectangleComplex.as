package org.efflex.mx.maskEffects.shapeFactories
{
	import flash.display.Shape;
	
	import mx.core.IFactory;
	
	public class Rectangle implements IFactory
	{
		public var x					: Number = 0;
		public var y					: Number = 0;
		public var width				: Number = 20;
		public var height				: Number = 20;
		public var topLeftRadius		: Number = 2;
		public var topRightRadius		: Number = 2;
		public var bottomLeftRadius		: Number = 2;
		public var bottomRightRadius	: Number = 2;
		
		public function Rectangle()
		{
			super();
		}
		
		public function newInstance():*
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( 0x000000, 1 );
			shape.graphics.drawRoundRectComplex( x, y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius );
			shape.graphics.endFill();
			return shape;
		}

		
	}
}