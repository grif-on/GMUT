// Feather ignore once GM2017
///@description This function returns "namespace" struct with all public functions in it.
///@description All interactions with framework, except for definition of fixture constructors, should be done via "GMUT()." syntax.
///@description Do not access anything via "GMUT." syntax unless you know what you are doing.
function GMUT() {
	
	// Things below are public
	
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
	
	#region Test declaration function
		
		///@description Register test with a fixture, name, and a function to execute.
		///@description You can optionally provide an array with parameters.
		///@param {Function.DefaultFixture} _fixture The struct to use as the fixture when the test executes
		///@param {String} _name The name of the test to be logged to the console
		///@param {Function} _tested_function The function to be executed
		///@param {Array} _parameters_array Provided function will be executed once for each element of this array, receiving that element as its sole argument
		static test = function(_fixture, _name, _tested_function, _parameters_array = []){
			_gmltest_create_manager();
			var _new_test = new GMUT.Test();
			_new_test._fixture = _fixture;
			_new_test._name = _name;
			_new_test._fn = _tested_function;
			_new_test._array = _parameters_array;
			global.GMLTestManager.add_test(_new_test);
		}
		
		///@description Register draft test with a fixture, name, and a function to execute.
		///@description You can optionally provide an array with parameters.
		///@description Draft tests serve as playground for more smooth introduction of tests.
		///@description Their pass/fail statistics gathered sepparately of reggular test.
		///@param {Function.DefaultFixture} _fixture The struct to use as the fixture when the test executes
		///@param {String} _name The name of the test to be logged to the console
		///@param {Function} _tested_function The function to be executed
		///@param {Array} _parameters_array Provided function will be executed once for each element of this array, receiving that element as its sole argument
		static test_draft = function(_fixture, _name, _tested_function, _parameters_array = []) {
			_gmltest_create_manager();
			var _new_test = new GMUT.Test();
			_new_test._fixture = _fixture;
			_new_test._name = _name;
			_new_test._fn = _tested_function;
			_new_test._array = _parameters_array;
			_new_test._disabled = true;
			global.GMLTestManager.add_test(_new_test);
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
	
	// Things below are private
	
	#region Tests representation
	
	// Feather ignore once GM2017
	///@description Test struct used to hold the registered test data for later execution
	static Test = function() constructor {
		
		_fixture = DefaultFixture;
		_name = "";
		_fn = noone;
		_array = noone;
		_disabled = false;
		
		function get_name(){
			var result = "";
			var temp = new _fixture();
			result = instanceof(temp) + "::";
			delete temp;
			result += _name;
			return result;
		}
		
	}
	
	#endregion
	
	static namespace_export = {
		run_tests, set_deterministic,
		expect_equal, expect_not_equal, expect_true, expect_false, expect_greater_than, expect_less_than,
		test, test_draft
	};
	return namespace_export;
	
}