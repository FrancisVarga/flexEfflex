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
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.core.UIComponent;
	
	import org.efflex.mx.viewStackEffects.Flint3D;
	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.behaviours.Resetable;
	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.threeD.emitters.Emitter3D;
	import org.flintparticles.threeD.geom.Point3D;
	import org.flintparticles.threeD.particles.Particle3DUtils;
	import org.flintparticles.threeD.renderers.Camera;
	import org.flintparticles.threeD.renderers.DisplayObjectRenderer;

	public class Flint3DInstance extends ViewStackEffectInstance
	{
		
		public var effectTarget					: String;
		
		private var _emitter					: Emitter3D;
		private var _actions					: Array;
		
		private var _displayObjectRenderer		: DisplayObjectRenderer;

		public function Flint3DInstance( target:UIComponent )
		{
			super( target );
			
			
		}
		
		public function get emitter():Emitter3D
		{
			if( !_emitter ) _emitter = Emitter3D( data.emitter );
			return _emitter;
		}
		
		public function get displayObjectRenderer():DisplayObjectRenderer
		{
			if( !_displayObjectRenderer ) _displayObjectRenderer = DisplayObjectRenderer( data.displayObjectRenderer );
			return _displayObjectRenderer;
		}
		
		override protected function createContainers():void
		{
			super.createContainers();
			
			_emitter = new Emitter3D();
        	
        	var numActions:int = _actions.length;
			for( var i:int = 0; i < numActions; i++ )
			{
				emitter.addAction( ActionBase( _actions[ i ] ) );
			}
			
        	_displayObjectRenderer = new DisplayObjectRenderer();
			_displayObjectRenderer.addEmitter( _emitter );
			var c:Camera = new Camera();
			c.projectionDistance=400;
			c.position = new Point3D( 0, 0, -400 )
			_displayObjectRenderer.camera = new c;
			
			data.emitter = _emitter;
			data.displayObjectRenderer = _displayObjectRenderer;
		}
		
		override protected function playViewStackEffect():void
        {
        	super.playViewStackEffect();
			
			var bitmapDataFrom:BitmapData = snapShot;
			var bitmapDataTo:BitmapData = BitmapData( bitmapDatum[ selectedIndexTo ] );
			
			var particles:Array;
        	switch( effectTarget )
			{
				case org.efflex.mx.viewStackEffects.Flint3D.NEXT_CHILD :
				{
					display.addChild( new Bitmap( bitmapDataFrom ) );
					display.addChild( displayObjectRenderer );
					particles = Particle3DUtils.createRectangleParticlesFromBitmapData( bitmapDataTo, 10, emitter.particleFactory, new Point3D() );
					break;
				}
				case org.efflex.mx.viewStackEffects.Flint3D.PREV_CHILD :
				{
					display.addChild( new Bitmap( bitmapDataTo ) );
					display.addChild( displayObjectRenderer );
					particles = Particle3DUtils.createRectangleParticlesFromBitmapData( bitmapDataFrom, 10, emitter.particleFactory, new Point3D() );
					break;
				}
			}
			
			emitter.killAllParticles();
			emitter.stop();
			
			var action:ActionBase;
			var numActions:int = emitter.actions.length;
			for( var i:int = 0; i < numActions; i++ )
			{
				action = ActionBase( emitter.actions[ i ] );
				if( action is Resetable ) Resetable( action ).reset();
			}
			
			emitter.addExistingParticles( particles, false );
			
			emitter.addEventListener( EmitterEvent.EMITTER_EMPTY, onEmitterEmpty, false, 0, true );
			emitter.start();
        }
        
        public function set actions( value:Array ):void
		{
			_actions = value;
		}
		
        override public function end():void
		{
			super.end();
			if( emitter ) emitter.pause();
		} 
		
        private function onEmitterEmpty( event:EmitterEvent ):void
        {
        	emitter.stop();
        	finishEffect();
        }
        
        override public function finishEffect():void
		{
			super.finishEffect();
			
			if( _emitter )
			{
				_emitter.removeEventListener( EmitterEvent.EMITTER_EMPTY, onEmitterEmpty, false );
				_emitter = null;
			}
			if( _displayObjectRenderer ) _displayObjectRenderer = null;
		}
		
		
	}
}