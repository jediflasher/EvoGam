package service.imageProvider {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import org.osflash.signals.ISignal;

	import signal.ImageReadySignal;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 13:48
	 */
	public class SimpleImageProvider implements IImageProvider {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const IMAGES:Vector.<String> = new <String>[
			"http://static.themetapicture.com/media/funny-cats-playing-box.jpg",
			"http://grumpycatpics.com/pics/26/Maybe-Things-Will-Get-Better-When-I-Grow-Up-Funny-Cats-Pic.jpg",
			"http://www.faillol.com/wp-content/uploads/2014/03/FUNNY-VIDEOS-Funny-Cats-Funny-Cat-Videos-Funny-Animals-Cats-Funny-Balloons-Compilation.jpg",
			"http://www.picturescaption.com/wp-content/uploads/funny-animal-funny-cat-and-dog-pictures-with-captions-3-35-funny-cat-and-dog-pictures-with-captions.jpg",
			"http://images2.fanpop.com/image/photos/9400000/Funny-Cats-cats-9473321-1600-1200.jpg",
			"http://itsfunny.org/wp-content/uploads/2013/01/Very-funny-cat.jpg",
			"http://www.funcage.com/blog/wp-content/uploads/2014/06/26-Funny-Cats-On-Internet-007.jpg",
			"http://www.dumpaday.com/wp-content/uploads/2012/09/bad-cats-funny-cats.jpg",
			"http://www.funnycatpictures.net/wp-content/uploads/2012/05/cute-funny-cat.jpg",
			"http://1-ps.googleusercontent.com/x/www.dailydawdle.com/images.dailydawdle.com/wtf-hilarious-funny-nicholas-cage-cats3.jpg",
			"http://www.spoof99.com/wp-content/uploads/2013/10/Seductive-cat-is-seductive.jpg",
			"http://img.youtube.com/vi/wf_IIbT8HGk/0.jpg",
			"http://cdn.quotesgram.com/img/47/29/695151022-Funny-Cats-Top-49-Most-Funniest-Grumpy-Cat-Quotes-3.jpg",
			"http://funnypicture.org/wallpaper/2015/04/funny-cat-tattoo-22-background.jpg",
			"https://aroundcat.files.wordpress.com/2014/09/funny-cats-09.jpg",
			"http://www.funnycorner.net/funny-pictures/3660/funny_cat_pictures_364.jpg",
			"http://media4.popsugar-assets.com/files/2014/09/19/978/n/1922507/4bc5042ee37fa1f9_thumb_temp_cover_file13465311411161397.xxxlarge/i/Funny-Cat-Costumes.jpg",
			"http://static.themetapicture.com/media/funny-cats-friends-all-for-one.jpg",
			"http://4.bp.blogspot.com/-CmMhAqa0F4I/TdqwYAhTFKI/AAAAAAAAANY/B6TaS_MLdh8/s1600/funny%25252Bcats%25252Bwith%25252Bfunny%25252Bsayings%25252B1.jpg",
			"http://www.bajiroo.com/wp-content/uploads/2013/05/funny-cat-pets-meme-cat-fun-humor-pics-images-photos-pic-pictures-600x.jpg",
			"http://moving-pictures.us/wp-content/uploads/2014/07/funny-cat-and-dog-pictures-with-wordsall-photos-gallery-funny-dogs-and-cats-funny-cats-hd-funny-cats-avnb1s34.jpg",
			"http://www.funnyjunksite.com/wp-content/uploads/2007/04/funny_cat_pictures_004.jpg",
			"http://funmozar.com/wp-content/uploads/2014/07/funny-cat-06.jpg",
			"http://www.bestofunworld.com/wp-content/uploads/2015/01/funny-cats-and-dogs-with-captions2.jpg",
			"http://images6.fanpop.com/image/photos/32800000/Funny-Cats-Quote-cats-32852541-400-350.jpg",
			"http://bestwallpaperqu.com/wp-content/uploads/2014/10/funny_cats_animal_pictures.jpg",
			"http://itsfunny.org/wp-content/uploads/2012/11/Funny-sayings-with-cat.jpg",
			"http://buymelaughs.com/wp-content/uploads/2013/12/Funny-Cats-Top-49-Most-Funniest-Grumpy-Cat-Quotes-25.jpg",
			"http://orig04.deviantart.net/2dcc/f/2014/125/9/f/more_funny_cat_pictures_204_by_computerguy22-d7ha2wr.jpg",
			"http://orig06.deviantart.net/a788/f/2014/125/e/e/funny_cat_meme_by_computerguy22-d7ha1be.jpg",
			"http://rack.2.mshcdn.com/media/ZgkyMDEyLzEyLzA0LzRmL3RvcDEwZnVubnljLmFVVC5qcGcKcAl0aHVtYgk5NTB4NTM0IwplCWpwZw/63df240a/c99/top-10-funny-cat-videos-on-youtube-b5cf494572.jpg",
			"http://www.dumpaday.com/wp-content/uploads/2012/12/funny-cats-and-dogs.jpg",
			"http://buymelaughs.com/wp-content/uploads/2013/12/Funny-Cats-Top-49-Most-Funniest-Grumpy-Cat-Quotes-46.jpg",
			"http://www.catdogfoto.com/wp-content/uploads/2015/10/Funny-Cats-and-Kittens-Meowing-Compilation-picture.jpg",
			"http://www.catdogfoto.com/wp-content/uploads/2015/10/funny-cat-pictures-i-farted-with-captions.jpg",
			"http://www.dfordog.co.uk/user/images/funnies/funny-dog-cat-pic-07.jpg",
			"http://serving.pics/images/2015/02/26/Funny-Cat-3539.jpg",
			"http://itsfunny.org/wp-content/uploads/2013/04/Funny-cat-with-sayings.jpg",
			"http://weknowmemes.com/wp-content/uploads/2012/09/remotely-funny-cat.jpg",
			"http://i1.ytimg.com/vi/ZBAGEeOms-8/hqdefault.jpg",
			"http://images1.fanpop.com/images/image_uploads/Funny-Cat-Pictures-cats-935660_437_337.jpg",
			"http://wallpapers.hdwallpaperhdpictures.in/plog-content/images/images3/funny-images/cats-funny-cats-scottish-fold_1600x1200_97981.jpg",
			"http://milkymilky.com/wp-content/uploads/2014/04/funny-cats-compilation-funny-cat.jpg",
			"http://fb-timeline-cover.com/covers/download/Two%252520Funny%252520Cats%252520Eating.jpg",
			"http://www.wallcdn.com/wp-content/uploads/2015/05/Funny-Cat-Sleeping-HD-Wallpaper.jpg",
			"http://images2.fanpop.com/images/photos/4100000/Funny-Cats-animal-humor-4172464-453-604.jpg",
			"http://cl.jroo.me/z3/I/y/8/d/a.baa-cat-playing-a-guitar.jpg",
			"http://static.fjcdn.com/pictures/Funny%252Bcats%252Bdiscussion%252Bbigger%252Bbrother%252Bis%252Balways%252Ba%252Bboss_7c135f_3466588.jpg",
			"http://1.bp.blogspot.com/-dyQr3n1blVM/UFlJzkb3ltI/AAAAAAAACfI/-dcrAMN_V7s/s1600/Funny%252BCat%252BPics%252B132.jpg",
			"http://www.bandofcats.com/wp-content/uploads/2010/03/funny-cat-pictures_01.jpg",
			"http://smartgoal.net/freevideo/wp-content/uploads/2015/09/hqdefault302.jpg",
			"http://allhumorpic.com/wp-content/uploads/funny-cats-camera-cheese.jpg",
			"http://allhumorpic.com/wp-content/uploads/funny-cats-fight-orange.jpg",
			"http://milkymilky.com/wp-content/uploads/2014/03/epic-funny-cats-cute-cats-compil.jpg",
			"https://i.ytimg.com/vi/sDswnFLuifY/hqdefault.jpg",
			"https://s-media-cache-ak0.pinimg.com/236x/d2/68/d5/d268d5aba09526665d72c42bc7817f1c.jpg",
			"http://i.ytimg.com/vi/tjSF3E8hcFw/hqdefault.jpg",
			"http://thumbpress.com/wp-content/uploads/2013/04/Funny-Cat-Pictures-with-Captions-25.jpg",
			"http://www.dumpaday.com/wp-content/uploads/2012/12/cat-shaming-funny-cats.jpg",
			"http://www.spoof99.com/wp-content/uploads/2013/10/Go-cry-emo-kid.jpg",
			"http://i.ytimg.com/vi/YDdueeBf7MY/0.jpg",
			"https://s-media-cache-ak0.pinimg.com/236x/7a/7b/7f/7a7b7f1b4666763b1ca6f8ff69e7a785.jpg",
			"http://nicepixy.com/wp-content/uploads/2013/08/funny-pictures-blog-198.jpg",
			"http://cdn.resimkoy.net/2015/07/24/cute-and-funny-cats-dogs.jpg",
			"http://i.ytimg.com/vi/mW3S0u8bj58/maxresdefault.jpg",
			"http://postcardpress.ru/1244-large_default/collection-funny-cats.jpg",
			"http://milkymilky.com/wp-content/uploads/2014/06/funny-videos-funny-cats-funny-ca1.jpg",
			"http://static.boredpanda.com/blog/wp-content/uploads/2015/09/funny-cats-being-jerks-latest.jpg",
			"http://img.memecdn.com/two-funny-cats-that-made-a-big-mess-in-the-house_o_5048585.jpg",
			"http://thumb1.shutterstock.com/display_pic_with_logo/139051/302691488/stock-photo-funny-cats-self-picture-selfie-stick-in-his-hand-couple-of-cat-taking-a-selfie-together-with-302691488.jpg",
			"http://www.wallpaperslibrary.com/w/funny/funny-cats/funny-cats-sleeping.jpg",
			"http://milkymilky.com/wp-content/uploads/2014/06/funny-cat-videos-funny-dog-video.jpg",
			"http://images1.fanpop.com/images/image_uploads/Funny-Cat-Pictures-cats-935716_502_379.jpg",
			"http://funnyfamilywallpaper.com/wp-content/uploads/2015/04/funny-caption-about-cats-3.jpg",
			"http://drodd.com/images8/funny-cat-captions5.jpg"
		];

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function SimpleImageProvider() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private const _imageReadySignal:ImageReadySignal = new ImageReadySignal();

		public function get imageReady():ISignal {
			return _imageReadySignal;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _preparedQueue:Vector.<BitmapData> = new Vector.<BitmapData>();

		private var _nextIndex:int = 0;

		private var _pendingPreparesCount:int = 0;

		private var _loading:Boolean = false;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function prepareNextImage():void {
//			if (_loading) {
//				_pendingPreparesCount++;
//				return;
//			}

			if (!IMAGES.length) {
				loadImageList();
				_pendingPreparesCount++;
				return;
			}

			_nextIndex++;
			if (_nextIndex >= IMAGES.length) _nextIndex = 0;

			var url:String = IMAGES[_nextIndex];
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.handler_loadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.handler_loadFailed);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handler_loadFailed);
			loader.load(new URLRequest(url));
			_loading = true;
			trace('start loading: ' + url);
		}

		public function get prepared():Boolean {
			return _preparedQueue.length > 0;
		}

		public function getNextImage():BitmapData {
			return _preparedQueue.shift() as BitmapData;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function loadImageList():void {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function(event:Event):void {
				parseResult(loader.data);
			});
			// google sometimes thinks I'm bot and returns error
			// so I parsed response by regexp and inserted in in IMAGES manually
			var req:URLRequest = new URLRequest('https://www.google.ru/search?q=funny+cats&newwindow=1&safe=off&sei=ncEsVpKpGOX7ywP5w7bQAw&biw=1920&bih=395&tbm=isch&ijn=3&ei=ncEsVpKpGOX7ywP5w7bQAw&start=300&ved=0CC4QuT0oAWoVChMI0uvP6sbdyAIV5f1yCh35oQ06&vet=10CC4QuT0oAWoVChMI0uvP6sbdyAIV5f1yCh35oQ06.ncEsVpKpGOX7ywP5w7bQAw.i');
			loader.load(req);
		}

		private function parseResult(data:String):void {
			var strings:Array = data.match(/imgurl=(http(?! )[^\s]*.jpg)/g);
			for each (var s:String in strings) {
				IMAGES.push(s.replace('imgurl=', ''));
			}
			var pendingCnt:int = _pendingPreparesCount;
			while(pendingCnt--) {
				prepareNextImage();
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function handler_loadComplete(event:Event):void {
			var info:LoaderInfo = event.target as LoaderInfo;
			info.removeEventListener(Event.COMPLETE, this.handler_loadComplete);
			info.removeEventListener(IOErrorEvent.IO_ERROR, this.handler_loadFailed);
			info.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handler_loadFailed);

			_loading = false;
			trace('loading complete: ' + info.url);

			var result:BitmapData = (info.content as Bitmap).bitmapData;
			if (!result) {
				prepareNextImage();
			} else {
				_preparedQueue.push(result);

				if (_pendingPreparesCount > 0) {
					_pendingPreparesCount--;
					prepareNextImage();
				}

				_imageReadySignal.dispatch();
			}
		}

		/**
		 * @private
		 */
		private function handler_loadFailed(event:Event):void {
			var info:LoaderInfo = event.target as LoaderInfo;
			trace('loading error: ' + info.url);

			_loading = false;
			prepareNextImage();
		}
	}
}
