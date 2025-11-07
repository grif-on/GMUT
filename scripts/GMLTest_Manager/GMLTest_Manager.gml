///@description Struct used to manage and execute all registered tests
function GMLTest_Manager() constructor {
	_tests = [];
	_failCount = 0;
	_disabledCount = 0;
	_testCount = 0;
	_seed = random_get_seed();
	
	///@description Get the status string for whether there was a pass or a fail
	///@param {Bool} passed
	_get_status_string = function(passed){
		return passed ? "PASSED" : "FAILED";
	}
	
	///@description Run a fixture test
	///@param {Struct} test
	_run_test = function (test) {
		var _parameterized = true;
		var _call_count = 1;
		if (test._array == noone || (is_array(test._array) && array_length(test._array) == 0)) {
			_parameterized = false;
		}
		else {
			_call_count = array_length(test._array);
		}
		for (var i = 0; i < _call_count; i++) {
			var passed = true;
			var _parameterized_suffix = _parameterized ? "::" + string(i) : "";
			var testName = test.get_name() + _parameterized_suffix;
			_gmltest_log_status("RUN", testName);
			_testCount++;
			
			var fixture = new test._fixture();
			fixture.setup();
			var fn = method(fixture, test._fn);
			try {
				if (_parameterized) {
					fn(test._array[i]);
				}
				else {
					fn();
				}
			} catch (e){
				passed = false;
				_handleException(e);
			}
			fixture.tear_down();
			delete fixture;
				
			var statusString = _get_status_string(passed);
			_gmltest_log_status(statusString, testName);
		}
	}
	
	///@description Handles any exceptions thrown during the execution of the test
	///@param {Struct} e
	_handleException = function (e){
		_failCount++;
		show_debug_message(e.message);
		// If we threw an exception and it wasn't because an expect failed, we should log the callstack to the user
		if (!variable_struct_exists(e, "expectFailed")){
			_gmltest_log_callstack(e.stacktrace);
		}
	}
	
	///@description Execute the provided test struct
	///@param {Struct} test
	_execute_test = function (test) {
		if (test._disabled){
			_disabledCount++;
			_gmltest_log_status("DISABLED", test.get_name());
			return;
		}
		
		_run_test(test);
	}
	
	///@description Execute all registered tests
	execute = function () {
		var testCount = array_length(_tests);
		var startTime = current_time;
		
		show_debug_message("===============================================================");
		for (var i = 0; i < testCount; i++){
			var test = _tests[i];
			_execute_test(test);
		}
		
		var endTime = current_time;
		var timeToRun = endTime - startTime;
		
		show_debug_message("===============================================================");
		show_debug_message("RAN " + string(_testCount) + " TESTS IN " + string(timeToRun) + "MS.");
		if (_failCount > 0){
			show_debug_message("FAILED TESTS: " + string(_failCount));
		}
		else {
			show_debug_message("ALL TESTS ARE PASSED.");
		}
		if (_disabledCount > 0){
			show_debug_message("DISABLED TESTS: " + string(_disabledCount));
		}
		else {
			show_debug_message("NO DISABLED TESTS.");
		}
		show_debug_message("===============================================================");
	}
	
	///@description Adds a test to this manager
	///@param {Struct} test
	add_test = function(test){
		array_set(_tests, array_length(_tests), test);
	}
}