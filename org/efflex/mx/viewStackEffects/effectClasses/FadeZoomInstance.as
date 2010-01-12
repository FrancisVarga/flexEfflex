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
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.FadeZoom;
	
	public class FadeZoomInstance extends ViewStackTweenEffectInstance
	{
		
		
		public var alphaFrom					: Number;
		public var alphaTo						: Number;
		
		public var scaleXTo						: Number;
		public var scaleXFrom					: Number;
		public var scaleYTo						: Number;
		public var scaleYFrom					: Number;
		
		public var verticalAlign				: String;
		public var horizontalAlign				: String;
		
		public var effectTarget					: String;
		
		private var _effectTarget				: Bitmap
		
		public function FadeZoomInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playViewStackEffect():void
		{
			super.playViewStackEffect();
			
			var bitmapFrom:Bitmap = new Bitmap( snapShot );
			var bitmapTo:Bitmap = new Bitmap( bitmapDatum[ selectedIndexTo ] );
			
			switch( effectTarget )
			{
				case FadeZoom.NEXT_CHILD :
				{
					_effectTarget = bitmapTo;
					display.addChild( bitmapFrom );
					display.addChild( bitmapTo );
					break;
				}
				case FadeZoom.PREV_CHILD :
				{
					_effectTarget = bitmapFrom;
					display.addChild( bitmapTo );
					display.addChild( bitmapFrom );
					break;
				}
			}
			
			_effectTarget.alpha = alphaFrom;
			_effectTarget.scaleX = scaleXFrom;
			_effectTarget.scaleY = scaleYFrom;
			
			alignTarget();
			
			tween = createTween( this, [ alphaFrom, scaleXFrom, scaleYFrom ], [ alphaTo, scaleXTo, scaleYTo ], duration );
		}
		
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_effectTarget.alpha = Number( value[ 0 ] );
			_effectTarget.scaleX = Number( value[ 1 ] );
			_effectTarget.scaleY = Number( value[ 2 ] );
			
			alignTarget();
		}
		
		private function alignTarget():void
		{
			switch( horizontalAlign )
			{
				case FadeZoom.LEFT :
				{
					_effectTarget.y = 0;
					break;
				}
				case FadeZoom.CENTER :
				{
					_effectTarget.x = ( contentWidth - _effectTarget.width ) / 2;
					break;
				}
				case FadeZoom.RIGHT :
				{
					_effectTarget.x = contentWidth - _effectTarget.width;
					break;
				}
			}
			
			switch( verticalAlign )
			{
				case FadeZoom.TOP :
				{
					_effectTarget.y = 0;
					break;
				}
				case FadeZoom.MIDDLE :
				{
					_effectTarget.y = ( contentHeight - _effectTarget.height ) / 2;
					break;
				}
				case FadeZoom.BOTTOM :
				{
					_effectTarget.y = contentHeight - _effectTarget.height;
					break;
				}
			}
		}
		
	}
}