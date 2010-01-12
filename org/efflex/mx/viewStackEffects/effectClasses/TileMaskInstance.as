package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mx.core.IFactory;
	import mx.core.UIComponent;
	
	import org.efflex.mx.core.TileCore;
	import org.efflex.mx.maskEffects.actions.IMaskAction;
	import org.efflex.utils.TileUtil;

	public class TileMaskInstance extends MaskInstance
	{
		
		public var numRows						: uint;
		public var numColumns					: uint;
		public var horizontalSpacing			: Number;
		public var verticalSpacing				: Number;
		public var tileDurationPercent			: Number;
		public var order						: String;
		
		public var shapeFactory						: IFactory;
		
		private var _masks					: Array;
		
		private var _tileCore				: TileCore;
		
		public function TileMaskInstance( target:UIComponent )
		{
			super( target );
		}
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_tileCore.update( Number( value ) );
			var numActions:int = actions.length;
			for( var r:int = 0; r < numRows; r++ )
			{
				for( var c:int = 0; c < numColumns; c++ )
				{
					for( var i:int = 0; i < numActions; i++ )
					{
						IMaskAction( actions[ i ] ).update( DisplayObject( _masks[ r ][ c ] ), _tileCore.getTileValueAt( r, c ) );
					}
				}
			}
		}
		
		override protected function createMask():DisplayObject
        {
        	_tileCore = new TileCore( numRows, numColumns, order, tileDurationPercent, duration );
        	
        	_masks = TileUtil.createShapeTiles( shapeFactory, numRows, numColumns, horizontalSpacing, verticalSpacing );
        	
        	var maskContainer:Sprite = new Sprite();
        	for( var r:int = 0; r < numRows; r++ )
			{
				for( var c:int = 0; c < numColumns; c++ )
				{
					maskContainer.addChild( DisplayObject( _masks[ r ][ c ] ) );
				}
			}
        	
        	return maskContainer;
        }
        
	}
}