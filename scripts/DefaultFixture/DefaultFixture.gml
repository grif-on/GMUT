///@description Base struct that all fixtures should extend from
function DefaultFixture() constructor {
	
	///@description Called before the execution of the test.
	///             Use this function to setup your fixtures and parameterized tests.
	function setup(){
		// Override this function
	}
	
	///@description Called after the execution of the test.
	///             Use this function to clean up your fixtures and parameterized tests.
	function tear_down(){
		// Override this function
	}
	
}