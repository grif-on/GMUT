
s(GMUT).set_deterministic(true);

function GMUT() constructor {
	
	STATIC_CLASS
	
	#region Framework control
		
		///@description Start running the unit tests
		static run_tests = function() {
			global.GMLTestManager.execute();
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

STATIC_CLASS_INIT(GMUT);

/*
GMUT.run_tests();
show_debug_message("next line should throw an error");
var _test = new GMUT();
_test.run_tests();
*/