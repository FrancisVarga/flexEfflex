package org.efflex.mx.core
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	import mx.core.Application;
	
	import org.efflex.interfaces.ICore;

	public class MovieClipCore implements ICore
	{
		
		public var _duration					: Number;
		public var _frameNumberFrom				: int = -1;
		public var _frameNumberTo				: int = -1;
		
		public var _movieClip					: MovieClip;
		
		public function MovieClipCore(  source:Class, frameFrom:Object, frameTo:Object, duration:Number  )
		{
			initialize(  source, frameFrom, frameTo, duration  );
		}
		
		public function get movieClip():MovieClip
		{
			return _movieClip;
		}
		
		public function get frameNumberFrom():int
		{
			return _frameNumberFrom;
		}
		
		public function get frameNumberTo():int
		{
			return _frameNumberTo;
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		public function update( value:Number ):void
		{
			var diff:int = _frameNumberTo - _frameNumberFrom;
			_movieClip.gotoAndStop( Math.round( _frameNumberFrom + ( diff * Number( value ) ) ) );
		}
		
		private function initialize( source:Class, frameFrom:Object, frameTo:Object, duration:Number ):void
		{
			_movieClip = MovieClip( new source() );
			
			setFrameNumbers( frameFrom, frameTo );
			
			_movieClip.gotoAndStop( _frameNumberFrom );
			
			_duration = ( isNaN( duration ) ) ? ( Math.abs( _frameNumberTo - _frameNumberFrom ) / Application.application.stage.frameRate ) * 1000 : duration;
		}
		
		private function setFrameNumbers( frameFrom:Object, frameTo:Object ):void
		{
			var frameLabel:FrameLabel;
			var frameLabels:Array = _movieClip.currentLabels;
			var numFrameLabels:uint = frameLabels.length;
			for( var i:uint = 0; i < numFrameLabels; i++)
			{
			    frameLabel = FrameLabel( frameLabels[ i ] );
			    if( frameLabel.name == frameFrom.toString() ) _frameNumberFrom = frameLabel.frame;
			    if( frameLabel.name == frameTo.toString() ) _frameNumberTo = frameLabel.frame;
			}
			
			if( frameFrom )
			{
				if( _frameNumberFrom == -1 && frameFrom is int )
				{
					if( frameFrom < 1 ) throw new Error( "Frame number must be bigger than 0" );
					if( frameFrom > _movieClip.totalFrames ) throw new Error( "Frame number must be less than totalFrames" );
					_frameNumberFrom = int( frameFrom );
				}
				else
				{
					throw new Error( "Frame label '" + frameFrom + "' could not be found" );
				}
			}
			else
			{
				_frameNumberFrom = 0;
			}
			
			if( frameTo )
			{
				if( _frameNumberTo == -1&& frameTo is int )
				{
					if( frameTo < 1 ) throw new Error( "Frame number must be bigger than 0" );
					if( frameTo > _movieClip.totalFrames ) throw new Error( "Frame number must be less than totalFrames" );
					_frameNumberTo = int( frameTo );
				}
				else
				{
					throw new Error( "Frame label '" + frameFrom + "' could not be found" );
				}
			}
			else
			{
				_frameNumberTo = _movieClip.totalFrames;
			}
		}
		
	}
}