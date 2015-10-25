package {

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import org.robotlegs.core.IContext;

	import org.robotlegs.mvcs.Context;

	import view.Gallery;
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @langversion         3.0
	 * @date                18.10.2015 12:16
	 */
	public class Main extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		[SWF(widthPercent="100", heightPercent="100")]
		public function Main() {
			super();

			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _context:IContext;

		private var _gallery:Gallery;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function init(event:Event = null):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			stage.align = StageAlign.TOP_LEFT;

			_gallery = new Gallery();
			addChild(_gallery);

			_context = new AppContext(_gallery);
		}

	}
}
