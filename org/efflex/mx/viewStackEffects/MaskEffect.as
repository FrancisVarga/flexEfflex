package org.efflex.mx.viewStackEffects
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.viewStackEffects.effectClasses.MaskInstance;

	public class MaskEffect extends ViewStackTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES:Array = [ "mask" ];
		
		public static const PREV_CHILD			: String = "prevChild";
		public static const NEXT_CHILD			: String = "nextChild";
		
		[Inspectable(category="General", type="String", enumeration="nextChild,prevChild", defaultValue="nextChild")]
		public var effectTarget					: String = NEXT_CHILD;
		
		[Inspectable(category="General", type="Array")]
		public var actions						: Array;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var maskX						: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var maskY						: Number = 0;
		
		[Inspectable(category="General", type="Color")]
		public var showMaskInColor					: Number;
		
		public function MaskEffect(target:UIComponent=null)
		{
			super( target );
			
			instanceClass = MaskInstance;
		}
		
		override public function getAffectedProperties():Array
	    {
	        return AFFECTED_PROPERTIES;
	    }
	    
	    override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:MaskInstance = MaskInstance( instance );
			effectInstance.effectTarget = effectTarget;
			effectInstance.actions = actions;
			effectInstance.maskX = maskX;
			effectInstance.maskY = maskY;
			effectInstance.showMaskInColor = showMaskInColor;
		}
	}
}