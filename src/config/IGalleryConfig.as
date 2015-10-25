package config {
	
	public interface IGalleryConfig {

		/**
		 * Height of previews (width will be calculated automatically)
		 */
		function get previewHeight():Number;

		/**
		 * Margin between previews in pixels
		 */
		function get previewMargin():Number;

		/**
		 * Size of image preview border
		 */
		function get previewBorderSize():Number;

		/**
		 * Total images in gallery
		 */
		function get imageCount():int;
	}
}
