function GMUT() constructor {
	
	STATIC_CLASS
	
	show_debug_message("static class init code running ...");
	
	static variable = 42;
	
	static strings = [
		"a",
		"b",
		"c"
	];
	
	static run_tests = function() {
		show_debug_message("==> " + string(GMUT.variable) + GMUT.strings[1]);
	}
	
}

STATIC_CLASS_INIT(GMUT);

/*
GMUT.run_tests();
show_debug_message("next line should throw an error");
var _test = new GMUT();
_test.run_tests();
*/