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

package org.efflex.mx.effectClasses
{
	import mx.core.UIComponent;
	
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;

	public class RotatePapervision3DInstance extends Papervision3DInstance
	{
		
		public var direction			:String;
		public var numSegmentsWidth		: uint;
		public var numSegmentsHeight	: uint;
		
		private var _plane				: Plane;
		private var _container			: DisplayObject3D;
		
		public var rotationXFrom		: Number;
		public var rotationXTo			: Number;
		public var rotationYFrom		: Number;
		public var rotationYTo			: Number;
		public var rotationZFrom		: Number;
		public var rotationZTo			: Number;
		
		public var origin				: Number3D;
		
		public function RotatePapervision3DInstance(target:UIComponent)
		{
			super( target );
		}
	    
	    override public function play():void
        {
			var w:Number = bitmapMaterial.bitmap.width;
			var h:Number = bitmapMaterial.bitmap.height;
			
			_container = new DisplayObject3D();
			_container.rotationX = rotationXFrom;
			_container.rotationY = rotationYFrom;
			_container.rotationZ = rotationZFrom;
			addChild3D( _container );
			
			_plane = new Plane( bitmapMaterial, w, h, numSegmentsWidth, numSegmentsHeight );
			
			if( origin )
			{
				_container.x = -origin.x;
				_container.y = -origin.y;
				_container.z = -origin.z;
				_plane.x = origin.x;
				_plane.y = origin.y;
				_plane.z = origin.z;
			}
			
			_container.addChild( _plane );
			
			createTween( this, 0, 1, duration );
			
			super.play();
        }
		
		override public function onTweenUpdate( value:Object ):void
		{
			var v:Number = Number( value );
			
			_container.rotationX = rotationXFrom + ( ( rotationXTo - rotationXFrom ) * v );
			_container.rotationY = rotationYFrom + ( ( rotationYTo - rotationYFrom ) * v );
			_container.rotationZ = rotationZFrom + ( ( rotationZTo - rotationZFrom ) * v );
			
			super.onTweenUpdate( value );
		}
		
		
	}
}