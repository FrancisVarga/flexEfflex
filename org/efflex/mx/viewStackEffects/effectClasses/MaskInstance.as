package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.MaskEffect;

	public class MaskInstance extends ViewStackTweenEffectInstance
	{
		
		public var effectTarget				: String;
		public var actions					: Array;
		public var maskX					: Number;
		public var maskY					: Number;
		public var showMaskInColor			: Number;
		
		private var _mask					: DisplayObject;
		
		
		public function MaskInstance( target:UIComponent )
		{
			super( target );
		}
		
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
        	_mask = createMask();
        	_mask.x = maskX;
        	_mask.y = maskY;
        	if( !isNaN( showMaskInColor ) )
        	{
        		var colorTransform:ColorTransform = new ColorTransform();
        		colorTransform.color = showMaskInColor;
        		_mask.transform.colorTransform = colorTransform;
        	}
        	
        	onTweenUpdate( 0 );
        	
        	var bitmapFrom:Bitmap = new Bitmap( snapShot );
			var bitmapTo:Bitmap = new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) );
			
        	switch( effectTarget )
			{
				case MaskEffect.NEXT_CHILD :
				{
					display.addChild( bitmapFrom );
					display.addChild( bitmapTo );
					if( isNaN( showMaskInColor ) ) bitmapTo.mask = _mask;
					break;
				}
				case MaskEffect.PREV_CHILD :
				{
					display.addChild( bitmapTo );
					display.addChild( bitmapFrom );
					if( isNaN( showMaskInColor ) ) bitmapFrom.mask = _mask;
					break;
				}
			}
			
			display.addChild( _mask );
	
			tween = createTween( this, 0, 1, duration );
        }
        
        protected function createMask():DisplayObject
        {
        	return new Sprite();
        }
        
//		override public function finishEffect():void
//	    {
//	    	super.finishEffect();
//	    	
//	    	mask = null;
//	    }
		
	}
}