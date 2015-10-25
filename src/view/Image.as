package view {

	import com.greensock.TweenNano;

	import config.IGalleryConfig;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import model.ImageData;

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
		//  Properties
		//
		//--------------------------------------------------------------------------


		override public function set data(value:ImageData):void {
			if (super.data) data.waitingForContentChanged.remove(updateAlpha);
			super.data = value;
			if (super.data) data.waitingForContentChanged.add(updateAlpha);
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
			updateAlpha();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateImage():void {
			if (!data || !data.content) return;

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
				height: scaledHeight,
				alpha:1
			});
		}

		private function updateAlpha():void {
			if (data && data.waitingForContent) {
				var size:Number = 30;
				TweenNano.to(_image, 0.5, {x:-size/2, y:-size/2, width:size, height:size, alpha:0.5});
			}
		}
	}
}
