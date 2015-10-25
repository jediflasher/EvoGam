package {

	import base.SignalCommandMap;

	import command.ImageClickCommand;
	import command.InitGalleryCommand;

	import config.GalleryConfig;
	import config.IGalleryConfig;

	import flash.display.DisplayObjectContainer;

	import model.ImageListData;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	import service.imageProvider.IImageProvider;
	import service.imageProvider.SimpleImageProvider;

	import signal.ImageClickSignal;
	import signal.ImageUpdatedSignal;

	import view.Gallery;
	import view.GalleryMediator;
	import view.Image;
	import view.ImageMediator;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 12:50
	 */
	public class AppContext extends Context {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AppContext(contextView:DisplayObjectContainer = null) {
			super(contextView);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _signalMap:SignalCommandMap;

		protected function get signalMap():SignalCommandMap {
			if (!_signalMap) {
				_signalMap = new SignalCommandMap(injector);
			}

			return _signalMap;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function startup():void {
			injector.mapSingleton(GalleryConfig);
			injector.mapSingleton(ImageListData);
			injector.mapSingletonOf(IImageProvider, SimpleImageProvider);

			injector.mapClass(IGalleryConfig, GalleryConfig);

			mediatorMap.mapView(Gallery, GalleryMediator);
			mediatorMap.mapView(Image, ImageMediator);

			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitGalleryCommand);

			signalMap.mapSignalClass(ImageClickSignal, ImageClickCommand);

			super.startup();
		}
	}
}
