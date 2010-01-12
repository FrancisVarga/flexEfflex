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
	
	import org.efflex.mx.viewStackEffects.effectClasses.FadeZoomInstance;
	
	
	public class FadeZoom extends ViewStackTweenEffect
	{
		
		private static var AFFECTED_PROPERTIES	: Array = [ "alpha", "scaleX", "scaleY" ];
		
		public static const PREV_CHILD			: String = "prevChild";
		public static const NEXT_CHILD			: String = "nextChild";
		
		public static const TOP					: String = "top";
		public static const MIDDLE				: String = "middle";
		public static const BOTTOM				: String = "bottom";
		
		public static const LEFT				: String = "left";
		public static const CENTER				: String = "center";
		public static const RIGHT				: String = "right";
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var alphaFrom					: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="1")]
		public var alphaTo						: Number = 1;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var scaleXFrom					: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="1")]
		public var scaleXTo						: Number = 1;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var scaleYFrom					: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="1")]
		public var scaleYTo						: Number = 1;
		
		[Inspectable(category="General", type="String", enumeration="top,middle,bottom", defaultValue="middle")]
		public var verticalAlign				: String = MIDDLE;
		
		[Inspectable(category="General", type="String", enumeration="left,center,right", defaultValue="center")]
		public var horizontalAlign				: String = CENTER;
		
		[Inspectable(category="General", enumeration="nextChild,prevChild", defaultValue="nextChild")]
		public var effectTarget					: String = NEXT_CHILD;
		
		public function FadeZoom( target:UIComponent = null )
		{
			super( target );
			
			instanceClass = FadeZoomInstance;
		}
		
		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );

			var effectInstance:FadeZoomInstance = FadeZoomInstance( instance );
			effectInstance.alphaFrom = alphaFrom;
			effectInstance.alphaTo = alphaTo;
			effectInstance.scaleXFrom = scaleXFrom;
			effectInstance.scaleXTo = scaleXTo;
			effectInstance.scaleYFrom = scaleYFrom;
			effectInstance.scaleYTo = scaleYTo;
			effectInstance.verticalAlign = verticalAlign;
			effectInstance.horizontalAlign = horizontalAlign;
			effectInstance.effectTarget = effectTarget;
		}

	}
}