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
	import flash.display.BitmapData;
	
	import mx.core.UIComponent;
	
	import org.efflex.spark.viewStackEffects.CoverFlow;
	
	import spark.effects.SimpleMotionPath;

	public class CoverFlowInstance extends ViewStackAnimate3DInstance
	{
		
		public var scaleDurationByChange	: Boolean;
		public var angle					: Number;
		public var zOffset					: Number;
		public var offset					: Number;
		public var direction				: String;
		
		private var _planes					: Vector.<Bitmap>;
		
		private var _toFrom					: ToFrom;
		
		public function CoverFlowInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function setIndicesRequired():void
	    {
	    	var lowestIndex:int = Math.min( selectedIndexFrom, selectedIndexTo );
	    	var highestIndex:int = Math.max( selectedIndexFrom, selectedIndexTo );
	    	
	    	var indices:Array = new Array();
	    	for( var i:int = lowestIndex; i <= highestIndex; i++ )
	    	{
	    		addRequiredIndex( i );
	    	}
	    }
	    
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();

        	var change:Number;
			var distance:Number;
			
        	createCoverFlow();
        	
			switch( direction )
			{
				case CoverFlow.HORIZONTAL :
				{
					change = contentWidth + offset;
					_toFrom = new ToFrom( display.x, -( change * selectedIndexTo ), display.y, display.y );
					distance = Math.abs( _toFrom.diffX );
					break;
				}
				case CoverFlow.VERTICAL :
				{
					change = contentHeight + offset;
					_toFrom = new ToFrom( display.x, display.x, display.y, -( change * selectedIndexTo ) );
					distance = Math.abs( _toFrom.diffY );
					break;
				}
			}
        	
    		var targetDuration:Number = ( scaleDurationByChange ) ? duration * ( distance / change ) : duration;
    		
    		motionPaths =  [ new SimpleMotionPath( null, 0, 1, targetDuration ) ];
        }
        
		override protected function setValue( property:String, value:Object ):void
	    {
			var v:Number = Number( value );
			display.x = _toFrom.fromX + ( _toFrom.diffX * v );
			display.y = _toFrom.fromY + ( _toFrom.diffY * v );
			updateView();
	    }
		
		private function updateView():void
		{
			var largestZ:int = zOffset;
			var largestZIndex:int = -1;
			
			var i:uint;
			var percent:Number;
			var plane:Bitmap;
			var numChildren:uint = _planes.length;
			for( i = 0; i < numChildren; i++ )
			{
				plane = _planes[ i ];
				switch( direction )
				{
					case CoverFlow.HORIZONTAL :
					{
						percent = normalizePercentOffset( ( display.x + plane.x ) / ( contentWidth + offset ) );
						plane.rotationY = angle * percent;
						break;
					}
					case CoverFlow.VERTICAL :
					{
						percent = normalizePercentOffset( ( display.y + plane.y ) / ( contentHeight + offset ) );
						plane.rotationX = angle * percent;
						break;
					}
				}
				plane.z = zOffset * Math.abs( percent );
				if( plane.z <= largestZ )
				{
					largestZ = plane.z;
					largestZIndex = i;
				}
			}

			var planeFound:Boolean = false;
			for( i = 0; i < numChildren; i++ )
			{
				plane = Bitmap( _planes[ i ] );
				if( i < largestZIndex )
				{
					display.setChildIndex( plane, i );
				}
				else if( i > largestZIndex )
				{
					display.setChildIndex( plane, 0 )
				}
				else
				{
					display.setChildIndex( plane, numChildren - 1 );
				}
			}
		}
		
		private function normalizePercentOffset( value:Number ):Number
		{
			if( value < -1 ) return -1;
			if( value > 1 ) return 1;
			return value;
		}
		
		override public function finishEffect():void
		{
			_planes = null;
			
			super.finishEffect();
		}
		
		private function createCoverFlow():void
		{
			_planes = new Vector.<Bitmap>();
			
			var plane:Bitmap;
			var numChildren:uint = viewStack.numChildren;
			var bitmapData:BitmapData;
			for( var i:uint = 0; i < numChildren; i++ )
			{
				bitmapData = getBitmapDataAtIndex( i );
				
				if( bitmapData )
				{
					plane = new Bitmap( bitmapData );
					_planes.push( plane );
					switch( direction )
					{
						case CoverFlow.HORIZONTAL :
						{
							plane.x = ( contentWidth + offset )* i;
							if( !wasInterrupted ) display.x = -( ( contentWidth + offset ) * selectedIndexFrom );
							break;
						}
						case CoverFlow.VERTICAL :
						{
							plane.y = ( contentHeight + offset ) * i;
							if( !wasInterrupted ) display.y = -( ( contentHeight + offset ) * selectedIndexFrom );
							break;
						}
					}
					display.addChild( plane );
				}
			}
			
			updateView();
		}
	}
}


class ToFrom
{
	
	private var _fromX	: Number;
	private var _toX	: Number;
	private var _diffX	: Number;
	
	private var _fromY	: Number;
	private var _toY	: Number;
	private var _diffY	: Number;
	
	public function ToFrom( fromX:Number, toX:Number, fromY:Number, toY:Number )
	{
		_fromX = fromX;
		_toX = toX;
		_diffX = _toX - _fromX;
		
		_fromY = fromY;
		_toY = toY;
		_diffY = _toY - _fromY;
	}
	
	public function get fromX():Number
	{
		return _fromX;
	}

	public function get toX():Number
	{
		return _toX;
	}
	
	public function get diffX():Number
	{
		return _diffX;
	}

	public function get fromY():Number
	{
		return _fromY;
	}
	
	public function get toY():Number
	{
		return _toY;
	}
	
	public function get diffY():Number
	{
		return _diffY;
	}
	
}