package org.efflex.mx.pairViewStackEffects.effectClasses
{
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.effectClasses.ViewStackTweenEffectInstance;
	import org.efflex.utils.TweenUtil;

	public class PairViewStackTweenEffectInstance extends ViewStackTweenEffectInstance
	{
		
		public var hideStartPercent						: Number;
		public var hideEndPercent						: Number;
		public var hideEasingFunction					: Function;
		
		public var showStartPercent						: Number;
		public var showEndPercent						: Number;
		public var showEasingFunction					: Function;
		
		public var bringToFront							: String;
		
		private var _hideStartTime						: Number;
		private var _hideEndTime						: Number;
		private var _showStartTime						: Number;
		private var _showEndTime						: Number;
		
		public function PairViewStackTweenEffectInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
        	_hideStartTime = hideStartPercent / 100;
        	_hideEndTime = hideEndPercent / 100;
        	
        	_showStartTime = showStartPercent / 100;
        	_showEndTime = showEndPercent / 100;
        	
        	playPairViewStackEffect();
        	
        	tween = createTween( this, 0, 1, duration );
        }
        
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var v:Number = Number( value );
			
			var hideValue:Number = TweenUtil.normalizeValue( _hideStartTime, _hideEndTime, v, 0, 1 );
			var showValue:Number = TweenUtil.normalizeValue( _showStartTime, _showEndTime, v, 0, 1 );
			
			if( hideEasingFunction != null ) hideValue = hideEasingFunction( hideValue, 0, 1, 1 );
			if( showEasingFunction != null ) showValue = showEasingFunction( showValue, 0, 1, 1 );
			
			onPairTweenUpdate( hideValue, showValue );
		}
		
		protected function onPairTweenUpdate( hideValue:Number, showValue:Number ):void
		{
			
		}
		
		protected function playPairViewStackEffect():void
		{
			
		}
		
	}
}