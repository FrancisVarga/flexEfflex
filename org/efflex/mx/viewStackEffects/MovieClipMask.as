package org.efflex.mx.viewStackEffects
{
	
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.viewStackEffects.effectClasses.MovieClipMaskInstance;

	public class MovieClipMask extends ViewStackTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES:Array = [ "movieClipMask" ];
		
		public static const PREV_CHILD			: String = "prevChild";
		public static const NEXT_CHILD			: String = "nextChild";
		
		[Inspectable(category="General")]
		public var source		: Class;
		
		[Inspectable(category="General")]
		public var frameFrom	: Object;
		
		[Inspectable(category="General")]
		public var frameTo		: Object;
		
		[Inspectable(category="General", type="String", enumeration="nextChild,prevChild", defaultValue="nextChild")]
		public var effectTarget					: String = NEXT_CHILD;
		
		public function MovieClipMask( target:UIComponent = null )
		{
			super( target );
			
			instanceClass = MovieClipMaskInstance;
		}
		
		override public function getAffectedProperties():Array
	    {
	        return AFFECTED_PROPERTIES;
	    }
	    
	    override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:MovieClipMaskInstance = MovieClipMaskInstance( instance );
			effectInstance.source = source;
			effectInstance.frameFrom = frameFrom;
			effectInstance.frameTo = frameTo;
			effectInstance.effectTarget = effectTarget;
		}
	}
}