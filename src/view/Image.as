package view {

	import com.greensock.TweenNano;

	import config.IGalleryConfig;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                18.10.2015 12:37
	 */
	public class Image extends BaseImage {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		
		private static var BG_BITMAP_DATA:BitmapData;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Image() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		[Inject]
		public var galleryConfig:IGalleryConfig;

		private var _image:Bitmap = new Bitmap();

		public var scaledWidth:Number = 0;

		public var scaledHeight:Number = 0;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function update():void {
			super.update();
			updateImage();

			data.waitingForContentChanged.add(updateAlpha);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateImage():void {
			if (!data.content) return;

			_image.bitmapData = data.content;
			if (_image) addChild(_image);

			var prevScaleW:int = scaledWidth;
			var prevScaleH:int = scaledHeight;

			var targetScale:Number = galleryConfig.previewHeight / _image.bitmapData.height;
			scaledWidth = _image.bitmapData.width * targetScale;
			scaledHeight = _image.bitmapData.height * targetScale;

			_image.width = prevScaleW;
			_image.height = prevScaleH;

			TweenNano.to(_image, 0.5, {
				x: -scaledWidth / 2,
				y: -scaledHeight / 2,
				width: scaledWidth,
				height: scaledHeight
			});
		}

		private function updateAlpha():void {
			_image.alpha = data.waitingForContent ? 0.5 : 1;
		}
	}
}
