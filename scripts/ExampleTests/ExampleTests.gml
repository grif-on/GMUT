///@description A custom fixture that tests obj_book
function MyFixture() : DefaultFixture() constructor {
	
	instance = noone;
	
	function setup(){
		// Before we execute the test let's create the instance we will be testing
		// This way we don't have to duplicate code everywhere to do our tests
		instance = instance_create_depth(0,0,0, obj_book);
	}
	
	function tear_down(){
		// After we are done testing let's clean up and destroy the instance to keep things clean
		instance_destroy(instance);
	}
	
}

// Fixture test showing basic usage
GMUT().test(MyFixture, "NotVisibleByDefault", function() {
	/// The function has access to the variables declared in MyFixture
	GMUT().expect_false(instance.visible);
});

// Disabled fixture test showing basic usage
GMUT().test_draft(MyFixture, "NameIsBlankByDefault", function() {
	GMUT().expect_equal("blank", instance.name);
});