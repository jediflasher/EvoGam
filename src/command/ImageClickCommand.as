package command {

	import flash.display.Bitmap;
	import flash.system.System;

	import model.ImageData;

	import org.robotlegs.mvcs.Command;

	import service.imageProvider.IImageProvider;

	import signal.ImageClickSignal;

	import view.Image;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 15:04
	 */
	public class ImageClickCommand extends Command {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ImageClickCommand() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		[Inject]
		public var imageProvider:IImageProvider;

		[Inject]
		public var imageData:ImageData;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function execute():void {
			super.execute();

			if (imageProvider.prepared) {
				if (imageData.content && imageData.content) imageData.content.dispose();
				imageData.content = imageProvider.getNextImage();
				imageProvider.imageReady.remove(onImageReady);

				trace('Memory usage: ' + System.privateMemory / 1024 / 1024);
			} else {
				if (!imageData.waitingForContent) {
					imageData.waitingForContent = true;
					imageProvider.imageReady.add(onImageReady);
					imageProvider.prepareNextImage();
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function onImageReady():void {
			execute();
		}
	}
}
