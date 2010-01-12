package org.efflex.mx.maskEffects.shapeFactories
{
	import flash.display.Shape;
	
	import mx.core.IFactory;
	
	public class Circle implements IFactory
	{
		public var x	: Number = 0;
		public var y	: Number = 0;
		public var radius	: Number = 20;
		
		public function Circle()
		{
			super();
		}
		
		public function newInstance():*
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( 0x000000, 1 );
			shape.graphics.drawCircle( x, y, radius );
			shape.graphics.endFill();
			
			return shape;
		}

		
	}
}