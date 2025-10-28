function GMUT() constructor {
	
	STATIC_CLASS
	
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
	
}

STATIC_CLASS_INIT(GMUT);

/*
GMUT.run_tests();
show_debug_message("next line should throw an error");
var _test = new GMUT();
_test.run_tests();
*/