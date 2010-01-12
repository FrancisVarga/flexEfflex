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
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import org.efflex.spark.viewStackEffects.Cube;
	
	import spark.effects.SimpleMotionPath;

	public class CubeInstance extends ViewStackAnimate3DInstance
	{
		
		public var direction				: String;
		public var scaleDurationByChange	: Boolean;
		
		private var _cubeContainer		: Sprite;
		
		private var _cubeView		: CubeView;
		
		private var _property			: String;
		private var _value				: Number;
		private var _direction			: String;
		private var _frameDelayComplete	: Boolean;
		
		
		
		
		public function CubeInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function setInturruptionParams():void
		{
			super.setInturruptionParams();
			
			var cubeRotation:Number;
			switch( _direction )
			{
				case Cube.UP :
				{
					cubeRotation = Math.abs( _cubeView.rotationX );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _cubeView.bottomIndex : _cubeView.frontIndex;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _cubeView.backIndex : _cubeView.bottomIndex;
					break;
				}
				case Cube.DOWN :
				{
					cubeRotation = Math.abs( _cubeView.rotationX );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _cubeView.topIndex : _cubeView.frontIndex;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _cubeView.backIndex : _cubeView.topIndex;
					break;
				}
				case Cube.LEFT :
				{
					cubeRotation = Math.abs( _cubeView.rotationY );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _cubeView.rightIndex : _cubeView.frontIndex;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _cubeView.backIndex : _cubeView.rightIndex;
					break;
				}
				case Cube.RIGHT :
				{
					cubeRotation = Math.abs( _cubeView.rotationY );
					data.interruptedSelectedIndexFrom = ( cubeRotation > 90 ) ? _cubeView.leftIndex : _cubeView.frontIndex;
					data.interruptedSelectedIndexTo = ( cubeRotation > 90 ) ? _cubeView.backIndex : _cubeView.leftIndex;
					break;
				}
			}
			
			data.interruptedRotationX = _cubeView.rotationX % 90;
			data.interruptedRotationY = _cubeView.rotationY % 90;
			data.interruptedScale = _cubeContainer.scaleX;
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
			
			
			
			switch( direction )
			{
//				case Cube.VERTICAL :
//				{
//					if( wasInterrupted )
//					{
//						_direction = ( selectedIndexTo > data.interruptedSelectedIndexFrom ) ? Cube.UP : Cube.DOWN;
//					}
//					else
//					{
//						_direction = ( selectedIndexTo > selectedIndexFrom ) ? Cube.UP : Cube.DOWN;
//					}
//					break;
//				}
//				case Cube.HORIZONTAL :
//				{
//					if( wasInterrupted )
//					{
//						_direction = ( selectedIndexTo > data.interruptedSelectedIndexFrom ) ? Cube.LEFT : Cube.RIGHT;
//					}
//					else
//					{
//						_direction = ( selectedIndexTo > selectedIndexFrom ) ? Cube.LEFT : Cube.RIGHT;
//					}
//					break;
//				}
				case Cube.DOWN :
				case Cube.UP :
				case Cube.LEFT :
				case Cube.RIGHT :
				{
					_direction = direction;
					break;
				}
				default :
				{
					throw new Error( "Invalid direction" );
				}
				
			}
			
			var valueFrom:Number = 0;
			var valueTo:Number;
			var depth:Number;
			
			_cubeView = new CubeView( this, contentWidth, contentHeight, _direction );
			
			switch( _direction )
			{
				case Cube.DOWN :
				{
					_property = "rotationX";
					if( wasInterrupted )
					{
						_cubeView.frontIndex = data.interruptedSelectedIndexFrom;
						_cubeView.topIndex = data.interruptedSelectedIndexTo;
						_cubeView.backIndex = selectedIndexTo;
						valueFrom = data.interruptedRotationX;
					}
					else
					{
						_cubeView.frontIndex = selectedIndexFrom;
						_cubeView.topIndex = selectedIndexTo;
					}
					depth = contentHeight;
					break;
				}
				case Cube.UP :
				{
					_property = "rotationX";
					if( wasInterrupted )
					{
						_cubeView.frontIndex = data.interruptedSelectedIndexFrom
						_cubeView.bottomIndex = data.interruptedSelectedIndexTo;;
						_cubeView.backIndex = selectedIndexTo
						valueFrom = data.interruptedRotationX;
					}
					else
					{
						_cubeView.frontIndex = selectedIndexFrom;
						_cubeView.bottomIndex = selectedIndexTo;
					}
					depth = contentHeight;
					break;
				}
				case Cube.LEFT :
				{
					_property = "rotationY";
					if( wasInterrupted )
					{
						_cubeView.frontIndex = data.interruptedSelectedIndexFrom;
						_cubeView.rightIndex = data.interruptedSelectedIndexTo;
						_cubeView.backIndex = selectedIndexTo;
						valueFrom = data.interruptedRotationY;
					}
					else
					{
						_cubeView.frontIndex = selectedIndexFrom;
						_cubeView.rightIndex = selectedIndexTo;
					}
					depth = contentWidth;
					break;
				}
				case Cube.RIGHT :
				{
					_property = "rotationY";
					if( wasInterrupted )
					{
						_cubeView.frontIndex = data.interruptedSelectedIndexFrom;
						_cubeView.leftIndex = data.interruptedSelectedIndexTo;
						_cubeView.backIndex = selectedIndexTo;
						valueFrom = data.interruptedRotationY;
					}
					else
					{
						_cubeView.frontIndex = selectedIndexFrom;
						_cubeView.leftIndex = selectedIndexTo;
					}
					depth = contentWidth;
					break;
				}
			}
        	
        	if( data.interruptedSelectedIndexFrom == selectedIndexTo )
			{
				valueTo = 0;
			}
			else if( data.interruptedSelectedIndexTo == selectedIndexTo )
			{
				valueTo = ( _direction == Cube.LEFT || _direction == Cube.DOWN ) ? 90 : -90;
			}
			else
			{
				valueTo = ( valueFrom == 0 ) ? ( _direction == Cube.LEFT || _direction == Cube.DOWN ) ? 90 : -90 : ( _direction == Cube.LEFT || _direction == Cube.DOWN ) ? 180 : -180;
			}

			_cubeView.z = depth / 2;
			
			_cubeContainer = new Sprite();
			_cubeContainer.x = contentWidth / 2;
			_cubeContainer.y = contentHeight / 2;
			
			if( wasInterrupted )
			{
				_cubeView.rotationX = data.interruptedRotationX;
				_cubeView.rotationY = data.interruptedRotationY;
				_cubeContainer.scaleX = _cubeContainer.scaleY = data.interruptedScale;
			}
			
			_cubeContainer.addChild( _cubeView );
			display.addChild( _cubeContainer );
			_cubeView.sortFaces();
    		duration = ( scaleDurationByChange ) ? duration * ( Math.abs( valueTo - valueFrom ) / 90 ) : duration;
    		motionPaths =  [ new SimpleMotionPath( _property, valueFrom, valueTo, duration ) ];
    		
    		_cubeContainer.addEventListener( Event.ENTER_FRAME, onEnterFrame, false, 0, true );
        }
        
        override public function finishEffect():void
		{
			super.finishEffect();
			if( _cubeContainer ) _cubeContainer.removeEventListener( Event.ENTER_FRAME, onEnterFrame, false );
		}
		
		private function onEnterFrame( event:Event ):void
		{
			_frameDelayComplete = true;
			if( _cubeContainer ) _cubeContainer.removeEventListener( Event.ENTER_FRAME, onEnterFrame, false );
		}
		
		override protected function setValue( property:String, value:Object ):void
	    {
	    	if( !_frameDelayComplete ) return;
	    	
			_value = Number( value );

			_cubeView[ property ] = _value;
			
			if( viewStack.clipContent )
			{
				var bounds:Rectangle = _cubeView.getBounds( _cubeContainer );
				bounds.x += _cubeContainer.x;
				bounds.y += _cubeContainer.y;
				
				var largestOverlap:Number;
				var overlapStart:Number;
				var overlapEnd:Number;
				
				overlapStart = -bounds.x;
				overlapEnd = ( bounds.x + bounds.width ) - contentWidth;
				largestOverlap = ( overlapStart > overlapEnd ) ? overlapStart : overlapEnd;
				var minScaleX:Number = contentWidth / ( contentWidth + ( largestOverlap * 2 ) );

				overlapStart = -bounds.y;
				overlapEnd = ( bounds.y + bounds.height ) - contentHeight;
				largestOverlap = ( overlapStart > overlapEnd ) ? overlapStart : overlapEnd;
				var minScaleY:Number = contentHeight / ( contentHeight + ( largestOverlap * 2 ) );

				_cubeContainer.scaleX = _cubeContainer.scaleY = ( minScaleX < minScaleY ) ? minScaleX : minScaleY;
			}
			else
			{
//				_cubeContainer.scaleX = _cubeContainer.scaleY = 1;
			}
			
			_cubeView.sortFaces();
	    }
	    
	    private function sort( a:Bitmap, b:Bitmap ):Number
	    {
		    var aValue:Number = Math.abs( a[ _property ] + _value );
		    var bvalue:Number = Math.abs( b[ _property ] + _value );
		
		    if( aValue < bvalue )
		    {
		        return 1;
		    }
		    else if( aValue > bvalue )
		    {
		        return -1;
		    }
		    else
		    {
		        return 0;
		    }
		}
		
	}	
	
}


import flash.display.Bitmap;
import flash.display.BitmapData;
import org.efflex.spark.viewStackEffects.supportClasses.CubeInstance;
import org.efflex.spark.viewStackEffects.Cube;
import flash.display.Sprite;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;


class CubeView extends Sprite
{
	
	private var _backIndex		: int = -1;
	private var _frontIndex		: int = -1;
	private var _leftIndex		: int = -1;
	private var _rightIndex		: int = -1;
	private var _topIndex		: int = -1;
	private var _bottomIndex	: int = -1;
	
	private var _backBitmap		: Bitmap;
	private var _frontBitmap	: Bitmap;
	private var _leftBitmap		: Bitmap;
	private var _rightBitmap	: Bitmap;
	private var _topBitmap		: Bitmap;
	private var _bottomBitmap	: Bitmap;
	
	private var _effectInstance	: CubeInstance;
	private var _contentWidth	: Number;
	private var _contentHeight	: Number;
	private var _direction		: String;
	private var _depth			: Number;
	
	private var _faces			: Vector.<Face>;
	
	
	public function CubeView( effectInstance:CubeInstance, contentWidth:Number, contentHeight:Number, direction:String )
	{
		_effectInstance = effectInstance;
		_contentWidth = contentWidth;
		_contentHeight = contentHeight
		_direction = direction;
		_depth = ( _direction == Cube.UP || _direction == Cube.DOWN ) ? contentHeight : contentWidth;
		
		_faces = new Vector.<Face>();
	}
	
	public function get backIndex():int
	{
		return _backIndex;
	}
	public function set backIndex( value:int ):void
	{
		var face:Sprite = new Sprite();
		face.z = _depth / 2;
		
		_backIndex = value;
		_backBitmap = new Bitmap( _effectInstance.getBitmapDataAtIndex( _backIndex ) );
		_backBitmap.x = -_contentWidth / 2;
		_backBitmap.y = -_contentHeight / 2;
		switch( _direction )
		{
			case Cube.DOWN	:
			{
				face.rotationX = -180;
				break;
			}
			case Cube.UP	:
			{
				face.rotationX = 180;
				break;
			}
			case Cube.LEFT	:
			{
				face.rotationY = -180;
				break;
			}
			case Cube.RIGHT	:
			{
				face.rotationY = 180;
				break;
			}
		}
		
		face.addChild( _backBitmap );
		addFace( face );
	}
	
	public function get frontIndex():int
	{
		return _frontIndex;
	}
	public function set frontIndex( value:int ):void
	{
		var face:Sprite = new Sprite();
		face.z = -_depth / 2;
		
		_frontIndex = value;
		
		_frontBitmap = new Bitmap( _effectInstance.getBitmapDataAtIndex( _frontIndex ) );
		_frontBitmap.x = -_contentWidth / 2;
		_frontBitmap.y = -_contentHeight / 2;
		
		face.addChild( _frontBitmap );
		addFace( face );
	}
	
	
	
	public function get leftIndex():int
	{
		return _leftIndex;
	}
	public function set leftIndex( value:int ):void
	{
		var face:Sprite = new Sprite();
		face.x = -_depth / 2;
		face.rotationY = 90;
		
		_leftIndex = value;
		_leftBitmap = new Bitmap( _effectInstance.getBitmapDataAtIndex( _leftIndex ) );
		_leftBitmap.x = -_contentWidth / 2;
		_leftBitmap.y = -_contentHeight / 2;
		
		face.addChild( _leftBitmap );
		addFace( face );
	}
	
	public function get rightIndex():int
	{
		return _rightIndex;
	}
	public function set rightIndex( value:int ):void
	{
		var face:Sprite = new Sprite();
		face.x = _depth / 2;
		face.rotationY = -90;
		
		_rightIndex = value;
		_rightBitmap = new Bitmap( _effectInstance.getBitmapDataAtIndex( _rightIndex ) );
		_rightBitmap.x = -_contentWidth / 2;
		_rightBitmap.y = -_contentHeight / 2;
		
		face.addChild( _rightBitmap );
		addFace( face );
	}
	
	public function get topIndex():int
	{
		return _topIndex;
	}
	public function set topIndex( value:int ):void
	{
		var face:Sprite = new Sprite();
		face.y = -_depth / 2;
		face.rotationX = -90;
		
		_topIndex = value;
		_topBitmap = new Bitmap( _effectInstance.getBitmapDataAtIndex( _topIndex ) );
		_topBitmap.x = -_contentWidth / 2;
		_topBitmap.y = -_contentHeight / 2;
		
		face.addChild( _topBitmap );
		addFace( face );
	}
	
	public function get bottomIndex():int
	{
		return _bottomIndex;
	}
	public function set bottomIndex( value:int ):void
	{
		var face:Sprite = new Sprite();
		face.y = _depth / 2;
		face.rotationX = 90;
		
		_bottomIndex = value;
		_bottomBitmap = new Bitmap( _effectInstance.getBitmapDataAtIndex( _bottomIndex ) );
		_bottomBitmap.x = -_contentWidth / 2;
		_bottomBitmap.y = -_contentHeight / 2;

		face.addChild( _bottomBitmap );
		addFace( face );
	}
	
	
	public function sortFaces():void
	{
		var distArray:Array=[];
		var dist:Number;
		var i:int;
		var curMatrix:Matrix3D;
		var curMid:Vector3D;
		curMatrix=transform.matrix3D.clone();
		
		var face:Face;
		var numFaces:int = _faces.length;
		
		for( i = 0; i < numFaces; i++ )
		{
			face = _faces[ i ];
			
			curMid = curMatrix.transformVector( face.vector3D );
			face.distance = Math.sqrt( Math.pow( curMid.x, 2 ) + Math.pow( curMid.y, 2 ) + Math.pow( ( -curMid.z - _effectInstance.display.parent.transform.perspectiveProjection.focalLength ), 2 ) );
		}
		
		_faces.sort( sortByZ );
		
		while( numChildren > 0 )
		{
			removeChildAt( 0 );
		}
		for( i = 0; i < numFaces; i++ )
		{
			addChild( _faces[ i ].view );
		}
	}
		 
	private function sortByZ( a:Face, b:Face ):Number
	{
		if( a.distance > b.distance )
		{
			return -1;
		}
		else if( a.distance < b.distance )
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	
	
	private function addFace( face:Sprite ):void
	{
		addChild( face );
		_faces.push( new Face( face ) );
	}

}


class Face
{
	public var distance	: Number;
	
	private var _vector3D	: Vector3D;
	private var _view		: Sprite;
	
	public function Face( v:Sprite )
	{
		_view = v;
		_vector3D = new Vector3D( v.x, v.y, v.z );
	}
	
	public function get vector3D():Vector3D
	{
		return _vector3D;
	}
	
	public function get view():Sprite
	{
		return _view;
	}
}