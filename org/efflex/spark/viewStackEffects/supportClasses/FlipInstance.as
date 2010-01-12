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

package org.efflex.spark.viewStackEffects.supportClasses
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	import org.efflex.spark.viewStackEffects.Flip;
	
	import spark.effects.SimpleMotionPath;
	
	import ws.tink.utils.MathUtil;

	public class FlipInstance extends ViewStackAnimate3DInstance
	{
		
		public var direction				: String;
		public var scaleDurationByChange	: Boolean;
		
		private var _container			: Sprite;
		private var _bitmap				: Bitmap;
		private var _displayedIndex		: uint;
		private var _zOffset			: Number;
		
		public function FlipInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function setInturruptionParams():void
		{
			super.setInturruptionParams();
			
			data.interruptedDisplayedIndex = _displayedIndex;
			data.interruptedRotationX = _container.rotationX;
			data.interruptedRotationY = _container.rotationY;
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();

			var property:String;
			var valueFrom:Number;
			var valueTo:Number;
			
			_displayedIndex = ( wasInterrupted ) ? data.interruptedDisplayedIndex : selectedIndexFrom;
			
			_bitmap = new Bitmap( getBitmapDataAtIndex( _displayedIndex ) );
			_container = new Sprite();
			_container.addChild( _bitmap );
			display.addChild( _container );
			switch( direction )
			{
				case Flip.VERTICAL :
				case Flip.UP :
				case Flip.DOWN :
				{
					if( wasInterrupted )
					{
						if( data.interruptedRotationX >= 90 )
						{
							_container.rotationX = data.interruptedRotationX - 180;
						}
						else if( data.interruptedRotationX <= -90 )
						{
							_container.rotationX = data.interruptedRotationX + 180;
						}
						else
						{
							_container.rotationX = data.interruptedRotationX;
						}
					}
					
					_bitmap.y = -contentHeight / 2;
					display.y = contentHeight / 2;
					
					property = "rotationX";
					valueFrom = _container.rotationX;
					
					if( selectedIndexTo == _displayedIndex )
					{
						valueTo = 0;
					}
					else if( direction == Flip.VERTICAL )
					{
						valueTo = ( selectedIndexTo < _displayedIndex ) ? -180 : 180;
					}
					else
					{
						valueTo = ( direction == Flip.UP ) ? -180 : 180;
					}
					
					_zOffset = ( viewStack.clipContent ) ? contentHeight / 2 : 0;
					break;
				}
				case Flip.HORIZONTAL :
				case Flip.LEFT :
				case Flip.RIGHT :
				{
					if( wasInterrupted )
					{
						if( data.interruptedRotationY >= 90 )
						{
							_container.rotationY = data.interruptedRotationY - 180;
						}
						else if( data.interruptedRotationY <= -90 )
						{
							_container.rotationY = data.interruptedRotationY + 180;
						}
						else
						{
							_container.rotationY = data.interruptedRotationY;
						}
					}
					
					_bitmap.x = -contentWidth / 2;
					display.x = contentWidth / 2;
					
					property = "rotationY";
					valueFrom = _container.rotationY;
					
					if( selectedIndexTo == _displayedIndex )
					{
						valueTo = 0;
					}
					else if( direction == Flip.HORIZONTAL )
					{
						valueTo = ( selectedIndexTo < _displayedIndex ) ? -180 : 180;
					}
					else
					{
						valueTo = ( direction == Flip.LEFT ) ? 180 : -180;
					}
					
					_zOffset = ( viewStack.clipContent ) ? contentWidth / 2 : 0;
					break;
				}
			}
        	
        	
    		var targetDuration:Number = ( scaleDurationByChange ) ? duration * ( Math.abs( valueTo - valueFrom ) / 180 ) : duration;
    		motionPaths =  [ new SimpleMotionPath( property, valueFrom, valueTo, targetDuration ) ];
        }
        
		override protected function setValue( property:String, value:Object ):void
	    {
			var v:Number = Number( value );
			
			_container[ property ] = v;
			
			if( _container.scaleX == 1 && Math.abs( v ) > 90 )
			{
				_displayedIndex = selectedIndexTo;
				_container.scaleX = -1;
				_bitmap.bitmapData = getBitmapDataAtIndex( selectedIndexTo );
			}
			
			_container.z = _zOffset * Math.sin( MathUtil.degreesToRadians( Math.abs( v ) ) );
	    }
		
	}	
	
}