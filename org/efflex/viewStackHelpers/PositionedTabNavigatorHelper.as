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
	import mx.core.mx_internal;
	
	import ws.tink.flex.containers.PositionedTabNavigator;
	
	use namespace mx_internal;
	
	public class PositionedTabNavigatorHelper extends ViewStackHelper implements IViewStackEffectHelper
	{
		
		
		public function PositionedTabNavigatorHelper( container:ViewStack )
		{
			super( container );
		}
		

	    override public function get contentWidth():Number
	    {
	        var vm:EdgeMetrics = _container.viewMetricsAndPadding;
	
	        var vmLeft:Number = vm.left;
	        var vmRight:Number = vm.right;
	
	        if ( isNaN( vmLeft ) ) vmLeft = 0;
	        if ( isNaN( vmRight ) ) vmRight = 0;
		
			var tabBarAllowance:Number = 0;
			var pos:String = _container.getStyle( "tabPosition" ).substr( 0, 1 );
			if( pos == "l" || pos == "r" ) tabBarAllowance = tabBarWidth;
		
			return unscaledWidth - tabBarAllowance - vmLeft - vmRight;
	    }
	    

	    override public function get contentHeight():Number
	    {
	        var vm:EdgeMetrics = _container.viewMetricsAndPadding;
	
	        var vmTop:Number = vm.top;
	        var vmBottom:Number = vm.bottom;
	
	        if ( isNaN( vmTop ) ) vmTop = 0;
	        if ( isNaN( vmBottom ) ) vmBottom = 0;
			
			var tabBarAllowance:Number = 0;
			var pos:String = _container.getStyle( "tabPosition" ).substr( 0, 1 );
			if( pos == "t" || pos == "b" ) tabBarAllowance = tabBarHeight;

	        return unscaledHeight - tabBarAllowance - vmTop - vmBottom;
	    }
	    
	    
	    override public function get contentX():Number
	    {   
	        var pos:String = _container.getStyle( "tabPosition" ).substr( 0, 1 );
	    	var tabBarAllowance:Number = ( pos == "l" && !isNaN( tabBarWidth ) ) ? tabBarWidth : 0;
	    	
	    	var padding:Number = _container.getStyle( "paddingLeft" );
	        if( isNaN( padding ) ) padding = 0;
			
	        return tabBarAllowance + padding;
	    }
	    

	    override public function get contentY():Number
	    {
	    	var pos:String = _container.getStyle( "tabPosition" ).substr( 0, 1 );
	    	var tabBarAllowance:Number = ( pos == "t" && !isNaN( tabBarHeight ) ) ? tabBarHeight : 0;
	    	
	    	var padding:Number = _container.getStyle( "paddingTop" );
	        if( isNaN( padding ) ) padding = 0;
		
	        return tabBarAllowance + padding;
	    }
	    
	    
	    private function get tabBarWidth():Number
	    {
	    	var position:String = _container.getStyle( "tabPosition" ).substr( 0, 1 );
	    	if( position == "t" || position == "b" ) return PositionedTabNavigator( _container ).mx_internal::getTabBar().getExplicitOrMeasuredWidth();
	    	
	        var tabWidth:Number = _container.getStyle( "tabWidth" );
	        if( isNaN( tabWidth ) ) tabWidth = PositionedTabNavigator( _container ).mx_internal::getTabBar().getExplicitOrMeasuredWidth();
	
	        return tabWidth - _container.borderMetrics.top;
	    }
	    
	    
	    private function get tabBarHeight():Number
	    {
	    	var position:String = _container.getStyle( "tabPosition" ).substr( 0, 1 );
	    	if( position == "l" || position == "r" ) return PositionedTabNavigator( _container ).mx_internal::getTabBar().getExplicitOrMeasuredHeight();
	    	
	        var tabHeight:Number = _container.getStyle( "tabHeight" );
	        if( isNaN( tabHeight ) ) tabHeight = PositionedTabNavigator( _container ).mx_internal::getTabBar().getExplicitOrMeasuredHeight();
	
	        return tabHeight - _container.borderMetrics.top;
	    }
	}
}