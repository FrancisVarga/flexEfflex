/*
Copyright (c) 2009 Tink Ltd - http://www.tink.ws

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

package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.core.TileCore;
	import org.efflex.utils.TileUtil;

	public class TileTweenEffectInstance extends ViewStackTweenEffectInstance
	{
		
		protected const SELECTED_INDEX_FROM		: String = "selectedIndexFrom";
		protected const SELECTED_INDEX_TO		: String = "selectedIndexTo";
		protected const INDICES_REQUIRED		: String = "indicesRequired";
		
		public var numRows					: uint;
		public var numColumns				: uint;
		public var tileDurationPercent		: Number;
		public var order					: String;
		
		private var _tileWidth				: Number;
		private var _tileHeight				: Number;

		private var _tileCore				: TileCore;
		private var _bitmapDataTiles					: Array;
		private var _snapShotTiles			: Array;
		
		public function TileTweenEffectInstance( target:UIComponent )
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
		
		public function getSnapShotBitmapDataTile( row:uint, column:uint ):BitmapData
		{
			if( !_snapShotTiles )
			{
				var backgroundColor:Number = viewStack.getStyle( "backgroundColor" );
				if( isNaN( backgroundColor ) ) backgroundColor = 0xFFFFFF;
				_snapShotTiles = TileUtil.createBitmapDataTiles( snapShot, numRows, numColumns, _tileWidth, _tileHeight, transparent, backgroundColor );
			}
			
			return BitmapData( _snapShotTiles[ row ][ column ] );
		}
		
		public function getBitmapDataTileAt( index:int, row:uint, column:uint ):BitmapData
		{
			if( index == -1 ) return getSnapShotBitmapDataTile( row, column );
			
			if( !_bitmapDataTiles[ index ] )
			{
				var backgroundColor:Number = viewStack.getStyle( "backgroundColor" );
				if( isNaN( backgroundColor ) ) backgroundColor = 0xFFFFFF;
				_bitmapDataTiles[ index ] = TileUtil.createBitmapDataTiles( BitmapData( bitmapDatum[ index ] ), numRows, numColumns, _tileWidth, _tileHeight, transparent, backgroundColor );
			}
			
			return BitmapData( _bitmapDataTiles[ index ][ row ][ column ] );
		}
		
		public function getTileValueAt( row:uint, column:uint ):Number
		{
			return _tileCore.getTileValueAt( row, column );
		}
		
		override protected function playViewStackEffect():void
		{
			super.playViewStackEffect();
			
			createTileEffect();
			
			tween = createTween( this, 0, 1, duration );
		}
		
		override public function initEffect( event:Event ):void
	    {
	    	super.initEffect( event );
	    	
			_bitmapDataTiles = data.bitmapDataTiles as Array
		}
		
		override protected function createContainers():void
		{
			super.createContainers();
			
			data.bitmapDataTiles = new Array( viewStack.numChildren );
		}
		
		protected function createTileEffect():void
		{
			_tileWidth = contentWidth / numColumns;
			_tileHeight = contentHeight / numRows;
			
			_tileCore = new TileCore( numRows, numColumns, order, tileDurationPercent, duration );
		}
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_tileCore.update( Number( value ) );
		}
	}
}