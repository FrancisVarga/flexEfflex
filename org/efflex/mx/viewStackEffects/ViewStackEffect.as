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

package org.efflex.mx.viewStackEffects
{
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.effects.IEffectInstance;
	
	import org.efflex.mx.viewStackEffects.effectClasses.ViewStackEffectInstance;
	import org.efflex.viewStackHelpers.ViewStackHelper;

	public class ViewStackEffect extends Effect
	{
		
		[Inspectable(category="General", type="Class", defaultValue="ws.tink.flex.effects.effectClasses.viewStackEffects.helpers.ViewStackHelper")]
		public var helper						: Class = ViewStackHelper;
		
		[Inspectable(category="General", type="Boolean", enumeration="true,false", defaultValue="true")]
		public var hideTarget					: Boolean = true;
		
		[Inspectable(category="General", type="Boolean", enumeration="false,true", defaultValue="false")]
		public var transparent 					: Boolean = false;
		
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
		
		
		
		public function ViewStackEffect( target:UIComponent = null )
		{
			super( target );
			
			instanceClass = ViewStackEffectInstance;
		}
		
		override protected function initInstance( instance:IEffectInstance ):void
		{
			super.initInstance( instance );
	
			var effectInstance:ViewStackEffectInstance = ViewStackEffectInstance( instance );
			effectInstance.helper = helper;
			effectInstance.hideTarget = hideTarget;
			effectInstance.transparent = transparent;
			effectInstance.popUp = popUp;
			effectInstance.modal = modal;
			effectInstance.modalTransparencyColor = modalTransparencyColor;
			effectInstance.modalTransparency = modalTransparency;
			effectInstance.modalTransparencyBlur = modalTransparencyBlur;
			effectInstance.modalTransparencyDuration = modalTransparencyDuration;
		}
		
	}
}