package view {

	import base.SignalMediator;

	import flash.events.MouseEvent;

	import service.imageProvider.IImageProvider;

	import signal.ImageClickSignal;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                18.10.2015 13:32
	 */
	public class ImageMediator extends SignalMediator {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ImageMediator() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		[Inject]
		public var clickImageSignal:ImageClickSignal;

		[Inject]
		public var image:Image;

		[Inject]
		public var imageProvider:IImageProvider;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function onRegister():void {
			addViewListener(MouseEvent.CLICK, handler_imageClick);
			clickImageSignal.dispatch(image.data);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_imageClick(event:MouseEvent):void {
			if (image.data.waitingForContent) return;

			clickImageSignal.dispatch(image.data);
		}
	}
}
