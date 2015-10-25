package service.imageProvider {

	import flash.display.BitmapData;

	import org.osflash.signals.ISignal;

	public interface IImageProvider {

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		function get imageReady():ISignal;

		function get prepared():Boolean;

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		function prepareNextImage():void;

		function getNextImage():BitmapData;
	}
}
