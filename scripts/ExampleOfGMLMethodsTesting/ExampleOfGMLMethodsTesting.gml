// Tip - you can hide fixtures from Feather's `new` autocomplete with @ignore (but it still keeps @description for tooltip)
///@description A custom fixture that tests how GML methods behave
///@ignore
function ExampleOfGMLMethodsTestingFixture() : DefaultFixture() constructor {
	
	function setup() {
		
		struct = { the_string : "should be in the string(self)", func : function() { return string(self) } }
		
		copy_1 = struct.func;
		copy_2 = variable_struct_get(struct, "func");
		
	}
	
	function tear_down() {
		
		struct = undefined;
		
		copy_1 = undefined;
		copy_2 = undefined;
		
	}
	
}

GMUT().test(ExampleOfGMLMethodsTestingFixture, "Method's pointer should be equal to its copy's pointer", function() {
	
	GMUT().expect_equal(struct.func, copy_1);
	GMUT().expect_equal(struct.func, copy_2);
	GMUT().expect_equal(ptr(struct.func), ptr(copy_1));
	GMUT().expect_equal(ptr(struct.func), ptr(copy_2));
	
});

GMUT().test(ExampleOfGMLMethodsTestingFixture, "Method and its copy should have the same `self`", function() {
	
	// Feather ignore GM2023
	GMUT().expect_equal(struct.func(), copy_1());
	GMUT().expect_equal(struct.func(), copy_2());
	
});