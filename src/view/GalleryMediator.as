package view {

	import com.greensock.TweenNano;

	import config.IGalleryConfig;

	import flash.events.Event;

	import flash.events.MouseEvent;

	import flash.utils.Dictionary;

	import model.ImageData;
	import model.ImageListData;

	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 15:18
	 */
	public class GalleryMediator extends Mediator {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function GalleryMediator() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		[Inject]
		public var imageList:ImageListData;

		[Inject]
		public var gallery:Gallery;

		[Inject]
		public var galleryConfig:IGalleryConfig;

		[Inject]
		public var injector:IInjector;

		private var _dataToView:Dictionary = new Dictionary();

		private var _nextScrollY:Number = 0;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function onRegister():void {
			gallery.galleryConfig = galleryConfig;

			gallery.stage.addEventListener(MouseEvent.MOUSE_WHEEL, handler_mouseWheel);
			gallery.stage.addEventListener(Event.RESIZE, handler_stageResize);

			imageList.added.add(imageAdded);
			imageList.removed.add(imageRemoved);

			super.onRegister();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function imageAdded(imageData:ImageData):void {
			imageData.updated.add(gallery.updateLayout);

			var image:Image = new Image();
			injector.injectInto(image);
			image.data = imageData;
			_dataToView[imageData] = image;

			gallery.addChild(image);
			gallery.updateLayout();
		}

		private function imageRemoved(imageData:ImageData):void {
			imageData.updated.remove(gallery.updateLayout);

			var image:Image = _dataToView[imageData];
			if (image) {
				gallery.removeChild(image);
				gallery.updateLayout();
				delete _dataToView[imageData];
			}
		}

		private function handler_mouseWheel(event:MouseEvent):void {
			var targetY:Number = _nextScrollY + event.delta * 30;

			if (targetY < gallery.stage.stageHeight - gallery.height) {
				targetY = gallery.stage.stageHeight - gallery.height;
			}

			if (targetY > 0) targetY = 0;

//			gallery.y = targetY;
			_nextScrollY = targetY;
			TweenNano.to(gallery, 0.3, {y:targetY});
		}

		private function handler_stageResize(event:Event):void {
			gallery.updateLayout();

			var targetY:Number = gallery.y;

			if (targetY < gallery.stage.stageHeight - gallery.height) {
				targetY = gallery.stage.stageHeight - gallery.height;
			}

			if (targetY > 0) targetY = 0;
			gallery.y = targetY;
		}
	}
}
