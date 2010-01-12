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
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.Container;
	import mx.core.UIComponent;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	

	public class Papervision3DInstance extends BitmapInstance
	{
		
		public var zoom						: Number;
		public var focus					: Number;
		public var constrain				: Boolean;
		
		private var _scene					: Scene3D;
		private var _viewport				: Viewport3D;
		private var _renderer				: BasicRenderEngine;
		private var _camera					: Camera3D;
		
		protected var _bitmapMaterial		: BitmapMaterial;
		
		
		public function Papervision3DInstance( target:UIComponent )
		{
			super( target );
		}
		
		public function getWidthAtZ( w:Number, z:Number ):Number
		{
			return ( ( _camera.zoom - 1 ) * _camera.focus ) - Math.abs( _camera.z + z );
		}
		
		public function addChild3D( child:DisplayObject3D ):void
		{
			_scene.addChild( child );
		}
		
		public function get bitmapMaterial():BitmapMaterial
		{
			return _bitmapMaterial;
		}
		
		public function setSize( w:Number, h:Number ):void
		{
			_viewport.width = w;
			_viewport.height = h;
			
			var t:UIComponent = UIComponent( target );
			_viewport.x = ( t.width - w ) / 2;
			_viewport.y = ( t.height - h ) / 2;
		}
		
		override public function startEffect():void
		{
			
			
			super.startEffect();
		}
		
		override protected function createContainer():void
		{
			super.createContainer();
			
			var t:UIComponent = UIComponent( target );
			
			_scene = new Scene3D();
			_viewport = new Viewport3D( t.width, t.height, false, false, true, true );
			_renderer = new BasicRenderEngine();
			
			_camera = new Camera3D();
			_camera.z = -( ( _camera.zoom - 1 ) * _camera.focus );
			
			display.addChild( _viewport );
		}
		
		override protected function createBitmapData():void
		{
//			var backgroundColor:Number = target.getStyle( "backgroundColor" );
//			if( isNaN( backgroundColor ) ) backgroundColor = 0xFFFFFF;
//			
//			var bitmapColor:int = ( transparent ) ? 0x00000000 : backgroundColor;
//			
//			var t:UIComponent = UIComponent( target );
//			var bitmapData:BitmapData = new BitmapData( t.width, t.height, transparent, 0xFF0000 );
//			bitmapData.draw( t );
			
			super.createBitmapData();
			
			_bitmapMaterial = new BitmapMaterial( bitmapData );
			_bitmapMaterial.doubleSided = true;
		}
		
		override public function play():void
		{
			super.play();
			
			_renderer.renderScene( _scene, _camera, _viewport, true );
			_renderer.renderScene( _scene, _camera, _viewport, true );
		}
		
		override public function onTweenUpdate( value:Object ):void
		{
			super.onTweenUpdate( value );
			
			_renderer.renderScene( _scene, _camera, _viewport, true );
		}
		
		override public function finishEffect():void
	    {
	    	display.removeChild( _viewport );
	    	_viewport = null;
	    	
	    	super.finishEffect();
	    }
	    
	    override protected function destroyBitmapData():void
		{
			if( _bitmapMaterial ) _bitmapMaterial.destroy();
			
			super.destroyBitmapData();
		}
	}
}