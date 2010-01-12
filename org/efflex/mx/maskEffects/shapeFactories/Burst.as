package org.efflex.mx.maskEffects.shapeFactories
{
	import flash.display.Shape;
	import flash.geom.Point;
	
	import mx.core.IFactory;
	
	public class Burst implements IFactory
	{
		public var x			: Number = 0;
		public var y			: Number = 0;
		public var numBursts	: Number = 5;
		public var radius		: Number = 20;
		public var rotation		: Number = 0;
		public var burstSize	: Number = 5;
		
		public function Burst()
		{
			super();
		}
		
		public function newInstance():*
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( 0x000000, 1 );
			
			var innerRadius:Number = radius - ( burstSize * 2 );
			var step:Number = ( Math.PI * 2 ) / numBursts;
			var halfStep:Number = step / 2;
			var qtrStep:Number = step / 4;
			var start:Number = ( rotation / 180 )* Math.PI;
			shape.graphics.moveTo( x + ( Math.cos( start ) * radius ), y - ( Math.sin( start ) * radius ) );
			
			for( var i:int = 1;  i <=numBursts;  i++)
			{
				shape.graphics.curveTo( x + Math.cos( start  + ( step * i ) - ( qtrStep * 3 ) ) * ( innerRadius / Math.cos( qtrStep ) ),
										y - Math.sin( start  + ( step * i ) - ( qtrStep * 3 ) ) * ( innerRadius / Math.cos( qtrStep ) ),
										x + Math.cos( start  + ( step * i ) - halfStep ) * innerRadius,
										y - Math.sin( start  + ( step * i ) - halfStep ) * innerRadius );
										
				shape.graphics.curveTo( x + Math.cos( start  + ( step * i ) - qtrStep )* ( innerRadius / Math.cos( qtrStep ) ),
										y - Math.sin( start  + ( step * i ) - qtrStep )* ( innerRadius / Math.cos( qtrStep ) ),
										x + Math.cos( start  + ( step * i ) ) * radius,
										y - Math.sin( start  + ( step * i ) ) * radius );
			}
			
			shape.graphics.endFill();
			
			return shape;
		}
		

		
	}
}