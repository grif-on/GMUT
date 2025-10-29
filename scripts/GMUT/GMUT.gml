// Feather ignore once GM2017
function GMUT() {
	
	#region Framework control
		
		///@description Start running the unit tests
		static run_tests = function() {
			global.GMLTestManager.execute();
		}
	
		///@description Sets the seed to a static value or a random value. Can be toggled.
		///@param {Bool} _deterministic Whether to set the seed to a static value or not
		static set_deterministic = function(_deterministic) {
			if (_deterministic){
				random_set_seed(0);
			}
			else{
				random_set_seed(global.GMLTestManager._seed);
			}
		}
		
	#endregion
	
	#region Matchers
		
		///@description Expects that the actual value is equal to the expected value
		///@param {*} _expected
		///@param {*} _actual
		static expect_equal = function(_expected, _actual) {
			_gmltest_throw_result(_expected, _actual, _expected == _actual);
		}
		
		///@description Expects that the actual value is not equal to the expected value
		///@param {*} _expected
		///@param {*} _actual
		static expect_not_equal = function(_expected, _actual) {
			_gmltest_throw_result(_expected, _actual, _expected != _actual);
		}
		
		///@description Expects that the provided value is true
		///@param {*} _value
		static expect_true = function(_value) {
			GMUT().expect_equal(true, _value);
		}
		
		///@description Expects that the provided value is false
		///@param {*} _value
		static expect_false = function(_value) {
			GMUT().expect_equal(false, _value);
		}
		
		///@description Expects that the actual value is greater than the expected value
		///@param {*} _expected
		///@param {*} _actual
		static expect_greater_than = function(_expected, _actual) {
			_gmltest_throw_result(_expected, _actual, _expected < _actual);
		}
		
		///@description Expects that the actual value is less than the expected value
		///@param {*} _expected
		///@param {*} _actual
		static expect_less_than = function(_expected, _actual) {
			_gmltest_throw_result(_expected, _actual, _expected > _actual);
		}
		
	#endregion
	
	static public = {
		run_tests, set_deterministic,
		expect_equal, expect_not_equal, expect_true, expect_false, expect_greater_than, expect_less_than
		};
	return public;
	
}