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

package org.efflex.spark.viewStackEffects.supportClasses
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.containers.ViewStack;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import org.efflex.viewStackHelpers.IViewStackEffectHelper;
	
	import spark.effects.supportClasses.AnimateInstance;

	use namespace mx_internal;

	public class ViewStackAnimateInstance extends AnimateInstance
	{
		
		public var hideTarget						: Boolean;
		public var transparent						: Boolean;
		public var popUp							: Boolean;
		public var modal 							: Boolean;
		public var modalTransparency				: Number;
		public var modalTransparencyColor 			: Number;
		public var modalTransparencyBlur 			: Number;
		public var modalTransparencyDuration 		: Number;
		
		private var _prevBlendMode					: String;
		
		private var _viewStack						: ViewStack;
		private var _helper							: IViewStackEffectHelper;
		private var _contentPane					: ViewStackInstanceContainer;

		protected var _indicesRequired				: Array;
		private var _waitingForCreation				: Boolean;
		private var _wasInterrupted					: Boolean;
		
		private var _effectType						: String;
		
					
		
		public function ViewStackAnimateInstance( target:UIComponent )
		{
			super( target );
			
			if( target.parent is ViewStack )
			{
				_viewStack = ViewStack( target.parent );
			}
			else
			{
				throw new Error( "ViewStackInstance must have a target with a parent property that is a ViewStack or is a subclass of ViewStack" );
			}
		}
		
		public function get data():Object
		{
			return _contentPane.data;
		}
		
		public function get hideDisplay():Bitmap
		{
			return _contentPane.hideDisplay;
		}
		
		public function get display():DisplayObjectContainer
		{
			return _contentPane.display;
		}
		
		final public function getBitmapDataAtIndex( value:uint ):BitmapData
		{
			return _contentPane.bitmapDatum[ value ];
		}
		
		final private function get bitmapDatum():Vector.<BitmapData>
		{
			return _contentPane.bitmapDatum;
		}
		
		final public function get snapShot():BitmapData
		{
			return _contentPane.hideDisplay.bitmapData;
		}
		
		final public function get selectedIndexTo():int
		{
			return _contentPane.selectedIndexTo;
		}
		
		final public function get selectedIndexFrom():int
		{
			return _contentPane.selectedIndexFrom;
		}
		
		final protected function get wasInterrupted():Boolean
		{
			return _contentPane.wasInterrupted;
		}
		
		final public function get viewStack():ViewStack
		{
			return _viewStack;
		}
		
		final protected function get contentX():Number
		{
			return _helper.contentX;
		}
		
		final protected function get contentY():Number
		{
			return _helper.contentY;
		}
		
		final protected function get contentWidth():Number
		{
			return _helper.contentWidth;
		}
		
		final protected function get contentHeight():Number
		{
			return _helper.contentHeight;
		}
		
		final public function set helper( Helper:Class ):void
        {
            _helper = IViewStackEffectHelper( new Helper( _viewStack ) );
        }
        
        final protected function addRequiredIndex( index:int ):void
		{
			_indicesRequired.push( index );
		}
		
		override public function initEffect( event:Event ):void
	    {
	    	super.initEffect( event );
	    	
	    	_contentPane = _viewStack.rawChildren.getChildByName( "ViewStackInstance" ) as ViewStackInstanceContainer;
	    	
			if( !_contentPane ) createContainers();
			
			_indicesRequired = new Array();

			_contentPane.selectedIndexTo = _viewStack.selectedIndex;
			
			_effectType = event.type;
			
			switch( _effectType )
			{
				case FlexEvent.HIDE :
				{
					addRequiredIndex( selectedIndexFrom );
					break;
				}
				case FlexEvent.SHOW :
				{
					setIndicesRequired();
					break;
				}
			}
	    	
	    	if( !_indicesRequired.length )
			{
				addRequiredIndex( selectedIndexFrom );
				addRequiredIndex( selectedIndexTo );
			}
	    	else if( _indicesRequired.length == 1 && _indicesRequired[ 0 ] == -1 )
			{
				_indicesRequired = new Array();
				var numChildren:int = viewStack.numChildren;
				for( var i:int = 0; i < numChildren; i++ )
				{
					addRequiredIndex( i );
				}
			}
			
			_indicesRequired = removeDuplicatesFromArray( _indicesRequired );
	    	_contentPane.containerResizeAndCreator.initialize( _indicesRequired, viewStack, new Rectangle( contentX, contentY, contentWidth, contentHeight ) );
	    }
	    
	    override public function startEffect():void
	    {
			if( !_contentPane.containerResizeAndCreator.complete )
			{
				_waitingForCreation = true;
			}
			else
			{
				_waitingForCreation = false;
	    		super.startEffect();
	  		}
	    }
	    
	    override public function play():void
        {
			switch( _effectType )
			{
				case FlexEvent.HIDE :
				{
					playCount++;
			        dispatchEvent( new EffectEvent( EffectEvent.EFFECT_START, false, false, this ) );
			        if( target && ( target is IEventDispatcher ) ) target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START, false, false, this));
			
					takeSnapShot();
					removeChildren();
					_contentPane.hideDisplay.visible = true;
					if( hideTarget ) applyEraseBlendMode( true );
					viewStack.callLater( finishRepeat );
					break;
				}
				case FlexEvent.SHOW :
				{
					removeChildren();
					createBitmapDatum();
					playViewStackEffect();
					_contentPane.hideDisplay.visible = false;
					if( hideTarget ) applyEraseBlendMode( true );
					super.play();
					break;
				}
			}
        }
        
        protected function playViewStackEffect():void
        {
        }

		protected function setIndicesRequired():void
		{
		}
		
		protected function setInturruptionParams():void
		{
		}
		
        protected function createBitmapDatum():void
		{
			var bitmapData:BitmapData;

			var backgroundColor:Number = viewStack.getStyle( "backgroundColor" );
			if( isNaN( backgroundColor ) ) backgroundColor = 0xFFFFFF;
			
			var bitmapColor:int = ( transparent ) ? 0x00000000 : backgroundColor;
			
			var child:UIComponent;
			var numChildren:uint = _indicesRequired.length;
			for( var i:uint; i < numChildren; i++ )
			{
				bitmapData = bitmapDatum[ _indicesRequired[ i ] ] as BitmapData;
				if( !bitmapData )
				{
					child = UIComponent( viewStack.getChildAt( _indicesRequired[ i ] ) );
					bitmapData = new BitmapData( child.width, child.height, transparent, bitmapColor );				
					bitmapData.draw( child );
					bitmapDatum[ _indicesRequired[ i ] ] = bitmapData;
				}
			}
		}
		
		protected function takeSnapShot():void
		{
			var preSnapShot:BitmapData = _contentPane.hideDisplay.bitmapData;

			var backgroundColor:Number = viewStack.getStyle( "backgroundColor" );
			if( isNaN( backgroundColor ) ) backgroundColor = 0xFFFFFF;
			
			var bitmapColor:int = ( transparent ) ? 0x00000000 : backgroundColor;
			
			var snapShot:BitmapData = new BitmapData( contentWidth, contentHeight, transparent, bitmapColor );
			
			if( wasInterrupted )
			{
				snapShot.draw( _contentPane );
			}
			else
			{
				snapShot.draw( viewStack, new Matrix( 1, 0, 0, 1, -( contentX + viewStack.borderMetrics.left ), -( contentY + viewStack.borderMetrics.top ) ) );
			}
			
			 _contentPane.hideDisplay.bitmapData = snapShot;
			 if( preSnapShot ) preSnapShot.dispose();
		}		

		protected function createContainers():void
		{
			var containerContentPane:Sprite = _viewStack.mx_internal::contentPane;
			
			_contentPane = new ViewStackInstanceContainer();
			_contentPane.name = "ViewStackInstance";
			
			_contentPane.bitmapDatum = new Vector.<BitmapData>( _viewStack.numChildren );
			_contentPane.selectedIndexFrom = _viewStack.getChildIndex( DisplayObject( target ) );
			
			_contentPane.x = contentX + viewStack.borderMetrics.left;
			_contentPane.y = contentY + viewStack.borderMetrics.top;
			
			_contentPane.data = new Object();
			_contentPane.display = new Sprite();
			_contentPane.hideDisplay = new Bitmap();
			_contentPane.hideDisplay.visible = false;
			
			_contentPane.containerResizeAndCreator = new ContainerResizeAndCreator();
			_contentPane.containerResizeAndCreator.addEventListener( Event.COMPLETE, onContainerResizeAndCreatorComplete, false, 0, true );
			
			if( popUp )
			{
				_contentPane.popUp = new UIComponent();
				var globalPos:Point = viewStack.parent.localToGlobal( new Point( viewStack.x + contentX, viewStack.y + contentY ) );
				_contentPane.popUp.x = globalPos.x;
				_contentPane.popUp.y = globalPos.y;
				_contentPane.popUp.setStyle( "modalTransparency", modalTransparency );
				_contentPane.popUp.setStyle( "modalTransparencyColor", modalTransparencyColor );
				_contentPane.popUp.setStyle( "modalTransparencyBlur", modalTransparencyBlur );
				_contentPane.popUp.setStyle( "modalTransparencyDuration", modalTransparencyDuration );
				_contentPane.popUp.addChild( _contentPane.hideDisplay );
				_contentPane.popUp.addChild( _contentPane.display );
				
				PopUpManager.addPopUp( _contentPane.popUp, viewStack, modal );
			}
			else
			{
				_contentPane.addChild( _contentPane.hideDisplay );
				_contentPane.addChild( _contentPane.display );
			}
			
			if( _viewStack.clipContent )
			{
				var contentMask:Sprite = new Sprite();
				contentMask.graphics.beginFill( 0x666666, 1 );
				contentMask.graphics.drawRect( 0, 0, contentWidth, contentHeight );
			
				var maskTarget:DisplayObjectContainer = ( popUp ) ? _contentPane.popUp : _contentPane;
				maskTarget.mask = contentMask;
				maskTarget.addChild( contentMask );
			}
			
			_viewStack.rawChildren.addChild( _contentPane );
		}
		
		override public function end():void
		{
			if( !_contentPane ) return;
			
			if( _effectType == FlexEvent.SHOW && _contentPane && !_wasInterrupted )
			{
				_wasInterrupted = _contentPane.wasInterrupted = true;
				setInturruptionParams();
			}
			
			try
			{
				_contentPane.containerResizeAndCreator.cancel();
			}
			catch( error:Error )
			{
				
			}

			if( animation )
	        {
	            animation.pause();
	            animation = null;
	        }
        
			stopRepeat = true;
			if( delayTimer ) delayTimer.reset();
			
			finishEffect();
		}
		
		override public function finishEffect():void
		{
			super.finishEffect();

			if( _prevBlendMode ) applyEraseBlendMode( false );
			
			if( _wasInterrupted ) return;
			
			if( _effectType == FlexEvent.SHOW )
			{
				if( display ) if( _contentPane.contains( display ) ) _contentPane.removeChild( display );
				
				if( _contentPane )
				{
					if( _contentPane.hideDisplay )
					{
						if( _contentPane.contains( _contentPane.hideDisplay ) ) _contentPane.removeChild( _contentPane.hideDisplay );
						if( _contentPane.hideDisplay.bitmapData ) _contentPane.hideDisplay.bitmapData.dispose();
					}
					if( _contentPane.mask ) if( _contentPane.contains( _contentPane.mask ) ) _contentPane.removeChild( _contentPane.mask );
		
					if( _viewStack.rawChildren.contains( _contentPane ) ) _viewStack.rawChildren.removeChild( _contentPane );
					
					if( _contentPane.popUp )
					{
						if( _contentPane.popUp.contains( display ) ) _contentPane.popUp.removeChild( display );
						if( _contentPane.popUp.contains( _contentPane.hideDisplay ) ) _contentPane.popUp.removeChild( _contentPane.hideDisplay );
						if( _contentPane.popUp.mask ) _contentPane.popUp.removeChild( _contentPane.popUp.mask );
						PopUpManager.removePopUp( _contentPane.popUp );
					}
				}
				
				removeChildren();
				destroyBitmapDatum();
	
				_contentPane.data = null;
				_contentPane.bitmapDatum = null;
				_contentPane.containerResizeAndCreator = null;
				_contentPane.display = null;
				_contentPane.hideDisplay = null;
				_contentPane.popUp = null;
	
				_contentPane = null;
			}
		}
		
		protected function removeChildren():void
		{
			var numChildren:int  = display.numChildren;
			for( var i:int = numChildren - 1; i > -1; i-- )
			{
				display.removeChild( DisplayObject( display.getChildAt( i ) ) );
			}
		}
		
		protected function destroyBitmapDatum():void
		{
			if( !bitmapDatum ) return;
			
			var bitmapData:BitmapData;
			var numBitmaps:int = bitmapDatum.length;
			for( var i:int = 0; i < numBitmaps; i++ )
			{
				bitmapData = BitmapData( bitmapDatum[ i ] );
				if( bitmapData ) bitmapData.dispose();
			}
		}
		
		private function applyEraseBlendMode( value:Boolean ):void
		{
			if( value )
			{
				_prevBlendMode = target.blendMode;
				target.blendMode = BlendMode.ERASE;
			}
			else
			{
				target.blendMode = ( _prevBlendMode ) ? _prevBlendMode : BlendMode.NORMAL;
			}
		}
    
		private function onContainerResizeAndCreatorComplete( event:Event ):void
		{
			if( _waitingForCreation ) startEffect();
		}
		
		final protected function removeDuplicatesFromArray( input:Array ):Array
		{
			var dict:Dictionary = new Dictionary( true );
			var output:Array = new Array();
			var item:*;
			var numItems:int = input.length;
			for( var i:int = 0; i < numItems ; i++ )
			{
				item = input[ i ];
				if( dict[ item ] == undefined )
				{
					dict[ item ] = true;
					output.push( item );
					
				}
			}
			return output;     
		}
	
	}
	
}














	
	
import flash.events.EventDispatcher;
import mx.events.FlexEvent;
import mx.core.Container;
import mx.containers.ViewStack;
import flash.geom.Rectangle;
import mx.core.mx_internal;
import mx.core.IInvalidating;
import flash.events.Event;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.display.MovieClip;
import flash.display.Sprite;
import mx.core.UIComponent;
import flash.display.BitmapData;
import flash.display.Bitmap;

use namespace mx_internal;
class ContainerResizeAndCreator extends EventDispatcher
{
	
	private var _creationCount				: int;
	private var _creationCompleteCount		: int;
	private var _complete					: Boolean;
	private var _creatingContainers			: Array;
	
	public function ContainerResizeAndCreator()
	{
		super();
	}
	
	public function get complete():Boolean
	{
		return _complete;
	}
	
	public function cancel():void
	{
		_complete = true;
		
		var container:Container;
		var numContainers:int;
		for( var i:int = 0; i < numContainers; i++ )
		{
			container = Container( _creatingContainers[ i ] );
			container.removeEventListener( FlexEvent.CREATION_COMPLETE, onContainerCreationComplete, false );
		}
	}
	
	public function initialize( indicesRequired:Array, viewStack:ViewStack, bounds:Rectangle ):void
	{
		_complete = false;

		_creationCount = 0;
		_creationCompleteCount = 0;
		
		var i:int;
		var numIndicesRequired:uint;
		var numChildren:int = viewStack.numChildren;
		
		_creatingContainers = new Array();

		var newWidth:Number;
		var newHeight:Number;

		var child:Container;
			
		var index:int;
		
		numIndicesRequired = indicesRequired.length;
		for( i = 0; i < numIndicesRequired; i++ )
		{
			index = Number( indicesRequired[ i ] );
			if( index >= 0 && index < numChildren )
			{
				child = viewStack.getChildAt( index ) as Container;
				if( ( child.mx_internal::numChildrenCreated == -1 && child.numChildren != 0 ) || !child.initialized ) _creationCount++;
			}
		}
		
		numIndicesRequired = indicesRequired.length;
		for( i = 0; i < numIndicesRequired; i++ )
		{
			index = Number( indicesRequired[ i ] );
			if( index >= 0 && index < numChildren && !isNaN( index ) )
			{
				child = viewStack.getChildAt( index ) as Container;
				
				if( ( child.mx_internal::numChildrenCreated == -1 && child.numChildren != 0 ) || !child.initialized )
				{
					_creatingContainers.push( child );
					child.addEventListener( FlexEvent.CREATION_COMPLETE, onContainerCreationComplete, false, 0, true );
					child.createComponentsFromDescriptors( true );
				}

				newWidth = bounds.width;
				newHeight = bounds.height;
			
				if ( !isNaN( child.percentWidth ) )
				{
					if( newWidth > child.maxWidth ) newWidth = child.maxWidth;
				}
				else
				{
					if( newWidth > child.explicitWidth ) newWidth = child.explicitWidth;
				}
	
				if( !isNaN( child.percentHeight ) )
				{
					if( newHeight > child.maxHeight ) newHeight = child.maxHeight;
				}
				else
				{
					if( newHeight > child.explicitHeight ) newHeight = child.explicitHeight;
				}
				
				if( child.x != bounds.x || child.y != bounds.y ) child.move( bounds.x, bounds.y );
				if( child.width != newWidth || child.height != newHeight ) child.setActualSize( newWidth, newHeight );
				
				if( child.invalidateDisplayListFlag || child.invalidateSizeFlag || child.invalidatePropertiesFlag ) child.validateNow();
			}
			else
			{
				// error invalid index
			}
		}
		
		if( _creationCount == 0 ) checkCreationStatus();
	}
	
	private function onContainerCreationComplete( event:FlexEvent ):void
	{
		var container:Container = Container( event.currentTarget );
		container.removeEventListener( FlexEvent.CREATION_COMPLETE, onContainerCreationComplete, false );
		_creationCompleteCount++;
		
		checkCreationStatus();
	}
	
	private function checkCreationStatus():void
	{
		if( _creationCompleteCount == _creationCount && !_complete )
		{
			_complete = true;
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
	
}

class ViewStackInstanceContainer extends Sprite
{
	
	public var data							: Object;
	public var bitmapDatum					: Vector.<BitmapData>;
	public var selectedIndexFrom			: int;
	public var selectedIndexTo				: int;
	
	public var display						: Sprite;
	public var hideDisplay					: Bitmap;
	
	public var wasInterrupted				: Boolean;
	
	public var containerResizeAndCreator	: ContainerResizeAndCreator;
	
	public var popUp						: UIComponent;
	
	public function ViewStackInstanceContainer()
	{
		super();
	}
	
}
