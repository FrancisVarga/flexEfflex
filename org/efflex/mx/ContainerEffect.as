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
	import mx.effects.TweenEffect;
	
	import org.efflex.mx.effectClasses.ContainerInstance;

	public class ContainerEffect extends TweenEffect
	{
		
		public static const TARGET			: String = "target";
		public static const CHILDREN		: String = "children";
		public static const CHILDREN_NO_RAW	: String = "childrenNoRaw";
				
		[Inspectable(category="General", enumeration="target,children,childrenNoRaw")]
		public var hideType 					: String;
		
		[Inspectable(category="General", type="Boolean", enumeration="false,true", defaultValue="true")]
		public var hideTarget 					: Boolean = true;
		
		[Inspectable(category="General", type="Boolean", enumeration="false,true", defaultValue="false")]
		public var popUp 						: Boolean = false;
		
		[Inspectable(category="General", type="Boolean", enumeration="false,true", defaultValue="false")]
		public var modal 						: Boolean = false;
		
		[Inspectable(category="General", type="Color", defaultValue="0xFFFFFF")]
		public var modalTransparencyColor 		: Number = 0xFFFFFF;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var modalTransparency 			: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var modalTransparencyBlur 		: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var modalTransparencyDuration 	: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var xOffset 							: Number = 0;
		
		[Inspectable(category="General", type="Number", defaultValue="0")]
		public var yOffset 							: Number = 0;
		
		[Inspectable(category="General", type="Number")]
		public var width 							: Number;
		
		[Inspectable(category="General", type="Number")]
		public var height						 	: Number;
		
		
		public function ContainerEffect( target:UIComponent = null )
		{
			super( target );
			
			instanceClass = ContainerInstance;
		}
	
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:ContainerInstance = ContainerInstance( instance );
			effectInstance.hideType = hideType;
			effectInstance.hideTarget = hideTarget;
			effectInstance.popUp = popUp;
			effectInstance.modal = modal;
			effectInstance.modalTransparencyColor = modalTransparencyColor;
			effectInstance.modalTransparency = modalTransparency;
			effectInstance.modalTransparencyBlur = modalTransparencyBlur;
			effectInstance.modalTransparencyDuration = modalTransparencyDuration;
			effectInstance.xOffset = xOffset;
			effectInstance.yOffset = yOffset;
			effectInstance.width = width;
			effectInstance.height = height;
		}
	}
}