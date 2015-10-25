package base {

	import org.osflash.signals.ISignal;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 15:20
	 */
	public class SignalMediator extends Mediator {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function SignalMediator() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public override function preRemove():void {
			signalMap.removeAll();
			super.preRemove();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		protected var _signalMap:SignalMap;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected function get signalMap():SignalMap {
			return _signalMap ||= new SignalMap();
		}

		protected function addToSignal(signal:ISignal, handler:Function):void {
			signalMap.addToSignal(signal, handler);
		}

		protected function addOnceToSignal(signal:ISignal, handler:Function):void {
			signalMap.addOnceToSignal(signal, handler);
		}
	}
}
