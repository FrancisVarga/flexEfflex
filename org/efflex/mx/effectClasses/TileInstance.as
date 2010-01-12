/*
Copyright (c) 2008 Tink Ltd - http://www.tink.ws

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions
of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO 
THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package org.efflex.mx.effectClasses
{
	import flash.display.BitmapData;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.core.TileCore;
	import org.efflex.utils.TileUtil;

	public class TileInstance extends BitmapInstance
	{
		
		public var numRows					: int;
		public var numColumns				: int;
		public var tileDurationPercent		: Number;
		public var order					: String;
		
		private var _tileWidth				: Number;
		private var _tileHeight				: Number;
		
		private var _bitmapDataTiles		: Array;
		private var _tileCore				: TileCore;
		
		
		public function TileInstance( target:UIComponent )
		{
			super( target );
		}
		
		public function get tileWidth():Number
		{    	
			return _tileWidth;
		}
		
		public function get tileHeight():Number
		{    	
			return _tileHeight;
		}
		
		public function getBitmapDataTile( row:uint, column:uint ):BitmapData
		{
			return BitmapData( _bitmapDataTiles[ row ][ column ] );
		}
		
		public function getTileValueAt( row:uint, column:uint ):Number
		{
			return _tileCore.getTileValueAt( row, column );
		}
		
		override public function play():void
        {
			createTileEffect();
			
			super.play();
			
			tween = createTween( this, 0, 1, duration );
        }
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_tileCore.update( Number( value ) );
		}
		
		protected function createTileEffect():void
		{
			var t:UIComponent = UIComponent( target );
			
			_tileWidth = t.width / numColumns;
			_tileHeight = t.height / numRows;
			
			_tileCore = new TileCore( numRows, numColumns, order, tileDurationPercent, duration );
			_bitmapDataTiles = TileUtil.createBitmapDataTiles( t, numRows, numColumns, _tileWidth, _tileHeight, transparent );
		}
	}
}


