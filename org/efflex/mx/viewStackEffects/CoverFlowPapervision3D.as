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
	
	import org.efflex.mx.viewStackEffects.effectClasses.CoverFlowPapervision3DInstance;

	public class CoverFlowPapervision3D extends Papervision3DEffect
	{
		
		private static var AFFECTED_PROPERTIES	: Array = [ "x", "y", "z", "rotationY", "rotationX" ];
		
		public static const HORIZONTAL			: String = "horizontal"; 
		public static const VERTICAL			: String = "vertical";
		
		[Inspectable(category="General", type="Number", defaultValue="45")]
		public var angle 					: Number = 45;
		
		[Inspectable(category="General", type="Number", defaultValue="1000")]
		public var zOffset	 					: Number = 1000;
		
		[Inspectable(category="General", type="Number", defaultValue="30")]
		public var offset	 				: Number = 30;
		
		[Inspectable(category="General", type="String", enumeration="horizontal,vertical", defaultValue="horizontal")]
		public var direction 					: String = CoverFlowPapervision3D.HORIZONTAL;
		
		[Inspectable(category="General", type="Number", defaultValue="2")]
		public var numSegmentsWidth				: uint = 2;
		
		[Inspectable(category="General", type="Number", defaultValue="2")]
		public var numSegmentsHeight			: uint = 2;
		
		
		public function CoverFlowPapervision3D( target:UIComponent = null )
		{
			super(target);

			instanceClass = CoverFlowPapervision3DInstance;
		}

		override public function getAffectedProperties():Array
		{
			return AFFECTED_PROPERTIES;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:CoverFlowPapervision3DInstance = CoverFlowPapervision3DInstance( instance );
			effectInstance.angle = angle;
			effectInstance.zOffset = zOffset;
			effectInstance.offset = offset;
			effectInstance.direction = direction;
			effectInstance.numSegmentsWidth = numSegmentsWidth;
			effectInstance.numSegmentsHeight = numSegmentsHeight;
		}
	}
}