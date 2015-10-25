package command {

	import config.IGalleryConfig;

	import model.ImageData;
	import model.ImageListData;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 14:24
	 */
	public class InitGalleryCommand extends Command {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function InitGalleryCommand() {
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
		public var galleryConfig:IGalleryConfig;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function execute():void {
			super.execute();

			for (var i:int = 0; i < galleryConfig.imageCount; i++) {
				var data:ImageData = new ImageData();
				imageList.addImage(data);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}
