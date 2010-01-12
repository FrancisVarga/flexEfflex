package org.efflex.mx.viewStackEffects
{
	import mx.core.IFactory;
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.core.TileCore;
	import org.efflex.mx.viewStackEffects.effectClasses.TileMaskInstance;

	public class TileMask extends MaskEffect
	{
		
		private static var AFFECTED_PROPERTIES	: Array = [ "tileMask" ];
		
		[Inspectable(category="General", type="uint", defaultValue="5")]
		public var numRows				: uint = 5;
		
		[Inspectable(category="General", type="uint", defaultValue="5")]
		public var numColumns			: uint = 5;
		
		[Inspectable(category="General", type="Number", defaultValue="20")]
		public var horizontalSpacing	: uint = 20;
		
		[Inspectable(category="General", type="Number", defaultValue="20")]
		public var verticalSpacing		: Number = 20;
		
		[Inspectable(category="General", type="Number", defaultValue="50")]
		public var tileDurationPercent	: Number = 50;
		
		[Inspectable(category="General", type="String", enumeration="random,topRightToBottomLeft,topLeftToBottomRight,bottomRightToTopLeft,bottomLeftToTopRight", defaultValue="random")]
		public var order				: String = TileCore.RANDOM;
		
		[Inspectable(category="General")]
		public var shapeFactory		: IFactory;

		
		
		
		public function TileMask( target:UIComponent=null )
		{
			super( target );
		
			instanceClass = TileMaskInstance;
		}
		
		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:TileMaskInstance = TileMaskInstance( instance );
			effectInstance.numRows = numRows;
			effectInstance.numColumns = numColumns;
			effectInstance.tileDurationPercent = tileDurationPercent;
			effectInstance.order = order;
			effectInstance.horizontalSpacing = horizontalSpacing;
			effectInstance.verticalSpacing = verticalSpacing;
			effectInstance.shapeFactory = shapeFactory;
		}
	}
}