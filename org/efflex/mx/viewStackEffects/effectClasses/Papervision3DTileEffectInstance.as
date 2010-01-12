package org.efflex.mx.viewStackEffects.effectClasses
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.papervision3d.Papervision3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.primitives.Plane
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;

	public class Papervision3DTileEffectInstance extends TileTweenEffectInstance
	{
		
		public var zoom						: Number;
		public var focus					: Number;
		
		private var _scene					: Scene3D;
		protected var _viewport				: Viewport3D;
		private var _renderer				: BasicRenderEngine;
		private var _camera					: Camera3D;
		
		private var _bitmapMaterials			: Array;
		private var _snapShotTileBitmapMaterials	: Array;
		
		public function Papervision3DTileEffectInstance( target:UIComponent )
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
		
		public function getSnapShotBitmapMaterialTile( index:int, row:uint, column:uint ):BitmapMaterial
		{
			if( !_snapShotTileBitmapMaterials[ index ] ) _snapShotTileBitmapMaterials = createBitmapMaterialsForIndex( index );
			return BitmapMaterial( _snapShotTileBitmapMaterials[ row ][ column ]  );
		}
		
		public function getBitmapMaterialTileAt( index:int, row:uint, column:uint ):BitmapMaterial
		{
			if( index == -1 ) return getSnapShotBitmapMaterialTile( index, row, column );
			
			if( !_bitmapMaterials[ index ] ) _bitmapMaterials[ index ] = createBitmapMaterialsForIndex( index );
			return BitmapMaterial( _bitmapMaterials[ index ][ row ][ column ] );
		}
		
		override public function initEffect( event:Event ):void
	    {
	    	super.initEffect( event );
	    	
	    	Papervision3D.VERBOSE = false;
	    	
			_bitmapMaterials = data.bitmapMaterials;
			_snapShotTileBitmapMaterials = data.snapShotTileBitmapMaterials;
	    }
	    
	    override protected function createTileEffect():void
		{
			super.createTileEffect();
			
			_scene = new Scene3D();
			_viewport = new Viewport3D( contentWidth, contentHeight, false, false, true, true );
			_renderer = new BasicRenderEngine();
			
			_camera = new Camera3D();
			_camera.z = -( ( _camera.zoom - 1 ) * _camera.focus );
			
			display.addChild( _viewport );
		}
		
		override protected function createContainers():void
		{
			super.createContainers();
			
			data.bitmapMaterials = new Array( viewStack.numChildren );
			data.snapShotTileBitmapMaterials = new Array();
		}
		
		protected function createBitmapMaterialsForIndex( index:int ):Array
		{
			var rows:Array = new Array();
			var columns:Array;
			var c:int;
			var r:int;
			for( r = 0; r < numRows; r++ )
			{
				columns = new Array();
				for( c = 0; c < numColumns; c++ )
				{
					columns.push( new BitmapMaterial( getBitmapDataTileAt( index, r, c ) ) );
				}
				rows.push( columns );
			}
			
			return rows;
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

	}
}