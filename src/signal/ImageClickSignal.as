package signal {

	import model.ImageData;

	import org.osflash.signals.Signal;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 15:03
	 */
	public class ImageClickSignal extends Signal {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ImageClickSignal() {
			super(ImageData);
		}
	}
}
