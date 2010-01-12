package org.efflex.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	
	import mx.core.IFactory;

	public class TileUtil
	{
		public function TileUtil()
		{
		}
		
		public static function createBitmapDataTiles( target:IBitmapDrawable, numRows:uint, numColumns:uint, tileWidth:int, tileHeight:Number, transparent:Boolean, backgroundColor:Number = 0xFF0000 ):Array
		{
			var bc:Number = ( transparent ) ? 0x00000000 : backgroundColor;
			
			var rows:Array = new Array();
			var columns:Array;
			var bitmapData:BitmapData;
			var matrix:Matrix = new Matrix();
			for( var r:int = 0; r < numRows; r++ )
			{
				columns = new Array();
				for( var c:int = 0; c < numColumns; c++ )
				{
					matrix.identity();
					
					matrix.translate( -( tileWidth * c ), -( tileHeight * r ) )
					bitmapData = new BitmapData( tileWidth, tileHeight, transparent, bc );
					bitmapData.draw( target, matrix );
					
					columns.push( bitmapData );
				}
				rows.push( columns );
			}
			
			return rows;
		}
		
		public static function createShapeTiles( factory:IFactory, numRows:uint, numColumns:uint, horizontalSpacing:Number, verticalSpacing:Number ):Array
		{
			var displayObject:DisplayObject
			var rows:Array = new Array();
			var columns:Array;
			for( var r:int = 0; r < numRows; r++ )
			{
				columns = new Array();
				for( var c:int = 0; c < numColumns; c++ )
				{
					displayObject = DisplayObject( factory.newInstance() );
					displayObject.x = horizontalSpacing * c;
					displayObject.y = verticalSpacing * r;
					columns.push( displayObject );
				}
				rows.push( columns );
			}
			
			return rows;
		}
	}
}