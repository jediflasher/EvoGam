package model {

	import org.osflash.signals.Signal;


	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 13:17
	 */
	public class ImageListData {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ImageListData() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const added:Signal = new Signal(ImageData);

		public const removed:Signal = new Signal(ImageData);

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _imageList:Vector.<ImageData> = new Vector.<ImageData>();

		public function get imageList():Vector.<ImageData> {
			return _imageList;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function addImage(image:ImageData):void {
			_imageList.push(image);
			added.dispatch(image);
		}

		public function removeImage(image:ImageData):void {
			var index:int = _imageList.indexOf(image);
			if (index >= 0) {
				_imageList.splice(index, 1);
				removed.dispatch(image);
			}
		}

		public function getImageAt(index:int):ImageData {
			return _imageList.length > index ? _imageList[index] : null;
		}
	}
}
