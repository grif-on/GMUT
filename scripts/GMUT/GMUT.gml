// Feather ignore once GM1030
#macro GMUT { STATIC_CLASS_INIT(GMUTNamespace); } GMUTNamespace

GMUT.set_deterministic(true);

function tmut() {
	
	static private_variable = 42;
	
	static private_strings = [
		"a",
		"b",
		"c"
	];
	
	///@description Start running the unit tests
	static run_tests = function() {
		show_debug_message("==> " + string(tmut.private_variable) + tmut.private_strings[1]);
		return true;
	}
	
	///@description Sets the seed to a static value or a random value. Can be toggled.
	///@param {Bool} deterministic Whether to set the seed to a static value or not
	static set_deterministic = function(deterministic) {
		if (deterministic){
			random_set_seed(0);
		}
		else{
			random_set_seed(global.GMLTestManager._seed);
		}
		return true;
	}
	
	static export = { run_tests, set_deterministic };
	return export;
	
}

// show_debug_message(tmut.private_strings); // still illegal to access them before first call

tmut().run_tests();

show_debug_message(tmut.private_strings); // but at least now it is by design are not intended to be done, since private yare yare yare

tmut().run_tests();




function GMUTNamespace() constructor {
	
	STATIC_CLASS
	
	#region Framework control
		
		///@description Start running the unit tests
		static run_tests = function() {
			global.GMLTestManager.execute();
			return 5;
		}
	
		///@description Sets the seed to a static value or a random value. Can be toggled.
		///@param {Bool} deterministic Whether to set the seed to a static value or not
		static set_deterministic = function(deterministic) {
			if (deterministic){
				random_set_seed(0);
			}
			else{
				random_set_seed(global.GMLTestManager._seed);
			}
			return 5;
		}
		
	#endregion
	
	#region Matchers
		
		///@description Expects that the actual value is equal to the expected value
		///@param {*} expected
		///@param {*} actual
		static expect_equal = function(expected, actual) {
			_gmltest_throw_result(expected, actual, expected == actual);
		}
		
		///@description Expects that the actual value is not equal to the expected value
		///@param {*} expected
		///@param {*} actual
		static expect_not_equal = function(expected, actual) {
			_gmltest_throw_result(expected, actual, expected != actual);
		}
		
		///@description Expects that the provided value is false
		///@param {*} value
		static expect_false = function(value) {
			GMUT.expect_equal(false, value);
		}
		
		///@description Expects that the provided value is true
		///@param {*} value
		static expect_true = function(value) {
			GMUT.expect_equal(true, value);
		}
		
		///@description Expects that the actual value is greater than the expected value
		///@param {*} expected
		///@param {*} actual
		static expect_greater_than = function(expected, actual) {
			_gmltest_throw_result(expected, actual, expected < actual);
		}
		
		///@description Expects that the actual value is less than the expected value
		///@param {*} expected
		///@param {*} actual
		static expect_less_than = function(expected, actual) {
			_gmltest_throw_result(expected, actual, expected > actual);
		}
		
		///@description Expects that the provided value is null
		///@param {*} value
		static expect_null = function(value) {
			_gmltest_throw_result("null", value, _gmltest_is_null(value));
		}
		
		///@description Expects that the provided value is not null
		///@param {*} value
		static expect_not_null = function(value) {
			_gmltest_throw_result("not null", value, !_gmltest_is_null(value));
		}
		
	#endregion
	
}

/*
GMUT.run_tests();
show_debug_message("next line should throw an error");
var _test = new GMUT();
_test.run_tests();
*/