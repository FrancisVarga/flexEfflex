/*
Copyright (c) 2009 Tink Ltd - http://www.tink.ws

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions
of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO 
THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package org.efflex.mx.viewStackEffects
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.viewStackEffects.effectClasses.Flint2DInstance;

	public class Flint2D extends ViewStackEffect
	{
		
		private static var AFFECTED_PROPERTIES	: Array = [ "flint2D" ];
		
		public static const PREV_CHILD			: String = "prevChild";
		public static const NEXT_CHILD			: String = "nextChild";
		
		[Inspectable(category="General", type="String", enumeration="nextChild,prevChild", defaultValue="nextChild")]
		public var effectTarget					: String = NEXT_CHILD;
		
		private var _actions					: Array = new Array();
		
		public function Flint2D( target:UIComponent = null )
		{
			super( target );

			instanceClass = Flint2DInstance;
			
			transparent = true;
		}

		public function set actions( value:Array ):void
		{
			_actions = value;
		}
		
		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:Flint2DInstance = Flint2DInstance( instance );
			effectInstance.effectTarget = effectTarget;
			effectInstance.actions = _actions;
		}
	}
}