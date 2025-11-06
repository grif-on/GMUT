// Parameterized test showing basic usage
// We don't need any custom setup so we will use the default fixture
var _test_cases = [1, 2, -1, 0];
GMUT().test(DefaultFixture, "IsNumericTest", function(p) {
	// The value of p is equal to 1, 2, -1, or 0
	// This function will be called each time for each value to test the values
	GMUT().expect_true(is_numeric(p));
}, _test_cases);

// Disabled parameterized test showing basic usage
// If this test was run this would cause a failure, but it won't because it is disabled
_test_cases = [undefined, noone, "blank"];
GMUT().test_draft(DefaultFixture, "IsUndefinedTest", function(p) {
	GMUT().expect_equal(undefined, p);
}, _test_cases);