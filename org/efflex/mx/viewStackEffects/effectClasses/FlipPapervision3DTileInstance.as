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
	
	import org.efflex.mx.viewStackEffects.FlipPapervision3DTile;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.primitives.Plane;
	
	import ws.tink.utils.MathUtil;

	public class FlipPapervision3DTileInstance extends Papervision3DTileEffectInstance
	{
		
		public var scaleDurationByChange	: Boolean = true;
		public var direction				: String;
		public var numSegmentsWidth			: uint;
		public var numSegmentsHeight		: uint;
		
		private var _planes					: Array;
		private var _showingSelectedIndexTo	: Boolean;
		
		private var _rotationStarts			: Array;
		private var _rotationDiffs			: Array;
		
		private var _materialsTo				: Array;
		
		
		public function FlipPapervision3DTileInstance( target:UIComponent )
		{
			super( target );
		}
		
		
		override protected function setInturruptionParams():void
		{
			super.setInturruptionParams();

			var plane:PlaneTile;
			var interruptedData:Array = new Array();
			var interruptedDataCols:Array;
			
			var index:int;
			for( var r:uint = 0; r < numRows; r++ )
			{
				interruptedDataCols = new Array();
				for( var c:uint = 0; c < numColumns; c++ )
				{
					plane = PlaneTile( _planes[ r ][ c ] );
					if( plane.material == _materialsTo[ r ][ c ] )
					{
						index = selectedIndexTo;
					}
					else
					{
						index = ( wasInterrupted ) ? InterruptedData( data.interruptedData[ r ][ c ] ).index : selectedIndexFrom;
					}
					interruptedDataCols.push( new InterruptedData( index, plane.rotationX, plane.rotationY ) );
				}
				
				interruptedData.push( interruptedDataCols );
			}
			data.interruptedData = interruptedData;
		}
		
		override protected function createTileEffect():void
        {
        	super.createTileEffect();
        	
        	var indexFrom:int;
        	
        	_materialsTo = new Array();
        	_planes = new Array();
        	
        	var r:uint;
			var c:uint;
        	var planes:Array;
        	var materialsTo:Array;
        	var plane:PlaneTile;
        	
			_rotationStarts = new Array();
			_rotationDiffs = new Array();
			
    		switch( direction )
			{
				case FlipPapervision3DTile.UP :
				case FlipPapervision3DTile.DOWN :
				{
					for( r = 0; r < numRows; r++ )
					{
						planes = new Array();
						materialsTo = new Array();
						for( c = 0; c < numColumns; c++ )
						{
							indexFrom = ( wasInterrupted ) ? InterruptedData( data.interruptedData[ r ][ c ] ).index : selectedIndexFrom;
							
							
							plane = new PlaneTile( new ColorMaterial( 0xFFFF000 ), tileWidth, tileHeight, numSegmentsWidth, numSegmentsHeight );
							plane.rotationStart = ( wasInterrupted ) ? InterruptedData( data.interruptedData[ r ][ c ] ).rotationX : 0;
							plane.rotationDiff = ( direction == FlipPapervision3DTile.DOWN ) ? 180 - plane.rotationStart : -180 - plane.rotationStart;
							if( indexFrom == selectedIndexTo ) plane.rotationDiff = -plane.rotationStart;
							
							plane.x = ( tileWidth * c ) - ( ( contentWidth - tileWidth ) / 2 );
							plane.y = -( ( tileHeight * r ) - ( ( contentHeight - tileHeight ) / 2 ) );
							plane.rotationX = plane.rotationStart;
							if( viewStack.clipContent ) plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( plane.rotationX ) ) * ( tileHeight / 2 ) );
							
							planes.push( plane );
							materialsTo.push( getBitmapMaterialTileAt( selectedIndexTo, r, c ) );
							
							scene.addChild( plane );
						}
						
						_planes.push( planes );
						_materialsTo.push( materialsTo );
					}
					break;
				}
				case FlipPapervision3DTile.LEFT :
				case FlipPapervision3DTile.RIGHT :
				{
					for( r = 0; r < numRows; r++ )
					{
						planes = new Array();
						materialsTo = new Array();
						for( c = 0; c < numColumns; c++ )
						{
							indexFrom = ( wasInterrupted ) ? InterruptedData( data.interruptedData[ r ][ c ] ).index : selectedIndexFrom;
							
							plane = new PlaneTile( getBitmapMaterialTileAt( indexFrom, r, c ), tileWidth, tileHeight, numSegmentsWidth, numSegmentsHeight );
							plane.rotationStart = ( wasInterrupted ) ? InterruptedData( data.interruptedData[ r ][ c ] ).rotationY : 0;
							plane.rotationDiff = ( direction == FlipPapervision3DTile.LEFT ) ? 180 - plane.rotationStart : -180 - plane.rotationStart;
							if( indexFrom == selectedIndexTo ) plane.rotationDiff = -plane.rotationStart;
							
							plane.x = ( tileWidth * c ) - ( ( contentWidth - tileWidth ) / 2 );
							plane.y = -( ( tileHeight * r ) - ( ( contentHeight - tileHeight ) / 2 ) );
							plane.rotationY = plane.rotationStart;
							if( viewStack.clipContent ) plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( plane.rotationY ) ) * ( tileWidth / 2 ) );
							
							planes.push( plane );
							materialsTo.push( getBitmapMaterialTileAt( selectedIndexTo, r, c ) );
							
							scene.addChild( plane );
						}
						
						_planes.push( planes );
						_materialsTo.push( materialsTo );
					}
					break;
				}
			}
        	doubleRender();
        }
        
        override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );

			var targetRotation:Number
			var r:int;
			var c:int;
			var plane:PlaneTile;
			switch( direction )
			{
				case FlipPapervision3DTile.DOWN :
				case FlipPapervision3DTile.UP :
				{
					for( r = 0; r < numRows; r++ )
					{
						for( c = 0; c < numColumns; c++ )
						{
							plane = PlaneTile( _planes[ r ][ c ] );
							
							targetRotation = plane.rotationStart + ( plane.rotationDiff * getTileValueAt( r, c ) );
							
							if( targetRotation < -90 )
							{
								plane.rotationStart += 180;
								targetRotation += 180;
								plane.material = BitmapMaterial( _materialsTo[ r ][ c ] );
							}
							if( targetRotation > 90 )
							{
								plane.rotationStart -= 180;
								targetRotation -= 180;
								plane.material = BitmapMaterial( _materialsTo[ r ][ c ] );
							}

							plane.rotationX = targetRotation;
							if( viewStack.clipContent ) plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( plane.rotationX ) ) * ( tileHeight / 2 ) );
						}
					}
					
					break;
				}
				case FlipPapervision3DTile.LEFT :
				case FlipPapervision3DTile.RIGHT :
				{
					for( r = 0; r < numRows; r++ )
					{
						for( c = 0; c < numColumns; c++ )
						{
							plane = PlaneTile( _planes[ r ][ c ] );
							
							
							targetRotation = plane.rotationStart + ( plane.rotationDiff * getTileValueAt( r, c ) );
							
							if( targetRotation < -90 )
							{
								plane.rotationStart += 180;
								targetRotation += 180;
								plane.material = BitmapMaterial( _materialsTo[ r ][ c ] );
							}
							if( targetRotation > 90 )
							{
								plane.rotationStart -= 180;
								targetRotation -= 180;
								plane.material = BitmapMaterial( _materialsTo[ r ][ c ] );
							}
							
							plane.rotationY = targetRotation;
							
							if( viewStack.clipContent ) plane.z = Math.abs( Math.sin( MathUtil.degreesToRadians( plane.rotationY ) ) * ( tileWidth / 2 ) );
						}
					}
					break;
				}
			}
		}

	}
}

import org.papervision3d.objects.primitives.Plane;
import org.papervision3d.core.proto.MaterialObject3D;


internal class PlaneTile extends Plane
{
	public var rotationStart	: Number = 0;
	public var rotationDiff	: Number = 0;
	
	public function PlaneTile( material:MaterialObject3D, width:Number, height:Number, segmentsW:Number, segmentsH:Number )
	{
		super( material, width, height, segmentsW, segmentsH );
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