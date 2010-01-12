package org.efflex.mx.pairViewStackEffects
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.pairViewStackEffects.effectClasses.SlideInstance;

	public class Slide extends PairViewStackTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES	: Array = [ "x", "y" ];
		
		public static const DOWN				: String = "down";
		public static const UP					: String = "up"; 
		public static const LEFT				: String = "left"; 
		public static const RIGHT				: String = "right";
		
		[Inspectable(category="General", type="String", enumeration="down,up,left,right", defaultValue="down")]
		public var fromDirection 				: String = Slide.DOWN;
		
		[Inspectable(category="General", type="String", enumeration="down,up,left,right", defaultValue="down")]
		public var toDirection 					: String = Slide.UP;
		
		public function Slide( target:UIComponent=null )
		{
			super( target );
		
			instanceClass = SlideInstance;
		}
	
	
		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
	
	
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:SlideInstance = SlideInstance( instance );
			effectInstance.fromDirection = fromDirection;
			effectInstance.toDirection = toDirection;
		}
		
	}
}