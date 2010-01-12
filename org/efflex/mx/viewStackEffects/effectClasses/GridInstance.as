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
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.Grid;
	
	public class GridInstance extends ViewStackTweenEffectInstance
	{
		
		public var baseDistanceOn				: String;
		public var baseDurationOnDistance		: Boolean;
		public var numColumns 					: uint;
		
		public function GridInstance( target:UIComponent )
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
			
			var toX:Number = -( contentWidth * column );
			var toY:Number =  -( contentHeight * row );
				
			if( !wasInterrupted )
			{
				display.y = -contentHeight * Math.floor( selectedIndexFrom / numColumns );
				display.x = -contentWidth * ( selectedIndexFrom % numColumns );
			}
			
			createGrid();
			
			var distance:Number = Math.abs( Point.distance( new Point( display.x, display.y ), new Point( toX, toY ) ) )
			var targetDuration:Number;
			if( baseDurationOnDistance )
			{
				switch( baseDistanceOn )
				{
					case Grid.BASE_DISTANCE_ON_WIDTH :
					{
						targetDuration =  duration * ( distance / contentWidth );
						break;
					}
					case Grid.BASE_DISTANCE_ON_HEIGHT :
					{
						targetDuration =  duration * ( distance / contentHeight );
						break;
					}
					default :
					{
						// Error here
					}
				}
			}
			else
			{
				targetDuration = duration;
			}
			
			tween = createTween( this, new Array( display.x, display.y ), new Array( toX, toY ), targetDuration );
        }
		
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			display.x = Number( value[ 0 ] );
			display.y = Number( value[ 1 ] );
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