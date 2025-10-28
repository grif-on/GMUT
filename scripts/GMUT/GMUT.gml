function GMUT() constructor {
	
	static static_init_is_done = false;
	if (static_init_is_done) {
		throw("GMUT is a namespace (fully static class), you can't have insatnce of it!");
	}
	static_init_is_done = true;
	
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

while (true) {
	// Unfortunatelly to create class with only static methods/variables we still need to initialise at least one instance of it
	var _dummy_init = new GMUT();
	_dummy_init = undefined; // Errase instance, since local variables in gml is local to whole script file and not thier {} :|
	break;
}