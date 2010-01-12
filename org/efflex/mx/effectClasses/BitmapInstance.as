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
	import flash.events.Event;
	
	import mx.core.UIComponent;

	public class BitmapInstance extends ContainerInstance
	{
		
		public var _transparent					: Boolean;

		private var _bitmapData					: BitmapData;
		
		public function BitmapInstance( target:UIComponent )
		{
			super( target );
		}

		public function get transparent():Boolean
		{
			return _transparent;
		}
		public function set transparent( value:Boolean ):void
		{
			_transparent = value;
		}
		
		protected function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		override public function initEffect( event:Event ):void
		{
//			_bitmapDatum = new Array();
			
			UIComponent( target ).validateNow();
			
	    	createBitmapData();
	    	
			super.initEffect( event );
		}
		
		protected function createBitmapData():void
		{
			var backgroundColor:Number = target.getStyle( "backgroundColor" );
			if( isNaN( backgroundColor ) ) backgroundColor = 0xFFFFFF;
			
			var bitmapColor:int = ( transparent ) ? 0x00000000 : backgroundColor;
			
			var t:UIComponent = UIComponent( target );
			_bitmapData = new BitmapData( t.width, t.height, transparent, 0xFF0000 );
			_bitmapData.draw( t );
		}
		
		protected function destroyBitmapData():void
		{
			_bitmapData.dispose();
//			var bitmapData:BitmapData;
//			var numBitmapDatum:int = bitmapDatum.length;
//			for( var i:int = 0; i < numBitmapDatum; i++ )
//			{
//				bitmapData = BitmapData( bitmapDatum.splice( 0, 1 )[ 0 ] );
//				if( bitmapData ) bitmapData.dispose();
//			}
		}
		
		
		override public function onTweenEnd( value:Object ):void
		{
			super.onTweenEnd( value );

			destroyBitmapData();
		}
	}
}