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

package org.efflex.spark.viewStackEffects.supportClasses
{
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	import org.efflex.spark.viewStackEffects.supportClasses.ViewStackAnimateInstance;
	
	import mx.core.UIComponent;

	public class ViewStackAnimate3DInstance extends ViewStackAnimateInstance
	{
		
		public var fieldOfView	 			: Number;
		public var focalLength 	 			: Number;
		public var projectionCenter 		: Point;
		
		public function ViewStackAnimate3DInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
        	var perspectiveProjection:PerspectiveProjection = new PerspectiveProjection();
        	perspectiveProjection.fieldOfView = fieldOfView;
        	perspectiveProjection.focalLength = focalLength;
        	perspectiveProjection.projectionCenter = ( projectionCenter ) ? projectionCenter : new Point( contentWidth / 2, contentHeight / 2 );
        	
        	display.parent.transform.perspectiveProjection = perspectiveProjection;
        }
        
	}
}