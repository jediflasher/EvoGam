package base {

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 14:53
	 */
	public class SignalMapTest {

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _map:SignalMap;

		private var _signal:ISignal;

		private var _signalHandledCount:int = 0;

		private var _signalHandled:Boolean = false;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		[Before]
		public function setUp():void {
			_map = new SignalMap();
			_signal = new Signal();
		}

		[After]
		public function tearDown():void {
			_signalHandledCount = 0;
			_signalHandled = false;
		}

		[Test]
		public function handler_calls_always():void {
			_map.addToSignal(_signal, signalHandler);
			_signal.dispatch();
			_signal.dispatch();
			_signal.dispatch();
			assertEquals(3, _signalHandledCount);
		}

		[Test]
		public function handler_not_called():void {
			_map.addToSignal(_signal, signalHandler);
			_map.removeFromSignal(_signal, signalHandler);
			_signal.dispatch();
			assertFalse(_signalHandled);
		}

		[Test]
		public function handler_called_once():void {
			_map.addOnceToSignal(_signal, signalHandler);
			_signal.dispatch();
			_signal.dispatch();

			assertTrue(_signalHandled);
			assertEquals(1, _signalHandledCount);
		}

		[Test]
		public function has_no_handlers_after_init():void {
			assertFalse(_map.hasHandlers(_signal));
		}

		[Test]
		public function has_handlers_after_mapping():void {
			_map.addToSignal(_signal, signalHandler);
			assertTrue(_map.hasHandlers(_signal));
		}

		[Test]
		public function has_no_handlers_after_unmapping():void {
			_map.addToSignal(_signal, signalHandler);
			_map.removeFromSignal(_signal, signalHandler);

			assertFalse(_map.hasHandlers(_signal));
		}

		[Test]
		public function has_not_handlers_after_removing_all():void {
			_map.addToSignal(_signal, signalHandler);
			_map.addToSignal(_signal, signalHandler2);
			_map.removeAll();
			assertFalse(_map.hasHandlers(_signal));
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function signalHandler():void {
			_signalHandled = true;
			_signalHandledCount++;
		}

		private function signalHandler2():void {
			_signalHandled = true;
			_signalHandledCount++;
		}
	}
}
