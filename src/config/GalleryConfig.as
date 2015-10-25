package config {
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 15:13
	 */
	public class GalleryConfig implements IGalleryConfig {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function GalleryConfig() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get previewHeight():Number {
			return 200;
		}

		/**
		 * @inheritDoc
		 */
		public function get previewMargin():Number {
			return 15;
		}

		/**
		 * @inheritDoc
		 */
		public function get previewBorderSize():Number {
			return 20;
		}

		/**
		 * @inheritDoc
		 */
		public function get imageCount():int {
			return 50;
		}
	}
}
