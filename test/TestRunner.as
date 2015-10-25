package {

	import base.SignalMapTest;

	import service.imageProvider.SimpleImageProviderTest;

	import util.ArrayUtilTest;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                25.10.2015 14:00
	 */

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestRunner {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function TestRunner() {
			super();
		}

		public var signalMapTest:SignalMapTest;

		public var simpleImageProviderTest:SimpleImageProviderTest;

		public var arrayUtilTest:ArrayUtilTest;
	}
}
