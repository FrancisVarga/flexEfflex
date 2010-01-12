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
	
	import org.efflex.mx.viewStackEffects.Fade;

	public class FadeInstance extends ViewStackTweenEffectInstance
	{
		
		public var alphaFrom					: Number;
		public var alphaTo						: Number;
		public var effectTarget					: String;
		
		private var _effectTarget				: Bitmap;
		
		public function FadeInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
			var bitmapFrom:Bitmap = new Bitmap( snapShot );
			var bitmapTo:Bitmap = new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) );
			
			switch( effectTarget )
			{
				case Fade.NEXT_CHILD :
				{
					_effectTarget = bitmapTo;
					display.addChild( bitmapFrom );
					display.addChild( bitmapTo );
					break;
				}
				case Fade.PREV_CHILD :
				{
					_effectTarget = bitmapFrom;
					display.addChild( bitmapTo );
					display.addChild( bitmapFrom );
					break;
				}
			}
	
			_effectTarget.alpha = alphaFrom;
	
			tween = createTween( this, alphaFrom, alphaTo, duration );
        }
		
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_effectTarget.alpha = Number( value );
		}
		
	}
}