/*
Copyright (c) 2008 Tink Ltd - http://www.tink.ws

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
	
	import org.efflex.mx.viewStackEffects.effectClasses.GridInstance;

	public class Grid extends ViewStackTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES		: Array = [ "x", "y" ];
		
		public static const DEFAULT_NUM_COLUMNS		: uint = 3;
		
		public static const BASE_DISTANCE_ON_WIDTH	: String = "width";
		public static const BASE_DISTANCE_ON_HEIGHT	: String = "height";
		
		[Inspectable(category="General", type="String", defaultValue="3")]
		public var numColumns 						: uint = DEFAULT_NUM_COLUMNS;
		
		[Inspectable(category="General", type="Boolean", enumeration="true,false", defaultValue="true")]
		public var baseDurationOnDistance			: Boolean = true;
		
		[Inspectable(category="General", type="String", enumeration="width,hight", defaultValue="width")]
		public var baseDistanceOn					: String = BASE_DISTANCE_ON_WIDTH;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
	
		/**
		 *  Constructor.
		 *
		 *  @param target The Object to animate with this effect.
		 */
		public function Grid( target:UIComponent = null )
		{
			super( target );
	
			instanceClass = GridInstance;
		}
	
	
		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
	
	
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:GridInstance = GridInstance( instance );
			effectInstance.numColumns = numColumns;
			effectInstance.baseDurationOnDistance = baseDurationOnDistance;
			effectInstance.baseDistanceOn = baseDistanceOn;
		}
		
	}
}