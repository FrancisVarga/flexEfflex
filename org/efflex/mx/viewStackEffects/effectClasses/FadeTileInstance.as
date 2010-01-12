package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.FadeTile;

	public class FadeTileInstance extends TileTweenEffectInstance
	{
		
		public var alphaFrom					: Number;
		public var alphaTo						: Number;
		public var effectTarget					: String;
		
		private var _alphaDifference			: Number;
		private var _tileDisplay				: Sprite;
		
		
		public function FadeTileInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function createTileEffect() : void
        {
        	super.createTileEffect();
        	
        	var effectIndex:int;
        	
        	_alphaDifference = alphaTo - alphaFrom;
			
        	switch( effectTarget )
			{
				case FadeTile.NEXT_CHILD :
				{
					display.addChild( new Bitmap( snapShot ) );
					effectIndex = selectedIndexTo;
					break;
				}
				case FadeTile.PREV_CHILD :
				{
					display.addChild( new Bitmap( BitmapData( bitmapDatum[ selectedIndexTo ] ) ) );
					effectIndex = -1;
					break;
				}
			}
			
			var tile:Bitmap;
			_tileDisplay = new Sprite();
			for( var r:int = 0; r < numRows; r++ )
			{
				for( var c:int = 0; c < numColumns; c++ )
				{
					tile = new Bitmap( getBitmapDataTileAt( effectIndex, r, c ) );
					tile.x = tileWidth * c;
					tile.y = tileHeight * r;
					_tileDisplay.addChild( tile );
				}
			}
			
			onTweenUpdate( 0 );
			
			display.addChild( _tileDisplay );
        }
        
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var tile:Bitmap;
			for( var r:int = 0; r < numRows; r++ )
			{
				for( var c:int = 0; c < numColumns; c++ )
				{
					_tileDisplay.getChildAt( c + ( r * numRows ) ).alpha = alphaFrom + ( _alphaDifference * getTileValueAt( r, c ) );
				}
			}
		}
		
	}
}