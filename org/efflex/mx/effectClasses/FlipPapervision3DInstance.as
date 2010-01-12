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
	import mx.events.FlexEvent;
	
	import org.efflex.mx.FlipPapervision3D;
	import org.papervision3d.objects.primitives.Plane;
	
	import ws.tink.utils.MathUtil;

	public class FlipPapervision3DInstance extends Papervision3DInstance
	{
		
		public var direction			:String;
		public var numSegmentsWidth		: uint;
		public var numSegmentsHeight	: uint;
		
		private var _plane				: Plane;
		private var _startRotation		: Number;
		
		public function FlipPapervision3DInstance(target:UIComponent)
		{
			super( target );
		}
	    
	    override public function play():void
        {
			var w:Number = bitmapMaterial.bitmap.width;
			var h:Number = bitmapMaterial.bitmap.height;
			
			_plane = new Plane( bitmapMaterial, w, h, numSegmentsWidth, numSegmentsHeight );
			addChild3D( _plane );
			
			_startRotation = 0;
			if( triggerEvent.type == FlexEvent.SHOW )
			{
				switch( direction )
				{
					case FlipPapervision3D.DOWN :
					{
						_plane.rotationX = _startRotation = -90;
						break;
					}
					case FlipPapervision3D.LEFT :
					{
						_plane.rotationY = _startRotation = -90;
						break;
					}
					case FlipPapervision3D.RIGHT :
					{
						_plane.rotationY = _startRotation = 90;
						break;
					}
					case FlipPapervision3D.UP :
					{
						_plane.rotationX = _startRotation = 90;
						break;
					}
				}
			}
			
			createTween( this, 0, 1, duration );
			
			super.play();
        }
		
		override public function onTweenUpdate( value:Object ):void
		{
			var v:Number = Number( value );
			var t:UIComponent = UIComponent( target );
			var constrainPercent:Number = ( triggerEvent.type == FlexEvent.SHOW ) ? Math.abs( v - 1 ) : v;
			switch( direction )
			{
				case FlipPapervision3D.DOWN :
				{
					_plane.rotationX = _startRotation + ( 90 * v );
					if( constrain ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationX ) ) * ( bitmapMaterial.bitmap.height / 2 ) );
					break;
				}
				case FlipPapervision3D.LEFT :
				{
					_plane.rotationY = _startRotation + ( 90 * v );
					if( constrain ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationY ) ) * ( bitmapMaterial.bitmap.width / 2 ) );
					break;
				}
				case FlipPapervision3D.RIGHT :
				{
					_plane.rotationY = _startRotation - ( 90 * v );
					if( constrain ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationY ) ) * ( bitmapMaterial.bitmap.width / 2 ) );
					break;
				}
				case FlipPapervision3D.UP :
				{
					_plane.rotationX = _startRotation - ( 90 * v );
					if( constrain ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationX ) ) * ( bitmapMaterial.bitmap.height / 2 ) );
					break;
				}
			}
			
			super.onTweenUpdate( value );
		}
		
		
	}
}