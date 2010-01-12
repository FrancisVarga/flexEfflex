package org.efflex.mx.viewStackEffects
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.core.TileCore;
	import org.efflex.mx.viewStackEffects.effectClasses.TileTweenEffectInstance;

	public class TileTweenEffect extends ViewStackTweenEffect
	{
		
		[Inspectable(category="General", type="uint", defaultValue="5")]
		public var numRows		: uint = 5;
		
		[Inspectable(category="General", type="uint", defaultValue="5")]
		public var numColumns	: uint = 5;
		
		[Inspectable(category="General", type="Number", defaultValue="50")]
		public var tileDurationPercent	: Number = 50;
		
		[Inspectable(category="General", type="String", enumeration="random,topRightToBottomLeft,topLeftToBottomRight,bottomRightToTopLeft,bottomLeftToTopRight", defaultValue="random")]
		public var order	: String = TileCore.RANDOM;
		
		public function TileTweenEffect( target:UIComponent=null )
		{
			super( target );
			
			instanceClass = TileTweenEffectInstance;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:TileTweenEffectInstance = TileTweenEffectInstance( instance );
			effectInstance.numRows = numRows;
			effectInstance.numColumns = numColumns;
			effectInstance.tileDurationPercent = tileDurationPercent;
			effectInstance.order = order;
		}
	}
}