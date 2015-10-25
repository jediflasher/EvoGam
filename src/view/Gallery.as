package view {

	import com.greensock.TweenNano;

	import config.IGalleryConfig;

	import flash.display.Sprite;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                24.10.2015 15:09
	 */
	public class Gallery extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Gallery() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		public var galleryConfig:IGalleryConfig;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function updateLayout():void {
			var numChildren:int = numChildren;
			var row:int = 0;
			var column:int = 0;
			var nextX:int = 0;

			for (var i:int = 0; i < numChildren; i++) {
				var child:Image = getChildAt(i) as Image;
				if (!child) continue;

				if (nextX + child.scaledWidth > stage.stageWidth) {
					nextX = 0;
					column = 0;
					row++;
				}

				var targetX:Number = nextX + child.scaledWidth / 2;
				var targetY:Number = (galleryConfig.previewHeight + galleryConfig.previewMargin) * row + child.scaledHeight / 2;

				TweenNano.to(child, 0.5, {x:targetX, y:targetY});

				nextX += child.scaledWidth + galleryConfig.previewMargin;
				column++;
			}
		}
	}
}
