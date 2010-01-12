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
	
	
	public class GridZoomInstance extends ViewStackTweenEffectInstance
	{

		public var numColumns 			: uint;
		
		private var _fromX			: Number;
		private var _fromY			: Number;	
		
		private var _toX			: Number;
		private var _toY			: Number;
		
		private var _startScale		: Number;		
		
		public function GridZoomInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function setIndicesRequired():void
		{
			addRequiredIndex( -1 );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
			var row:int = Math.floor( selectedIndexTo / numColumns );
			var column:int = selectedIndexTo % numColumns;
			
			_startScale = display.scaleX;
        	
			if( !wasInterrupted )
			{
				display.y = -contentHeight * Math.floor( selectedIndexFrom / numColumns );
				display.x = -contentWidth * ( selectedIndexFrom % numColumns );
			}
			_toX = ( contentWidth * column );
			_toY = ( contentHeight * row );
			
			_fromX = display.x;
			_fromY = display.y;
	
			createGrid();
			
			tween = createTween( this, 0, 1, duration );
        }

		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var totalPercent:Number = Number( value );
			var transitionPercent:Number;
			var extraSize:Number;
			
			if( totalPercent < 0.5 )
			{
				transitionPercent = totalPercent * 2;
				display.x = _fromX - ( _fromX * transitionPercent );
				display.y = _fromY - ( _fromY * transitionPercent );
			}
			else
			{
				transitionPercent = Math.abs( 0.5 - totalPercent ) * 2;
				display.x = -_toX * transitionPercent;
				display.y = -_toY * transitionPercent;
			}

			var numRows:int = Math.ceil( display.numChildren / numColumns );
			if( numRows > numColumns )
			{
				if( totalPercent < 0.5 )
				{
					extraSize = ( ( contentHeight * _startScale )  * numRows ) - contentHeight;
					display.height = contentHeight + ( extraSize * Math.abs( transitionPercent - 1 ) );
					display.scaleX = display.scaleY;
				}
				else
				{
					extraSize = contentHeight * ( numRows - 1 );
					display.height = ( contentHeight + ( extraSize * transitionPercent ) );
					display.scaleX = display.scaleY;
				}
			}
			else
			{
				if( totalPercent < 0.5 )
				{
					extraSize = ( ( contentWidth * _startScale ) * numColumns ) - contentWidth;
					display.width = contentWidth + ( extraSize * Math.abs( transitionPercent - 1 ) );
					display.scaleY = display.scaleX;
				}
				else
				{
					extraSize = contentWidth * ( numColumns - 1 );
					display.width = ( contentWidth + ( extraSize * transitionPercent ) );
					display.scaleY = display.scaleX;
				}
			}
		}


		private function createGrid():void
		{
			var child:Bitmap;
			var numChildren:uint = viewStack.numChildren;
			var row:uint = 0;
			var column:uint = 0;
			var i:uint;
			
			for( i = 0; i < numChildren; i++ )
			{
				child = new Bitmap();
				child.bitmapData = BitmapData( bitmapDatum[ i ] );
				child.x = contentWidth * column;
				child.y = contentHeight * row;
				display.addChild( child );
				
				if( column == numColumns - 1 )
				{
					column = 0;
					row++;
				}
				else
				{
					column++;
				}
			}
		}
		
		
	}
}