package org.efflex.mx.maskEffects.actions
{
	import flash.display.DisplayObject;

	public interface IMaskAction
	{
		function register( mask:DisplayObject ):void
		function update( mask:DisplayObject, value:Number ):void
	}
}