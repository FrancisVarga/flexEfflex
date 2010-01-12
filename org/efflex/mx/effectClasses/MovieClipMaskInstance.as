package org.efflex.mx.effectClasses
{
	import flash.display.Bitmap;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	
	import org.efflex.mx.core.MovieClipCore;

	public class MovieClipMaskInstance extends BitmapInstance
	{
		
		public var source						: Class;
		public var frameFrom					: Object;
		public var frameTo						: Object;
		
		private var _movieClipCore				: MovieClipCore;
		
		public function MovieClipMaskInstance( target:UIComponent )
		{
			super( target );
		}
		
		override public function play():void
        {
			_movieClipCore = new MovieClipCore( source, frameFrom, frameTo, duration );

			display.mask = _movieClipCore.movieClip;
			
			display.addChild( new Bitmap( bitmapData ) );
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
//			target.mask = null;
	    	
	    	super.finishEffect();
	    }
	}
}