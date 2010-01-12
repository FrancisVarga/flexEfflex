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

package org.efflex.viewStackHelpers
{
	import mx.containers.ViewStack;
	import mx.core.EdgeMetrics;
	
	public class ViewStackHelper implements IViewStackEffectHelper
	{
		
		protected var _container 			: ViewStack;
		
		public function ViewStackHelper( container:ViewStack )
		{
			_container = container;
		}
		

	    public function get contentWidth():Number
	    {
	        var vm:EdgeMetrics = _container.viewMetricsAndPadding;
			return unscaledWidth - vm.left - vm.right;
	    }
	    

	    public function get contentHeight():Number
	    {
	        var vm:EdgeMetrics = _container.viewMetricsAndPadding;
			return unscaledHeight - vm.top - vm.bottom;
	    }
	    
	    
	    public function get contentX():Number
	    {   
	        return _container.getStyle( "paddingLeft" );
	    }
	    

	    public function get contentY():Number
	    {
	    	return _container.getStyle( "paddingTop" );
	    }
		
		
		public function get unscaledWidth():Number
	    {
	        return _container.width / Math.abs( _container.scaleX );
	    }


	    public function get unscaledHeight():Number
	    {
	        return _container.height / Math.abs( _container.scaleY );
	    }
	    
	}
}