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
	
	import org.efflex.mx.viewStackEffects.FlipPapervision3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.primitives.Plane;
	
	import ws.tink.utils.MathUtil;

	public class FlipPapervision3DInstance extends Papervision3DEffectInstance
	{
		
		public var scaleDurationByChange	: Boolean = true;
		public var direction				: String;
		public var numSegmentsWidth			: uint;
		public var numSegmentsHeight		: uint;
		
		private var _plane					: Plane;
		private var _showingSelectedIndexTo	: Boolean;
		
		private var _rotationStart			: Number;
		private var _rotationDiff			: Number;
		
		private var _materialTo				: BitmapMaterial;
		
		public function FlipPapervision3DInstance(target:UIComponent)
		{
			super( target );
		}
		
		override protected function setInturruptionParams():void
		{
			super.setInturruptionParams();

			var index:uint;
			if( _plane.material == _materialTo )
			{
				index = selectedIndexTo;
			}
			else
			{
				index = ( wasInterrupted ) ? InterruptedData( data.interruptedData ).index : selectedIndexFrom;
			}
			
			data.interruptedData = new InterruptedData( index, _plane.rotationX, _plane.rotationY );
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
        	
        	var indexFrom:int = ( wasInterrupted ) ? InterruptedData( data.interruptedData ).index : selectedIndexFrom;
        	
			_plane = new Plane( getBitmapMaterialAt( indexFrom ), contentWidth, contentHeight, numSegmentsWidth, numSegmentsHeight );
			
			_materialTo = getBitmapMaterialAt( selectedIndexTo );
			
    		switch( direction )
			{
				case FlipPapervision3D.UP :
				case FlipPapervision3D.DOWN :
				{
					_rotationStart = ( wasInterrupted ) ? InterruptedData( data.interruptedData ).rotationX : 0;
					_plane.rotationX = _rotationStart;
					if( viewStack.clipContent ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationX ) ) * ( contentHeight / 2 ) );
					
					_rotationDiff = ( direction == FlipPapervision3D.DOWN ) ? 180 - _rotationStart : -180 - _rotationStart;
					break;
				}
				case FlipPapervision3D.LEFT :
				case FlipPapervision3D.RIGHT :
				{
					_rotationStart = ( wasInterrupted ) ? InterruptedData( data.interruptedData ).rotationY : 0;
					_plane.rotationY = _rotationStart;
					if( viewStack.clipContent ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationY ) ) * ( contentWidth / 2 ) );
					
					_rotationDiff = ( direction == FlipPapervision3D.LEFT ) ? 180 - _rotationStart : -180 - _rotationStart;
					break;
				}
			}
			
			if( wasInterrupted ) if( InterruptedData( data.interruptedData ).index == selectedIndexTo ) _rotationDiff = -_rotationStart;
			
			var changePercent:Number = Math.abs( _rotationDiff ) / 180;
			var targetDuration:Number = ( scaleDurationByChange ) ? duration *= changePercent : duration;
        	
        	scene.addChild( _plane );
        	
        	doubleRender();

        	tween = createTween( this, 0, 1, targetDuration );
        }
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			var v:Number = Number( value );
					
			var targetRotation:Number = _rotationStart + ( _rotationDiff * v );
			
			if( targetRotation < -90 )
			{
				_rotationStart += 180;
				targetRotation += 180;
				_plane.material = _materialTo;
			}
			if( targetRotation > 90 )
			{
				_rotationStart -= 180;
				targetRotation -= 180;
				_plane.material = _materialTo;
			}
			
			switch( direction )
			{
				case FlipPapervision3D.DOWN :
				case FlipPapervision3D.UP :
				{
					_plane.rotationX = targetRotation
					if( viewStack.clipContent ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationX ) ) * ( contentHeight / 2 ) );
					break;
				}
				case FlipPapervision3D.LEFT :
				case FlipPapervision3D.RIGHT :
				{
					_plane.rotationY = targetRotation;
					if( viewStack.clipContent ) _plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( _plane.rotationY ) ) * ( contentWidth / 2 ) );
					break;
				}
			}
		}

	}
}

internal class InterruptedData
{
	
	private var _index		: uint;
	private var _rotationX	: Number;
	private var _rotationY	: Number;
	
	public function InterruptedData( index:uint, rotationX:Number, rotationY:Number )
	{
		_index = index;
		_rotationX = rotationX;
		_rotationY = rotationY;
	}
	
	public function get index():uint
	{
		return _index;
	}
	
	public function get rotationX():Number
	{
		return _rotationX;
	}
	
	public function get rotationY():Number
	{
		return _rotationY;
	}
	
}