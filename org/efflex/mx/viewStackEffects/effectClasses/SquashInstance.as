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

package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.Squash;

	public class SquashInstance extends ViewStackTweenEffectInstance
	{
		
		public var direction 				: String;
		
		private var _bitmapFrom				: Bitmap;
		private var _bitmapTo				: Bitmap;
		
		public function SquashInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
			
			_bitmapFrom = new Bitmap( snapShot );
			display.addChild( _bitmapFrom );
			
			_bitmapTo = new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) );
			display.addChild( _bitmapTo );
			
			var from:Number;
			
			switch( direction )
			{
				case Squash.DOWN :
				{
					from = _bitmapTo.y = -contentHeight;
					break;
				}
				case Squash.UP :
				{
					from = _bitmapTo.y = contentHeight;
					break;
				}
				case Squash.LEFT :
				{
					from = _bitmapTo.x = contentWidth;
					break;
				}
				case Squash.RIGHT :
				{
					from = _bitmapTo.x = -contentWidth;
					break;
				}
			}
			
			tween = createTween( this, from, 0, duration );
		}
		
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var position:Number = Number( value );
			
			switch( direction )
			{
				case Squash.DOWN :
				{
					_bitmapTo.y = position;
					_bitmapFrom.height = ( contentHeight - position ) - contentHeight;
					_bitmapFrom.y = contentHeight - _bitmapFrom.height;
					break;
				}
				case Squash.UP :
				{
					_bitmapTo.y = position;
					_bitmapFrom.height = _bitmapTo.y;
					_bitmapFrom.y = 0;
					break;
				}
				case Squash.LEFT :
				{
					_bitmapTo.x = position;
					_bitmapFrom.width = _bitmapTo.x;
					_bitmapFrom.x = 0;
					break;
				}
				case Squash.RIGHT :
				{
					_bitmapTo.x = position;
					_bitmapFrom.width = ( contentWidth - position ) - contentWidth;
					_bitmapFrom.x = contentWidth - _bitmapFrom.width;
					break;
				}
			}
		}
		
	}
}