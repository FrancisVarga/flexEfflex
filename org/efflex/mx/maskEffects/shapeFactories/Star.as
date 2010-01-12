package org.efflex.mx.maskEffects.shapeFactories
{
	import flash.display.Shape;
	import flash.geom.Point;
	
	import mx.core.IFactory;
	
	public class Star implements IFactory
	{
		public var x			: Number = 0;
		public var y			: Number = 0;
		public var numPoints	: Number = 5;
		public var radius		: Number = 20;
		public var rotation		: Number = 0;
		public var pointSize	: Number = 5;
		
		public function Star()
		{
			super();
		}
		
		public function newInstance():*
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( 0x000000, 1 );
			
			var innerRadius:Number = radius - ( pointSize * 2 );
			var step:Number = ( Math.PI * 2 ) / numPoints;
			var halfStep:Number = step / 2;
			var start:Number = ( rotation / 180 ) * Math.PI;
			shape.graphics..moveTo( x + ( Math.cos( start ) * radius ), y - ( Math.sin( start ) * radius ) );
			for( var i:int = 1; i <= numPoints; i++ )
			{
				shape.graphics.lineTo( x + Math.cos( start + ( step * i ) - halfStep ) * innerRadius, y - Math.sin( start + ( step * i ) - halfStep ) * innerRadius );
				shape.graphics.lineTo( x + Math.cos( start + ( step * i ) ) * radius, y - Math.sin( start + ( step * i ) ) * radius );
			}
			
			shape.graphics.endFill();
			
			return shape;
		}
		

		
	}
}