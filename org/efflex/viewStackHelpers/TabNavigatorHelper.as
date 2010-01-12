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
	import mx.containers.TabNavigator;
	import mx.containers.ViewStack;
	import mx.core.EdgeMetrics;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class TabNavigatorHelper extends ViewStackHelper implements IViewStackEffectHelper
	{
		
		
		public function TabNavigatorHelper( container:ViewStack )
		{
			super( container );
		}	    


	    override public function get contentHeight():Number
	    {
	        var vm:EdgeMetrics = _container.viewMetricsAndPadding;
	
	        var vmTop:Number = vm.top;
	        var vmBottom:Number = vm.bottom;
	
	        if( isNaN( vmTop ) ) vmTop = 0;
	        if( isNaN( vmBottom ) ) vmBottom = 0;
	
	        return unscaledHeight - tabBarHeight - vmTop - vmBottom;
	    }
	    

	    override public function get contentY():Number
	    {
	        var paddingTop:Number = _container.getStyle("paddingTop");
	        if( isNaN( paddingTop ) ) paddingTop = 0;
	
	        return tabBarHeight + paddingTop;
	    }

	    
	    private function get tabBarHeight():Number
	    {
	        var tabHeight:Number = _container.getStyle( "tabHeight" );
	        if( isNaN( tabHeight ) ) tabHeight = TabNavigator( _container ).mx_internal::getTabBar().getExplicitOrMeasuredHeight();
	
	        return tabHeight - _container.borderMetrics.top;
	    }
	}
}