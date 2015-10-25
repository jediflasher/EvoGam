package base {

	import flash.utils.Dictionary;

	import org.osflash.signals.ISignal;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 15:23
	 */
	public class SignalMap {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function SignalMap() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		protected var _handlersBySignal:Dictionary = new Dictionary();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function hasHandlers(signal:ISignal):Boolean {
			var list:Vector.<Function> = _handlersBySignal[signal] as Vector.<Function>;
			return list && list.length > 0;
		}

		public function addToSignal(signal:ISignal, handler:Function):void {
			signal.add(handler);
			storeSignalHandler(signal, handler);
		}

		public function addOnceToSignal(signal:ISignal, handler:Function):void {
			signal.addOnce(handler);
			storeSignalHandler(signal, handler);
		}

		public function removeFromSignal(signal:ISignal, handler:Function):void {
			signal.remove(handler);

			var list:Vector.<Function> = _handlersBySignal[signal] as Vector.<Function>;
			if (!list) return;

			var index:int = list.indexOf(handler);
			if(index > -1) list.splice(index, 1);
		}

		public function removeAll():void {
			for( var signal:Object in _handlersBySignal) {
				var knownSignal:ISignal = signal as ISignal;
				var handlers:Vector.<Function> = _handlersBySignal[signal];
				delete _handlersBySignal[signal];

				for each(var handler:Function in handlers) {
					knownSignal.remove(handler);
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected function storeSignalHandler(signal:ISignal, handler:Function):void {
			var list:Vector.<Function> = _handlersBySignal[signal] as Vector.<Function>;
			if(!list) {
				list = new Vector.<Function>();
				_handlersBySignal[signal] = list;
			}

			list.push(handler);
		}
	}
}