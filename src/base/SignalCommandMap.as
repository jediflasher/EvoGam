package base {

	import flash.utils.Dictionary;
	import flash.utils.describeType;

	import org.osflash.signals.ISignal;
	import org.robotlegs.base.ContextError;
	import org.robotlegs.core.IInjector;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 13:10
	 */
	public class SignalCommandMap {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function SignalCommandMap(injector:IInjector) {
			this._injector = injector;
			_signalMap = new Dictionary(false);
			_signalClassMap = new Dictionary(false);
			_verifiedCommandClasses = new Dictionary(false);
			_detainedCommands = new Dictionary(false);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		protected var _injector:IInjector;

		protected var _signalMap:Dictionary;

		protected var _signalClassMap:Dictionary;

		protected var _verifiedCommandClasses:Dictionary;

		protected var _detainedCommands:Dictionary;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function mapSignal(signal:ISignal, commandClass:Class, oneShot:Boolean = false):void {
			verifyCommandClass(commandClass);

			if (hasSignalCommand(signal, commandClass)) return;

			var signalCommandMap:Dictionary = _signalMap[signal] ||= new Dictionary(false);

			var callback:Function = function ():void {
				routeSignalToCommand(signal, arguments, commandClass, oneShot);
			};

			signalCommandMap[commandClass] = callback;
			signal.add(callback);
		}

		public function mapSignalClass(signalClass:Class, commandClass:Class, oneShot:Boolean = false):ISignal {
			var signal:ISignal = getSignalInstance(signalClass);
			mapSignal(signal, commandClass, oneShot);
			return signal;
		}

		public function hasSignalCommand(signal:ISignal, commandClass:Class):Boolean {
			var callbacksByCommandClass:Dictionary = _signalMap[signal];
			if (!callbacksByCommandClass) return false;

			var callback:Function = callbacksByCommandClass[commandClass];
			return Boolean(callback);
		}

		public function unmapSignal(signal:ISignal, commandClass:Class):void {
			var callbacksByCommandClass:Dictionary = _signalMap[signal];
			if (!callbacksByCommandClass) return;

			var callback:Function = callbacksByCommandClass[commandClass];
			if (!(callback is Function)) return;

			signal.remove(callback);
			delete callbacksByCommandClass[commandClass];
		}

		public function unmapSignalClass(signalClass:Class, commandClass:Class):void {
			unmapSignal(getSignalInstance(signalClass), commandClass);
		}

		public function detain(command:Object):void {
			_detainedCommands[command] = true;
		}

		public function release(command:Object):void {
			delete _detainedCommands[command];
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected function getSignalInstance(signalClass:Class):ISignal {
			return _signalClassMap[signalClass] as ISignal || createSignalInstance(signalClass);
		}

		protected function routeSignalToCommand(signal:ISignal, valueObjects:Array, commandClass:Class, oneshot:Boolean):void {
			mapSignalValues(signal.valueClasses, valueObjects);
			createCommandInstance(commandClass).execute();
			unmapSignalValues(signal.valueClasses);

			if (oneshot) unmapSignal(signal, commandClass);
		}

		protected function createCommandInstance(commandClass:Class):Object {
			return _injector.instantiate(commandClass);
		}

		protected function mapSignalValues(valueClasses:Array, valueObjects:Array):void {
			var len:int = valueClasses.length;
			for (var i:uint = 0; i < len; i++) {
				_injector.mapValue(valueClasses[i], valueObjects[i]);
			}
		}

		protected function unmapSignalValues(valueClasses:Array):void {
			for each (var clazz:Class in valueClasses) {
				_injector.unmap(clazz);
			}
		}

		protected function verifyCommandClass(commandClass:Class):void {
			if (commandClass in _verifiedCommandClasses) return;

			if (describeType(commandClass).factory.method.(@name == "execute").length() != 1) {
				throw new ContextError(ContextError.E_COMMANDMAP_NOIMPL + ' - ' + commandClass);
			}

			_verifiedCommandClasses[commandClass] = true;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function createSignalInstance(signalClass:Class):ISignal {
			var injectorForSignalInstance:IInjector = _injector;
			var signal:ISignal;

			if (_injector.hasMapping(IInjector)) injectorForSignalInstance = _injector.getInstance(IInjector);

			signal = injectorForSignalInstance.instantiate(signalClass);
			injectorForSignalInstance.mapValue(signalClass, signal);
			_signalClassMap[signalClass] = signal;
			return signal;
		}
	}
}