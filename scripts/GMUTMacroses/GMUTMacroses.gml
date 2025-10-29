#macro STATIC_CLASS { static static_init_is_done = false; if (static_init_is_done) { throw("\n" + string(_GMFILE_) + " is a fully static class, you can't have instatnce of it!"); } static_init_is_done = true; }
#macro STATIC_CLASS_INIT var _static_class_init_function_reserved_name = function(_class_reserved_name) { if (!variable_struct_exists(static_get(_class_reserved_name), "static_init_is_done")) { var _dummy_init_reserved_name = new _class_reserved_name(); _dummy_init_reserved_name = undefined; } } _static_class_init_function_reserved_name

function s(_class){
	STATIC_CLASS_INIT(_class);
	return static_get(_class);
}