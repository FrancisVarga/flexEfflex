package org.efflex.mx.pairViewStackEffects
{
	
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.pairViewStackEffects.effectClasses.MovieClipMaskInstance;

	public class MovieClipMask extends PairViewStackTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES:Array = [ "movieClipMask" ];
		
		[Inspectable(category="General")]
		public var showSource		: Class;
		
		[Inspectable(category="General")]
		public var showFrameFrom	: Object;
		
		[Inspectable(category="General")]
		public var showFrameTo		: Object;
		
		[Inspectable(category="General")]
		public var hideSource		: Class;
		
		[Inspectable(category="General")]
		public var hideFrameFrom	: Object;
		
		[Inspectable(category="General")]
		public var hideFrameTo		: Object;
		
		
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
			effectInstance.showSource = showSource;
			effectInstance.showFrameFrom = showFrameFrom;
			effectInstance.showFrameTo = showFrameTo;
			effectInstance.hideSource = hideSource;
			effectInstance.hideFrameFrom = hideFrameFrom;
			effectInstance.hideFrameTo = hideFrameTo;
			effectInstance.bringToFront = bringToFront;
		}
	}
}