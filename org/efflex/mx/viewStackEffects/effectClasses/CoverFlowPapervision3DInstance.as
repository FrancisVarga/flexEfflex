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

package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.display.BitmapData;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.CoverFlowPapervision3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;

	public class CoverFlowPapervision3DInstance extends Papervision3DEffectInstance
	{
		
		public var angle				: Number;
		public var zOffset				: Number;
		public var offset				: Number;
		public var direction			: String;
		public var numSegmentsWidth		: uint;
		public var numSegmentsHeight	: uint;
		
		private var _container			: DisplayObject3D;
		
		public function CoverFlowPapervision3DInstance( target:UIComponent )
		{
			super( target );
		}
		
		override protected function setInturruptionParams():void
		{
			super.setInturruptionParams();
			
			data.interruptedX = _container.x;
			data.interruptedY = _container.y;
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
        	
        	var toX:Number;
        	var toY:Number;
        	
			switch( direction )
			{
				case CoverFlowPapervision3D.HORIZONTAL :
				{
					toX = -( contentWidth * selectedIndexTo );
					toY = display.y;
					break;
				}
				case CoverFlowPapervision3D.VERTICAL :
				{
					toX = display.x;
					toY = -( contentHeight * selectedIndexTo );
					break;
				}
			}
        	
    		createCoverFlow();
    		tween = createTween( this, new Array( _container.x, _container.y ), new Array( toX, toY ), duration );
        }
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_container.x = Number( value[ 0 ] );
			_container.y = Number( value[ 1 ] );
			
			updateView();
		}
		
		private function updateView():void
		{
			var percent:Number;
			var plane:DisplayObject3D;
			var numChildren:uint = viewStack.numChildren;
			for( var i:uint = 0; i < numChildren; i++ )
			{
				plane = _container.getChildByName( "plane" + i.toString() );
				if( plane )
				{
					switch( direction )
					{
						case CoverFlowPapervision3D.HORIZONTAL :
						{
							percent = normalizePercentOffset( ( _container.x + plane.x ) / contentWidth );
							plane.rotationY = angle * percent;
							break;
						}
						case CoverFlowPapervision3D.VERTICAL :
						{
							percent = normalizePercentOffset( ( _container.y + plane.y ) / contentHeight );
							plane.rotationX = angle * percent;
							break;
						}
					}
					
					plane.z = zOffset * Math.abs( percent );
				}
			}
		}
		
		private function normalizePercentOffset( value:Number ):Number
		{
			if( value < -1 ) return -1;
			if( value > 1 ) return 1;
			return value;
		}
		
		private function createCoverFlow():void
		{
			_container = new DisplayObject3D();
			_container.name = "container";
        	
			var plane:Plane;
			var numChildren:uint = viewStack.numChildren;
			var bitmapData:BitmapData;
			for( var i:uint = 0; i < numChildren; i++ )
			{
				bitmapData = bitmapDatum[ i ] as BitmapData;
				
				if( bitmapData )
				{
					plane = new Plane( getBitmapMaterialAt( i ), contentWidth, contentHeight, numSegmentsWidth, numSegmentsHeight );
					plane.name = "plane" + i.toString();

					switch( direction )
					{
						case CoverFlowPapervision3D.HORIZONTAL :
						{
							plane.x = contentWidth * i;
							_container.x = ( wasInterrupted ) ? data.interruptedX : -( contentWidth * selectedIndexFrom );
							break;
						}
						case CoverFlowPapervision3D.VERTICAL :
						{
							plane.y = contentHeight * i;
							_container.y = ( wasInterrupted ) ? data.interruptedY : -( contentHeight * selectedIndexFrom );
							break;
						}
					}
					_container.addChild( plane );
				}
			}
			
			scene.addChild( _container );
			updateView();
			doubleRender();
		}
	}
}