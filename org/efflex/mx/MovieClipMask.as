package org.efflex.mx
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.effectClasses.MovieClipMaskInstance;

	public class MovieClipMask extends BitmapEffect
	{
		
		private static var AFFECTED_PROPERTIES:Array = [ "movieClipMask" ];
		
		[Inspectable(category="General")]
		public var source		: Class;
		
		[Inspectable(category="General")]
		public var frameFrom	: Object;
		
		[Inspectable(category="General")]
		public var frameTo		: Object;
		
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
			effectInstance.duration = duration;
		}
	}
}