package org.efflex.mx.viewStackEffects
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.viewStackEffects.effectClasses.FadeTileInstance;

	public class FadeTile extends TileTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES:Array = [ "alpha" ];
		
		public static const PREV_CHILD			: String = "prevChild";
		public static const NEXT_CHILD			: String = "nextChild";
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var alphaFrom					: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="1")]
		public var alphaTo						: Number = 1;
		
		[Inspectable(category="General", type="String", enumeration="nextChild,prevChild", defaultValue="nextChild")]
		public var effectTarget					: String = NEXT_CHILD;
		
		public function FadeTile( target:UIComponent = null )
		{
			super( target );
			
			instanceClass = FadeTileInstance;
		}
		
		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );

			var effectInstance:FadeTileInstance = FadeTileInstance( instance );
			effectInstance.alphaFrom = alphaFrom;
			effectInstance.alphaTo = alphaTo;
			effectInstance.effectTarget = effectTarget;
		}

	}
}