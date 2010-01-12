package org.efflex.mx.viewStackEffects
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.viewStackEffects.effectClasses.MoveResizeToFromDisplayObjectInstance;

	public class MoveResizeToFromDisplayObject extends ViewStackTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES	: Array = [ "alpha" ];
		
		public static const PREV_CHILD			: String = "prevChild";
		public static const NEXT_CHILD			: String = "nextChild";
		
		[Inspectable(category="General", type="Function")]
		public var displayObjectFunction					: Function;
		
		public function MoveResizeToFromDisplayObject( target:UIComponent=null )
		{
			super( target );
			
			instanceClass = MoveResizeToFromDisplayObjectInstance;
		}
		
		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
			
			var effectInstance:MoveResizeToFromDisplayObjectInstance = MoveResizeToFromDisplayObjectInstance( instance );
			effectInstance.displayObjectFunction = displayObjectFunction;
		}
	}
}