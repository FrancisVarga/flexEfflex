package org.efflex.mx.pairViewStackEffects
{

	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.pairViewStackEffects.effectClasses.PairViewStackTweenEffectInstance;
	import org.efflex.mx.viewStackEffects.ViewStackTweenEffect;

	public class PairViewStackTweenEffect extends ViewStackTweenEffect
	{
		
		public static const PREV_CHILD					: String = "prevChild";
		public static const NEXT_CHILD					: String = "nextChild";
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var hideStartPercent						: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="100")]
		public var hideEndPercent						: Number = 100;
		
		[Inspectable(category="General", type="Function", defaultValue="null")]
		public var hideEasingFunction				: Function;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var showStartPercent						: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="100")]
		public var showEndPercent						: Number = 100;
		
		[Inspectable(category="General", type="Function", defaultValue="null")]
		public var showEasingFunction					: Function;
		
		[Inspectable(category="General", type="String", enumeration="show,hide", defaultValue="show")]
		public var bringToFront							: String = NEXT_CHILD;
		
		public function PairViewStackTweenEffect( target:UIComponent=null )
		{
			super( target );
			
			instanceClass = PairViewStackTweenEffectInstance;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:PairViewStackTweenEffectInstance = PairViewStackTweenEffectInstance( instance );
			effectInstance.hideStartPercent = hideStartPercent;
			effectInstance.hideEndPercent = hideEndPercent;
			effectInstance.hideEasingFunction = hideEasingFunction;
			effectInstance.showStartPercent = showStartPercent;
			effectInstance.showEndPercent = showEndPercent;
			effectInstance.showEasingFunction = showEasingFunction;
			effectInstance.bringToFront = bringToFront;
		}
		
	}
}