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

package org.efflex.mx
{
	import mx.core.UIComponent;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.core.TileCore;
	import org.efflex.mx.effectClasses.TileInstance;

	public class TileEffect extends BitmapEffect
	{
				
		[Inspectable(category="General", type="uint", defaultValue="5")]
		public var numRows		: uint = 5;
		
		[Inspectable(category="General", type="uint", defaultValue="5")]
		public var numColumns	: uint = 5;
		
		[Inspectable(category="General", type="Number", defaultValue="50")]
		public var tileDurationPercent	: Number = 50;
		
		[Inspectable(category="General", type="String", enumeration="random,topRightToBottomLeft,topLeftToBottomRight,bottomRightToTopLeft,bottomLeftToTopRight", defaultValue="random")]
		public var order	: String = TileCore.RANDOM;
		
		public function TileEffect( target:UIComponent=null )
		{
			super( target );
			
			instanceClass = TileInstance;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:TileInstance = TileInstance( instance );
			effectInstance.numRows = numRows;
			effectInstance.numColumns = numColumns;
			effectInstance.tileDurationPercent = tileDurationPercent;
			effectInstance.order = order;
		}
	}
}