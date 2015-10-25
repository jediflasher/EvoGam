package view {

	import flash.display.Sprite;

	import model.ImageData;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 17:24
	 */
	public class BaseImage extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function BaseImage() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _data:ImageData;

		public function get data():ImageData {
			return _data;
		}

		public function set data(value:ImageData):void {
			if (_data === value) return;

			if (_data) _data.updated.remove(update);
			_data = value;
			if (_data) _data.updated.add(update);

			update();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function update():void {

		}


	}
}
