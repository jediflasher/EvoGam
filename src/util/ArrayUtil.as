package util {
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                25.10.2015 16:07
	 */
	public class ArrayUtil {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function mergeSorted(array1:Array, array2:Array):Array {
			if (array1.length == 1 && array2.length == 1) return [array1[0], array2[0]];

			var result:Array = [];
			var i:int = 0;
			var j:int = 0;
			var k:int = 0;
			var a1Len:int = array1.length;
			var a2Len:int = array2.length;
			var ascending:Boolean = array1.length > 1 ? array1[0] < array1[1] : array2[0] < array2[1];

			while (i < a1Len && j < a2Len) {
				if (array1[i] < array2[j] && ascending) {
					result[k++] = array1[i++];
				} else {
					result[k++] = array2[j++];
				}
			}

			while (i < a1Len) result[k++] = array1[i++];
			while (j < a2Len) result[k++] = array2[j++];

			return result;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ArrayUtil() {
			super();
		}
	}
}
