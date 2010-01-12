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
	
	import org.efflex.mx.viewStackEffects.Slide;

	
	public class SlideInstance extends ViewStackTweenEffectInstance
	{
		
		public var direction 				: String;
		public var slideType 				: String;
		
		private var _bitmapFrom				: Bitmap;
		private var _bitmapBetween			: Bitmap;
		private var _bitmapTo				: Bitmap;
		
		private var _distance				: Number;
		private var _offset					: Number;
		
		
		public function SlideInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function setInturruptionParams():void
		{
			super.setInturruptionParams();
			
			data.interruptedIndexFrom = selectedIndexFrom;
			data.interruptedIndexTo = selectedIndexTo;
			data.interruptedFromX = _bitmapFrom.x;
			data.interruptedFromY = _bitmapFrom.y;
			data.interruptedDirection = direction;
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
			createSlide();
			
			tween = createTween( this, 0, 1, duration );
        }
        
        private function createSlide():void
        {
        	_bitmapFrom = new Bitmap( snapShot );
			_bitmapTo = new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) );
			
			_offset = 0;
			
        	switch( direction )
			{
				case Slide.DOWN :
				{
					_distance = contentHeight;
					_bitmapTo.y = ( slideType == Slide.OUT ) ? 0 : -_distance;
					break;
				}
				case Slide.UP :
				{
					_distance = contentHeight;
					_bitmapTo.y = ( slideType == Slide.OUT ) ? 0 : _distance;
					break;
				}
				case Slide.LEFT :
				{
					_distance = contentWidth;
					_bitmapTo.x = ( slideType == Slide.OUT ) ? 0 : _distance;
					break;
				}
				case Slide.RIGHT :
				{
					_distance = contentWidth;
					_bitmapTo.x = ( slideType == Slide.OUT ) ? 0 : -_distance;
					break;
				}
			}
			
			switch( slideType )
			{
				case Slide.OUT :
				{
					display.addChild( _bitmapTo );
					display.addChild( _bitmapFrom );
					break;
				}
				default :
				{
					display.addChild( _bitmapFrom );
					display.addChild( _bitmapTo );
				}
			}
        }
        
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var position:Number = Number( value );
			
			switch( direction )
			{
				case Slide.DOWN :
				{
					_bitmapTo.y = ( slideType == Slide.OUT ) ? 0 : -_distance * ( 1 - position );
					_bitmapFrom.y = ( slideType == Slide.IN ) ? 0 : _distance * position;
					break;
				}
				case Slide.UP :
				{
					_bitmapTo.y = ( slideType == Slide.OUT ) ? 0 : _distance * ( 1 - position );
					_bitmapFrom.y = ( slideType == Slide.IN ) ? 0 : -_distance * position;
					break;
				}
				case Slide.LEFT :
				{
					_bitmapTo.x = ( slideType == Slide.OUT ) ? 0 : _distance * ( 1 - position );
					_bitmapFrom.x = ( slideType == Slide.IN ) ? 0 : -_distance * position;
					break;
				}
				case Slide.RIGHT :
				{
					_bitmapTo.x = ( slideType == Slide.OUT ) ? 0 : -_distance * ( 1 - position );
					_bitmapFrom.x = ( slideType == Slide.IN ) ? 0 : _distance * position;
					break;
				}
			}
		}
		
	}
}