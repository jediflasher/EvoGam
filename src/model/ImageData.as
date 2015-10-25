package model {

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import org.osflash.signals.Signal;

	import signal.ImageUpdatedSignal;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                18.10.2015 12:38
	 */
	public class ImageData {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ImageData() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const updated:ImageUpdatedSignal = new ImageUpdatedSignal();

		public const waitingForContentChanged:Signal = new Signal();

		private var _waitingForContent:Boolean = false;

		public function get waitingForContent():Boolean {
			return _waitingForContent;
		}

		public function set waitingForContent(value:Boolean):void {
			if (_waitingForContent == value) return;

			_waitingForContent = value;
			waitingForContentChanged.dispatch();
		}

		private var _content:BitmapData;

		public function get content():BitmapData {
			return _content;
		}

		public function set content(value:BitmapData):void {
			if (_content === value) return;

			_content = value;
			waitingForContent = false;
			updated.dispatch();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
	}
}
