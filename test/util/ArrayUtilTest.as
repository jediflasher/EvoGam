package util {

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                25.10.2015 16:04
	 */
	public class ArrayUtilTest {

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		[Test]
		public function sort_ascending():void {
			var a1:Array = [1, 3, 6, 15];
			var a2:Array = [-4, 0, 2];
			var expected:Array = [-4, 0, 1, 2, 3, 6, 15];
			var result:Array = ArrayUtil.mergeSorted(a1, a2);

			assertThat(result, equalTo(expected));
		}

		[Test]
		public function sort_descending():void {
			var a1:Array = [1, 3, 6, 15].reverse();
			var a2:Array = [-4, 0, 2].reverse();
			var expected:Array = [-4, 0, 1, 2, 3, 6, 15].reverse();
			var result:Array = ArrayUtil.mergeSorted(a1, a2);

			assertThat(result, equalTo(expected));
		}
	}
}
