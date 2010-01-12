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
	
	import org.efflex.mx.effectClasses.FadeTileInstance;

	public class FadeTile extends TileEffect
	{
		
		public static const PREV_CHILD			: String = "prevChild";
		public static const NEXT_CHILD			: String = "nextChild";
		
		private static var AFFECTED_PROPERTIES:Array = [ "alpha" ];
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var alphaFrom					: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="1")]
		public var alphaTo						: Number = 1;
				
		public function FadeTile( target:UIComponent = null )
		{
			super( target );

			instanceClass = FadeTileInstance;
		}
		
		override public function getAffectedProperties():Array
	    {
	        return AFFECTED_PROPERTIES;
	    }
    
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );

			var effectInstance:FadeTileInstance = FadeTileInstance( instance );
			effectInstance.alphaFrom = alphaFrom;
			effectInstance.alphaTo = alphaTo;
		}
		
	}
}