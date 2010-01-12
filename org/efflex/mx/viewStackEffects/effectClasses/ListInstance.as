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
	
	import org.efflex.mx.viewStackEffects.List;

	
	public class ListInstance extends ViewStackTweenEffectInstance
	{
		
		public var scaleDurationByChange		: Boolean;
		public var direction 					: String;
		
		
		public function ListInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function setIndicesRequired():void
	    {
	    	var lowestIndex:int = Math.min( selectedIndexFrom, selectedIndexTo );
	    	var highestIndex:int = Math.max( selectedIndexFrom, selectedIndexTo );
	    	
	    	var indices:Array = new Array();
	    	for( var i:int = lowestIndex; i <= highestIndex; i++ )
	    	{
	    		addRequiredIndex( i );
	    	}
	    }
	    
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
			var toX:Number;
        	var toY:Number;
        	var distance:Number;
        	var change:Number;
        	
			switch( direction )
			{
				case List.HORIZONTAL :
				{
					if( !wasInterrupted ) display.x = -( selectedIndexFrom * contentWidth );
					
					toX = -( contentWidth * selectedIndexTo );
					toY = display.y;
					
					change = contentWidth;
					distance = Math.abs( display.x - toX );
					
					break;
				}
				case List.VERTICAL :
				{
					if( !wasInterrupted ) display.y = -( selectedIndexFrom * contentHeight );
					
					toX = display.x
					toY = -( contentHeight * selectedIndexTo );
					
					change = contentHeight
					distance = Math.abs( display.y - toY );
					
					break;
				}
			}
			
			createList();
			
			var targetDuration:Number = ( scaleDurationByChange ) ? duration * ( distance / change ) : duration;
			tween = createTween( this, new Array( display.x, display.y ), new Array( toX, toY ), targetDuration );
        }
        
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			display.x = Number( value[ 0 ] );
			display.y = Number( value[ 1 ] );
		}
		
		private function createList():void
		{
			var child:Bitmap;
			var numChildren:uint = viewStack.numChildren;
			var bitmapData:BitmapData;
			for( var i:uint = 0; i < numChildren; i++ )
			{
				bitmapData = bitmapDatum[ i ] as BitmapData
				if( bitmapData )
				{
					child = new Bitmap( bitmapData );
					if( direction == List.HORIZONTAL ) child.x = contentWidth * i;
					if( direction == List.VERTICAL ) child.y = contentHeight * i;
					display.addChild( child );
				}
			}
		}
		
	}
}