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
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import mx.core.UIComponent;
	
	
	public class PixelateInstance extends ViewStackTweenEffectInstance
	{
		
		private var _pixelBitmapData		: BitmapData;
		
		private var _bitmapDisplay		: Bitmap;
		
		private var _pixelMatrix		: Matrix;
		private var _bitmapMatrix		: Matrix;
		private var _bitmapDataDisplay	: BitmapData;
		
		private var _numPixelsHorizontal		: uint = 8;
		private var _numPixelsVertical		: uint = 4;
		
		private var _hPixelChange			: uint;
		private var _vPixelChange			: uint;
		
		public function PixelateInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
        	_pixelMatrix = new Matrix();
        	_bitmapMatrix = new Matrix();
			_bitmapDataDisplay = new BitmapData( contentWidth, contentHeight, transparent, 0x000000 );
			_bitmapDataDisplay.draw( snapShot );
			 
			_pixelBitmapData = new BitmapData( contentWidth, contentHeight, transparent, 0x000000 );
			
			_bitmapDisplay = new Bitmap( _bitmapDataDisplay );

			display.addChild( _bitmapDisplay );
			
			_hPixelChange = contentWidth - _numPixelsHorizontal;
			_vPixelChange = contentHeight - _numPixelsVertical;
			
			tween = createTween( this, 0, 1, duration );
        }
		
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var v:Number = Number( value );
			
			var normalize:Number = ( v <= 0.5 ) ? Math.abs( ( v * 2 ) - 1 ) : ( v - 0.5 ) * 2;
			
			var hPixels:uint = _numPixelsHorizontal + ( _hPixelChange * normalize );
			var vPixels:uint = _numPixelsVertical + ( _vPixelChange * normalize );
			
			_pixelBitmapData.fillRect( _pixelBitmapData.rect, 0x000000 );
			
			_pixelMatrix.identity();
			_pixelMatrix.scale( hPixels / contentWidth, vPixels / contentHeight );
			
			_pixelBitmapData.fillRect( _pixelBitmapData.rect, 0x000000 );
			
			_bitmapMatrix.identity();
			_bitmapMatrix.scale( 1 / _pixelMatrix.a, 1 / _pixelMatrix.d );
			
			_pixelBitmapData.draw( snapShot, _pixelMatrix );
			_bitmapDataDisplay.draw( _pixelBitmapData, _bitmapMatrix );
			
			_pixelBitmapData.draw( BitmapData( bitmapDatum[ selectedIndexTo ] ), _pixelMatrix );
			_bitmapDataDisplay.draw( _pixelBitmapData, _bitmapMatrix, new ColorTransform( 1, 1, 1, v, 0, 0, 0, 0 ) );
		}
		
		
		
	}
}