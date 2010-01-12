package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.core.MovieClipCore;
	import org.efflex.mx.viewStackEffects.MovieClipMask;

	public class MovieClipMaskInstance extends ViewStackTweenEffectInstance
	{
		
		public var effectTarget					: String;
		
		public var source						: Class;
		public var frameFrom					: Object;
		public var frameTo					: Object;
		
		private var _movieClipCore				: MovieClipCore;
		
		public function MovieClipMaskInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
        	_movieClipCore = new MovieClipCore( source, frameFrom, frameTo, duration );
        	
        	var bitmapFrom:Bitmap = new Bitmap( snapShot );
			var bitmapTo:Bitmap = new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) );
			
        	switch( effectTarget )
			{
				case MovieClipMask.NEXT_CHILD :
				{
					display.addChild( bitmapFrom );
					display.addChild( bitmapTo );
					bitmapTo.mask = _movieClipCore.movieClip;
					break;
				}
				case MovieClipMask.PREV_CHILD :
				{
					display.addChild( bitmapTo );
					display.addChild( bitmapFrom );
					bitmapFrom.mask = _movieClipCore.movieClip;
					break;
				}
			}
	
			display.addChild( _movieClipCore.movieClip );
	
			tween = createTween( this, 0, 1, _movieClipCore.duration );
        }
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_movieClipCore.update( Number( value ) );
		}
		
		override public function finishEffect():void
	    {
	    	super.finishEffect();
	    	
	    	_movieClipCore = null;
	    }
		
	}
}