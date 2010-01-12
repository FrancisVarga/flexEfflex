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

package org.efflex.mx.effectClasses
{
	import mx.core.UIComponent;
	
	import org.efflex.mx.core.MovieClipCore;

	public class MovieClipInstance extends ContainerInstance
	{
		
		public var source						: Class;
		public var frameFrom					: Object;
		public var frameTo						: Object;
		
		private var _movieClipCore				: MovieClipCore;
		
		public function MovieClipInstance( target:UIComponent )
		{
			super( target );
		}

		override public function play():void
        {
			_movieClipCore = new MovieClipCore( source, frameFrom, frameTo, duration );
			display.addChild( _movieClipCore.movieClip );
			
			tween = createTween( this, 0, 1, _movieClipCore.duration );
			
			super.play();
        }

		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_movieClipCore.update( Number( value ) );
		}
		
		override public function finishEffect():void
	    {
			display.removeChild( _movieClipCore.movieClip );
	    	_movieClipCore = null;
	    	
	    	super.finishEffect();
	    }
	    
	}
}