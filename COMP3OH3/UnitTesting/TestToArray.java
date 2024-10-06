import java.util.List;
import java.util.Arrays;

public class TestToArray {
	List<String> list = Arrays.asList("M", "T", "W", "Th", "F", "S", "Su");

	void testToArray_SameSize() {
		String[] array1 = new String[5];
		String[] array2 = list.toArray(array1);
		if (array1 != array2) {
			throw new AssertionError("Test same size: False");
		}
	}

	void testToArray_tooShort() {
		String[] array1 = new String[5];
		String[] array2 = list.toArray(array1);
		System.out.println(String.format("Test same size: %b", array1 != array2));
	}

	void testToArray_tooLong() {
		String[] array1 = new String[5];
		String[] array2 = list.toArray(array1);
		System.out.println(String.format("Test same size: %b", array1 != array2));
	}

	public static void main(String[] args) {
		new TestToArray().testToArray_SameSize();
	}

}
