package org.efflex.mx.maskEffects.shapeFactories
{
	import flash.display.Shape;
	
	import mx.core.IFactory;
	
	public class Rectangle implements IFactory
	{
		public var x			: Number = 0;
		public var y			: Number = 0;
		public var width		: Number = 20;
		public var height		: Number = 20;
		public var elipseWidth	: Number = 2;
		public var elipseHeight	: Number = 2;
		
		public function Rectangle()
		{
			super();
		}
		
		public function newInstance():*
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( 0x000000, 1 );
			shape.graphics.drawRoundRect( x, y, width, height, elipseWidth, elipseHeight );
			shape.graphics.endFill();
			return shape;
		}

		
	}
}