/*
Copyright (c) 2008 Tink Ltd | http://www.tink.ws

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

	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.effectClasses.TweenEffectInstance;
	import mx.managers.PopUpManager;
	
	import org.efflex.mx.ContainerEffect;

	use namespace mx_internal;
	
	public class ContainerInstance extends TweenEffectInstance
	{
		
		public var popUp							: Boolean;
		public var modal 							: Boolean;
		public var modalTransparency				: Number;
		public var modalTransparencyColor 			: Number;
		public var modalTransparencyBlur 			: Number;
		public var modalTransparencyDuration 		: Number;
		public var xOffset 							: Number;
		public var yOffset 							: Number;
		public var width 							: Number;
		public var height						 	: Number;
		public var hideTarget					 	: Boolean;
		public var hideType							: String;
		
		private var _prevBlendModes					: Array;
		
		private var _contentPane					: DisplayObjectContainer;

		public function ContainerInstance( target:UIComponent )
		{
			super( target );
		}

		override public function initEffect( event:Event ):void
		{
			_prevBlendModes = new Array();
			
	    	createContainer();
	    	
			super.initEffect( event );
		}
		
		public function get display():DisplayObjectContainer
		{
			return _contentPane;
		}
		
		override public function play():void
		{
			super.play();

			if( hideTarget ) applyBlendMode( true );
		}

		override public function end():void
		{
			super.end()
		}
		
		override public function finishEffect():void
		{
			super.finishEffect();
		
			if( hideTarget ) applyBlendMode( false );
			
			if( popUp )
			{
				PopUpManager.removePopUp( UIComponent( _contentPane ) );
			}
			else
			{
				if( target is Container )
				{
					Container( target ).rawChildren.removeChild( _contentPane );
				}
				else
				{
					DisplayObjectContainer( target ).removeChild( _contentPane );
				}
			}
			
			_contentPane.visible = false;
				
		}
		
		protected function createContainer():void
		{
			
			if( popUp )
			{
				var t:UIComponent = UIComponent( target );
				var popUpContentPane:UIComponent = new UIComponent();
				var globalPos:Point = t.parent.localToGlobal( new Point( t.x, t.y ) );
				popUpContentPane.x = globalPos.x;
				popUpContentPane.y = globalPos.y;
				popUpContentPane.setStyle( "modalTransparency", modalTransparency );
				popUpContentPane.setStyle( "modalTransparencyColor", modalTransparencyColor );
				popUpContentPane.setStyle( "modalTransparencyBlur", modalTransparencyBlur );
				popUpContentPane.setStyle( "modalTransparencyDuration", modalTransparencyDuration );
				PopUpManager.addPopUp( popUpContentPane, t, modal );
				
				_contentPane = popUpContentPane;
				
				if( !hideType ) hideType = ContainerEffect.TARGET;
			}
			else
			{
				_contentPane = new MovieClip();
				_contentPane.name = "EffectContentPane";
				
				if( target is Container )
				{
					Container( target ).rawChildren.addChild( _contentPane );
				}
				else
				{
					DisplayObjectContainer( target ).addChild( _contentPane );
				}
				
				if( !hideType ) hideType = ContainerEffect.CHILDREN;
			}
			
		}
		
		final protected function applyBlendMode( value:Boolean ):void
		{
			var container:Container;
			var displayObjectContainer:DisplayObjectContainer;
			var child:DisplayObject;
			var numChildren:uint
			var i:uint;
//
			if( !_prevBlendModes ) _prevBlendModes = new Array();
			
			if( value )
			{
				switch( hideType )
				{
					case ContainerEffect.TARGET :
					{
						_prevBlendModes.push( target.blendMode );
						target.blendMode = BlendMode.ERASE;
						break;
					}
					case ContainerEffect.CHILDREN :
					{
						container = Container( target );
						numChildren = container.rawChildren.numChildren;
						for( i = 0; i < numChildren; i++ )
						{
							child = container.rawChildren.getChildAt( i );
							if( child != _contentPane )
							{
								_prevBlendModes.push( child.blendMode );
								child.blendMode = BlendMode.ERASE;
							}
						}
						// No Break require here as we still need to target the children
					}
					case ContainerEffect.CHILDREN_NO_RAW:
					{
						displayObjectContainer = DisplayObjectContainer( target );
						numChildren = displayObjectContainer.numChildren;
						for( i = 0; i < numChildren; i++ )
						{
							child = displayObjectContainer.getChildAt( i );
							if( child != _contentPane )
							{
								_prevBlendModes.push( child.blendMode );
								child.blendMode = BlendMode.ERASE;
							}
						}
						break;
					}
				}
			}
			else
			{
				var bm:String;
				switch( hideType )
				{
					case ContainerEffect.TARGET :
					{
						 bm = _prevBlendModes.splice( 0, 1 )[ 0 ];
						 target.blendMode = ( bm ) ? bm : BlendMode.NORMAL;
						break;
					}
					case ContainerEffect.CHILDREN :
					{
						container = Container( target );
						numChildren = container.rawChildren.numChildren;
						for( i = 0; i < numChildren; i++ )
						{
							child = container.rawChildren.getChildAt( i );
							if( child != _contentPane )
							{
								bm = _prevBlendModes.splice( 0, 1 )[ 0 ];
						 		child.blendMode = ( bm ) ? bm : BlendMode.NORMAL;
							}
						}
						// No Break require here as we still need to target the children
					}
					case ContainerEffect.CHILDREN_NO_RAW:
					{
						displayObjectContainer = DisplayObjectContainer( target );
						numChildren = displayObjectContainer.numChildren;
						for( i = 0; i < numChildren; i++ )
						{
							child = displayObjectContainer.getChildAt( i );
							if( child != _contentPane )
							{
								bm = _prevBlendModes.splice( 0, 1 )[ 0 ];
						 		child.blendMode = ( bm ) ? bm : BlendMode.NORMAL;
							}
						}
						break;
					}
					
				}
				
				_prevBlendModes = null;
			}
			
			
		}
		
	}
}