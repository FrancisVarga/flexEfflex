package org.efflex.mx.pairViewStackEffects.effectClasses
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.core.MovieClipCore;
	import org.efflex.mx.pairViewStackEffects.PairViewStackTweenEffect;

	public class MovieClipMaskInstance extends PairViewStackTweenEffectInstance
	{
		
		public var hideSource					: Class;
		public var hideFrameFrom				: Object;
		public var hideFrameTo					: Object;
		public var showSource					: Class;
		public var showFrameFrom				: Object;
		public var showFrameTo					: Object;
		
		private var _hideMovieClipCore				: MovieClipCore;
		private var _showMovieClipCore				: MovieClipCore;
		
		private var _hidding					: Bitmap;
		private var _showing					: Bitmap;
		
		public function MovieClipMaskInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playPairViewStackEffect():void
        {
        	super.playPairViewStackEffect();
        	
        
        	_hideMovieClipCore = new MovieClipCore( hideSource, hideFrameFrom, hideFrameTo, duration );
        	_showMovieClipCore = new MovieClipCore( showSource, showFrameFrom, showFrameTo, duration );
        	
        	var bitmapFrom:Bitmap = new Bitmap( snapShot );
			var bitmapTo:Bitmap = new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) );
			
			_hidding = new Bitmap( snapShot );
			_showing = new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) );
			
			_hidding.mask = _hideMovieClipCore.movieClip;
			_showing.mask = _showMovieClipCore.movieClip;
			
        	switch( bringToFront )
			{
				case PairViewStackTweenEffect.NEXT_CHILD :
				{
					display.addChild( _hidding );
					display.addChild( _showing );
					break;
				}
				case PairViewStackTweenEffect.PREV_CHILD :
				{
					display.addChild( _showing );
					display.addChild( _hidding );
					break;
				}
			}
	
			display.addChild( _hideMovieClipCore.movieClip );
			display.addChild( _showMovieClipCore.movieClip );
        }
        
        override protected function onPairTweenUpdate( hideValue:Number, showValue:Number ):void
		{
			super.onPairTweenUpdate( hideValue, showValue );
			
			_hideMovieClipCore.update( Number( hideValue ) );
			_showMovieClipCore.update( Number( showValue ) );
		}
		
		override public function finishEffect():void
	    {
	    	super.finishEffect();
	    	
	    	_hideMovieClipCore = null;
	    	_showMovieClipCore = null;
	    }
		
	}
}