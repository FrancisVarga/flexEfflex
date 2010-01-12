package org.efflex.mx.core
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	
	import org.efflex.interfaces.ICore;
	import org.efflex.utils.TweenUtil;

	public class TileCore implements ICore
	{
		
		public static const RANDOM						: String = "random";
		public static const TOP_RIGHT_TO_BOTTOM_LEFT	: String = "topRightToBottomLeft";
		public static const TOP_LEFT_TO_BOTTOM_RIGHT	: String = "topLeftToBottomRight";
		public static const BOTTOM_RIGHT_TO_TOP_LEFT	: String = "bottomRightToTopLeft";
		public static const BOTTOM_LEFT_TO_TOP_RIGHT	: String = "bottomLeftToTopRight";
		
		private var _tileDuration		: Number;
		private var _tileTweenDuration	: Number;
		private var _tileStartValues	: Array;
		
		private var _tweenValue			: Number;
		
//		private var _tileWidth			: Number;
//		private var _tileHeight			: Number;
		private var _numRows			: uint;
		private var _numColumns			: uint;
//		private var _transparent		: Boolean;
		
		public function TileCore(numRows:uint, numColumns:uint, order:String, tileDurationPercent:Number, duration:Number )
		{
			initialize( numRows, numColumns, order, tileDurationPercent, duration );
		}
		
		public function get tileDuration():Number
		{
			return _tileDuration;
		}
		
		public function get tileTweenDuration():Number
		{
			return _tileTweenDuration;
		}
		
		public function get tileStartValues():Array
		{
			return _tileStartValues;
		}
		
		public function update( value:Number ):void
		{
			_tweenValue = value;
		}
		
		public function getTileValueAt( row:uint, column:uint ):Number
		{
			var value:Number = Number( tileStartValues[ row ][ column ] );
			return TweenUtil.normalizeValue( value, value + tileTweenDuration, _tweenValue, 0, 1 )
		}
		
		private function initialize( numRows:uint, numColumns:uint, order:String, tileDurationPercent:Number, duration:Number ):void
		{
			_numRows = numRows;
			_numColumns = numColumns;
			_tileDuration = getTileDuration( tileDurationPercent, duration );
			_tileTweenDuration = _tileDuration / duration;
			_tileStartValues = getTileStartValues( order, duration );
		}
		
		private function getTileDuration( tileDurationPercent:Number, duration:Number ):Number
		{
			var tp:Number = tileDurationPercent / 100;
			
			if( tp < 0 )
			{
				tp = 0.01;
			}
			else if( tp > 1 )
			{
				tp = 1;
			}
			
			return duration * tp;
		}
		
		private function getTileStartValues( order:String, duration:Number ):Array
		{
			var r:uint = 0;
			var c:uint = 0;
			var row:Array;
			var i:int = 0;
			
			var toDivide:Number = duration - _tileDuration;
			var tileTweenDelta:Number = ( toDivide / ( ( _numRows * _numColumns ) - 1 ) ) / duration;
			
			var tileStartValues:Array = new Array();
			
			switch( order )
			{
				case TileCore.RANDOM :
				{
					var random:Array = new Array();
					for( r = 0; r < _numRows; r++ )
					{
						for( c = 0; c < _numColumns; c++ )
						{
							random.push( new RowColumn( r, c ) );
						}
						tileStartValues.push( new Array( _numColumns ) );
					}
					
					var randomIndex:Number;
					var rowColumn:RowColumn;
					for( r = 0; r < _numRows; r++ )
					{
						for( c = 0; c < _numColumns; c++ )
						{
							randomIndex = Math.floor( Math.random() * random.length );
							if( randomIndex == random.length ) randomIndex--;
							rowColumn = RowColumn( random.splice( randomIndex, 1 )[ 0 ] );
							tileStartValues[ rowColumn.row ][ rowColumn.column ] = tileTweenDelta * i;
							i++;
						}
					}
					break;
				}
				case TileCore.BOTTOM_LEFT_TO_TOP_RIGHT :
				{
					for( r = 0; r < _numRows; r++ )
					{
						row = new Array();
						for( c = 0; c < _numColumns; c++ )
						{
							row.push( tileTweenDelta * i );
							i++;
						}
						tileStartValues.unshift( row );
					}
					break;
				}
				case TileCore.BOTTOM_RIGHT_TO_TOP_LEFT :
				{
					for( r = 0; r < _numRows; r++ )
					{
						row = new Array();
						for( c = 0; c < _numColumns; c++ )
						{
							row.unshift( tileTweenDelta * i );
							i++;
						}
						tileStartValues.unshift( row );
						
					}
					break;
				}
				case TileCore.TOP_LEFT_TO_BOTTOM_RIGHT :
				{
					for( r = 0; r < _numRows; r++ )
					{
						row = new Array();
						for( c = 0; c < _numColumns; c++ )
						{
							row.push( tileTweenDelta * i );
							i++;
						}
						tileStartValues.push( row );
						
					}
					break;
				}
				case TileCore.TOP_RIGHT_TO_BOTTOM_LEFT :
				{
					for( r = 0; r < _numRows; r++ )
					{
						row = new Array();
						for( c = 0; c < _numColumns; c++ )
						{
							row.unshift( tileTweenDelta * i );
							i++;
						}
						tileStartValues.push( row );
						
					}
					break;
				}
			}
			
			return tileStartValues;
		}
	}
}

internal class RowColumn
{
	
	private var _row	: Number;
	private var _column	: Number;
	
	public function RowColumn( row:Number, column:Number )
	{
		_row = row;
		_column = column;
	}
	
	public function get row():Number
	{
		return _row;
	}
	
	public function get column():Number
	{
		return _column;	
	}
}