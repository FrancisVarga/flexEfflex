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

package org.efflex.mx
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.effectClasses.FlipPapervision3DInstance;
	import org.efflex.mx.effectClasses.RotatePapervision3DInstance;
	import org.papervision3d.core.math.Number3D;

	public class RotatePapervision3D extends Papervision3DEffect
	{
		
		private static var AFFECTED_PROPERTIES	: Array = [ "rotationY", "rotationX", "rotationZ" ];
		
//		public static const LEFT				: String = "left";
//		public static const RIGHT				: String = "right"; 
//		public static const UP					: String = "up"; 
//		public static const DOWN				: String = "down";
//		
//		[Inspectable(category="General", enumeration="left,right,up,down", defaultValue="left")]
//		public var direction 					: String = FlipPapervision3D.LEFT;


		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var rotationXFrom				: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="-360")]
		public var rotationXTo					: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var rotationYFrom				: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var rotationYTo					: Number = 90;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var rotationZFrom				: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var rotationZTo					: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="2")]
		public var numSegmentsWidth				: uint = 2;
		
		[Inspectable(category="General", type="Number", defaultValue="2")]
		public var numSegmentsHeight			: uint = 2;
		
		[Inspectable(category="General", type="Number3D")]
		public var origin						: Number3D;
		
		
		public function RotatePapervision3D( target:UIComponent = null )
		{
			super( target );
			
			instanceClass = RotatePapervision3DInstance;
		}
		
		override public function getAffectedProperties():Array
	    {
	        return AFFECTED_PROPERTIES;
	    }
	    
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:RotatePapervision3DInstance = RotatePapervision3DInstance( instance );
			effectInstance.rotationXFrom = rotationXFrom;
			effectInstance.rotationXTo = rotationXTo;
			effectInstance.rotationYFrom = rotationYFrom;
			effectInstance.rotationYTo = rotationYTo;
			effectInstance.rotationZFrom = rotationZFrom;
			effectInstance.rotationZTo = rotationZTo;
			effectInstance.numSegmentsWidth = numSegmentsWidth;
			effectInstance.numSegmentsHeight = numSegmentsHeight;
			effectInstance.origin = origin;
		}
	}
}