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

package org.efflex.mx.viewStackEffects.effectClasses
{
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.CubePapervision3D;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	
	import ws.tink.utils.MathUtil;

	public class CubePapervision3DInstance extends Papervision3DEffectInstance
	{
		
		private const FRONT					: String = "FRONT";
		private const BACK					: String = "BACK";
		private const LEFT					: String = "LEFT";
		private const RIGHT					: String = "RIGHT";
		private const TOP					: String = "TOP";
		private const BOTTOM				: String = "BOTTOM";

		
		public var scaleDurationByChange	: Boolean = true;
		public var direction				: String;
		public var segmentsS				: int = 2;
		public var segmentsT				: int = 2;
		public var segmentsH				: int = 2;
		
		
		private var _cube					: Cube;
		private var _showingSelectedIndexTo	: Boolean;
		
		private var _rotationStart			: Number;
		private var _rotationDiff			: Number;
		
		private var _bitmapDatumSides		: Array;
		
		private var _hypotenuse				: Number;
		private var _zDifference			: Number;
		private var _zStart					: Number;
		
		private var _faceIndices				: FaceIndices;
		
		
		public function CubePapervision3DInstance(target:UIComponent)
		{
			super( target );
		}
		
		override protected function setInturruptionParams():void
		{
			super.setInturruptionParams();
			
			var cubeRotation:Number;
			switch( direction )
			{
				case CubePapervision3D.UP :
				{
					cubeRotation = Math.abs( _cube.rotationX );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _faceIndices.bottom : _faceIndices.back;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _faceIndices.front : _faceIndices.bottom;
					break;
				}
				case CubePapervision3D.DOWN :
				{
					cubeRotation = Math.abs( _cube.rotationX );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _faceIndices.top : _faceIndices.back;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _faceIndices.front : _faceIndices.top;
					break;
				}
				case CubePapervision3D.LEFT :
				{
					cubeRotation = Math.abs( _cube.rotationY );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _faceIndices.right : _faceIndices.back;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _faceIndices.front : _faceIndices.right;
					break;
				}
				case CubePapervision3D.RIGHT :
				{
					cubeRotation = Math.abs( _cube.rotationY );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _faceIndices.left : _faceIndices.back;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _faceIndices.front : _faceIndices.left;
					break;
				}
			}
			
			data.interruptedRotationX = _cube.rotationX % 90;
			data.interruptedRotationY = _cube.rotationY % 90;
		}
		
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
			_faceIndices = new FaceIndices();
			_rotationStart = 0;
			var depth:Number;
			
			switch( direction )
			{
				case CubePapervision3D.DOWN :
				{
					if( wasInterrupted )
					{
						_faceIndices.back = data.interruptedSelectedIndexFrom;
						_faceIndices.top = selectedIndexTo;
						_faceIndices.front = data.interruptedSelectedIndexTo;
						_rotationStart = data.interruptedRotationX;
					}
					else
					{
						_faceIndices.back = selectedIndexFrom;
						_faceIndices.top = selectedIndexTo;
					}
					depth = contentHeight;
					break;
				}
				case CubePapervision3D.UP :
				{
					if( wasInterrupted )
					{
						_faceIndices.back = data.interruptedSelectedIndexFrom
						_faceIndices.bottom = selectedIndexTo;
						_faceIndices.front = data.interruptedSelectedIndexTo;
						_rotationStart = data.interruptedRotationX;
					}
					else
					{
						_faceIndices.back = selectedIndexFrom;
						_faceIndices.bottom = selectedIndexTo;
					}
					depth = contentHeight;
					break;
				}
				case CubePapervision3D.LEFT :
				{
					if( wasInterrupted )
					{
						_faceIndices.back = data.interruptedSelectedIndexFrom;
						_faceIndices.right = data.interruptedSelectedIndexTo;
						_faceIndices.front = selectedIndexTo;
						_rotationStart = data.interruptedRotationY;
					}
					else
					{
						_faceIndices.back = selectedIndexFrom;
						_faceIndices.right = selectedIndexTo;
					}
					depth = contentWidth;
					break;
				}
				case CubePapervision3D.RIGHT :
				{
					if( wasInterrupted )
					{
						_faceIndices.back = data.interruptedSelectedIndexFrom;
						_faceIndices.left = data.interruptedSelectedIndexTo;
						_faceIndices.front = selectedIndexTo;
						_rotationStart = data.interruptedRotationY;
					}
					else
					{
						_faceIndices.back = selectedIndexFrom;
						_faceIndices.left = selectedIndexTo;
					}
					depth = contentWidth;
					break;
				}
			}
			
			if( data.interruptedSelectedIndexFrom == selectedIndexTo )
			{
				_rotationDiff = -_rotationStart
			}
			else if( data.interruptedSelectedIndexTo == selectedIndexTo )
			{
				_rotationDiff = 90 - _rotationStart
			}
			else
			{
				_rotationDiff = ( _rotationStart == 0 ) ? 90 : 180 - _rotationStart;
			}
			
			_zStart = depth / 2;
			_zDifference = ( viewStack.clipContent ) ? ( Math.sqrt( ( depth * depth ) * 2 ) - depth ) / 2 : 0;
			
			var matrialList:MaterialsList = new MaterialsList( { front: getBitmapMaterialAt( _faceIndices.front ), back: getBitmapMaterialAt( _faceIndices.back ), left: getBitmapMaterialAt( _faceIndices.left ), right: getBitmapMaterialAt( _faceIndices.right ), top: getBitmapMaterialAt( _faceIndices.top ), bottom: getBitmapMaterialAt( _faceIndices.bottom ) } );
			_cube = new Cube( matrialList, contentWidth, depth, contentHeight, segmentsS, segmentsT, segmentsH );
			_cube.name = "cube";
			_cube.z = _zStart;
			
			onTweenUpdate( 0 );
			scene.addChild( _cube );
			doubleRender();
			
			var changePercent:Number = Math.abs( _rotationDiff ) / 90;
			var targetDuration:Number = ( scaleDurationByChange ) ? duration *= changePercent : duration;
			tween = createTween( this, 0, 1, targetDuration );
        }
        
        
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var targetRotation:Number = _rotationStart + ( _rotationDiff * Number( value ) );
					
			switch( direction )
			{
				case CubePapervision3D.DOWN :
				case CubePapervision3D.UP :
				{
					_cube.rotationX = targetRotation;
//					_cube.z = _zStart + ( _zDifference * Math.sin( MathUtil.degreesToRadians( _cube.rotationX * 2 ) ) );
					break;
				}
				case CubePapervision3D.LEFT :
				case CubePapervision3D.RIGHT :
				{
					_cube.rotationY = targetRotation;
//					_cube.z = _zStart + ( _zDifference * Math.sin( MathUtil.degreesToRadians( _cube.rotationY * 2 ) ) );
					break;
				}
			}
		}
		
//		public function getScaleAtZ( z:Number ):Number
//		{
//			return ( camera.focus * camera.zoom ) / ( camera.focus + ( z - camera.z ) );
//		}		
//
//		public function getZFromScale( scale:Number ):Number
//		{
//			return ( camera.focus * camera.zoom ) / scale - camera.focus + camera.z;
//		}
	}
}

class FaceIndices
{
	
	public var back		: int = -1;
	public var front	: int = -1;
	public var left		: int = -1;
	public var right	: int = -1;
	public var top		: int = -1;
	public var bottom	: int = -1;
	
	public function FaceIndices()
	{
	}

}
	

