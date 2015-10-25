package service.imageProvider {

	import flash.display.BitmapData;
	import flash.events.Event;

	import org.flexunit.Assert;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;

	import org.flexunit.asserts.assertTrue;

	import org.flexunit.async.Async;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 12:54
	 */
	public class SimpleImageProviderTest {

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _provider:IImageProvider;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		[Before]
		public function setUp():void {
			_provider = new SimpleImageProvider();
		}

		[After]
		public function tearDown():void {
			_provider.imageReady.removeAll();
		}

		[Test(async)]
		public function image_prepared():void {
			_provider.imageReady.addOnce(Async.asyncHandler(this, image_prepared_readyHandler, 5000, _provider, timeoutHandler));
			_provider.prepareNextImage();
		}

		[Test(async)]
		public function returns_image_after_prepared():void {
			_provider.imageReady.addOnce(Async.asyncHandler(this, returns_image_after_prepared_readyHandler, 5000, _provider, timeoutHandler));
			_provider.prepareNextImage();
		}

		[Test(async)]
		public function image_not_prepared_after_get():void {
			_provider.imageReady.addOnce(Async.asyncHandler(this, image_not_prepared_after_get_readyHandler, 5000, _provider, timeoutHandler));
			_provider.prepareNextImage();
		}

		[Test(async)]
		public function has_same_count_of_image_as_asked():void {
			Async.delayCall(this, has_same_count_of_image_as_asked_readyHandler, 2000);
			_provider.prepareNextImage();
			_provider.prepareNextImage();
			_provider.prepareNextImage();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function timeoutHandler(passThroughData:Object = null):void {
			Assert.fail("Image not prepared: timeout");
		}

		private function image_prepared_readyHandler(event:Event = null, passThroughData:Object = null):void {
			assertTrue((passThroughData as IImageProvider).prepared);
		}

		private function returns_image_after_prepared_readyHandler(event:Event = null, passThroughData:Object = null):void {
			assertTrue((passThroughData as IImageProvider).getNextImage() is BitmapData);
		}

		private function image_not_prepared_after_get_readyHandler(event:Event = null, passThroughData:Object = null):void {
			var provider:IImageProvider = (passThroughData as IImageProvider);
			provider.getNextImage();
			assertFalse(provider.prepared);
		}

		private function has_same_count_of_image_as_asked_readyHandler(passThroughData:Object = null):void {
			var imageCount:int = 0;

			while (_provider.prepared) {
				_provider.getNextImage();
				imageCount++;
			}

			assertEquals(3, imageCount);
		}
	}
}
