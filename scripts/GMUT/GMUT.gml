// Feather ignore once GM2017
function GMUT() {
	
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
		
	#endregion
	
	static public = {
		run_tests, set_deterministic,
		expect_equal, expect_not_equal, expect_false, expect_true, expect_greater_than, expect_less_than
		};
	return public;
	
}