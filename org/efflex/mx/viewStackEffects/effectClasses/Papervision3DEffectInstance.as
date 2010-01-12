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
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.papervision3d.Papervision3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;

	public class Papervision3DEffectInstance extends ViewStackTweenEffectInstance
	{
		
		public var zoom						: Number;
		public var focus					: Number;
		
		private var _scene					: Scene3D;
		protected var _viewport				: Viewport3D;
		private var _renderer				: BasicRenderEngine;
		private var _camera					: Camera3D;
		private var _bitmapMaterials		: Array;
		
		public function Papervision3DEffectInstance(target:UIComponent)
		{
			super( target );
		}
		
		public function get camera():Camera3D
		{
			return _camera;
		}
		
		public function get scene():Scene3D
		{
			return _scene;
		}
		
		public function setSize( w:Number, h:Number ):void
		{
			_viewport.width = w;
			_viewport.height = h;
			
			_viewport.x = -( ( w - contentWidth ) / 2 );
			_viewport.y = -( ( h - contentHeight ) / 2 );
		}
		
		final public function get bitmapMaterials():Array
		{
			return data.bitmapMaterials as Array;
		}
		
		public function getBitmapMaterialAt( index:uint ):BitmapMaterial
		{
			return BitmapMaterial( data.bitmapMaterials[ index ] );
		}
		
		public function get interruptedBitmapMaterial( ):BitmapMaterial
		{
			return data.interruptedBitmapMaterial;
		}
		
		override public function initEffect( event:Event ):void
	    {
	    	super.initEffect( event );
	    	
	    	Papervision3D.VERBOSE = false;
	    	
	    	_scene = data.scene;
			_viewport = data.viewport;
			_renderer = data.renderer;
			_camera = data.camera;
			_bitmapMaterials = data.bitmapMaterials;
	    }
	    
		override protected function createContainers():void
		{
			super.createContainers();
			
			_scene = new Scene3D();
			_viewport = new Viewport3D( contentWidth, contentHeight, false, false, true, true );
			_renderer = new BasicRenderEngine();
			
			_camera = new Camera3D();
			_camera.z = -( ( _camera.zoom - 1 ) * _camera.focus );
			
			_bitmapMaterials = new Array( viewStack.numChildren );
			
			display.addChild( _viewport );
			
			data.scene = _scene;
			data.viewport = _viewport;
			data.renderer = _renderer;
			data.camera = _camera;
			data.bitmapMaterials = _bitmapMaterials;
		}
		
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			render();
		}
		
		protected function doubleRender():void
		{
			render();
			render();
		}
		
		protected function render():void
		{
			_renderer.renderScene( _scene, _camera, _viewport, true );
		}
		
		override protected function createBitmapDatum():void
		{
			super.createBitmapDatum();
			
			createBitmapMaterials();
		}
		
		protected function createBitmapMaterials():void
		{
			var child:UIComponent;
			var bitmapData:BitmapData;
			var bitmapMaterial:BitmapMaterial;
			var numBitmapDatum:uint = bitmapDatum.length;
			for( var i:uint; i < numBitmapDatum; i++ )
			{
				bitmapData = bitmapDatum[ i ] as BitmapData;
				bitmapMaterial = _bitmapMaterials[ i ] as BitmapMaterial;
				if( !bitmapMaterial && bitmapData ) _bitmapMaterials[ i ] = new BitmapMaterial( bitmapData );
			}
		}
		
		override protected function takeSnapShot():void
		{
			super.takeSnapShot();
			
			createInterruptedBitmapMaterial();
		}
		
		protected function createInterruptedBitmapMaterial():void
		{
			data.interruptedBitmapMaterial = new BitmapMaterial( snapShot );
		}
		
		override public function finishEffect():void
		{
			super.finishEffect();
			
			_scene = null;
			_viewport = null;
			_renderer = null;
			_camera = null;
		}
		
		override protected function removeChildren():void
        {
        	for( var name:String in scene.children )
        	{
        		scene.removeChildByName( name )
        	}
        }
        
	}
}