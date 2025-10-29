# GMUT
GameMaker Unit Testing framework 

## About fork
This fork is refactored and improved version of [original gms2-test by pmarincak](https://github.com/pmarincak/gms2-test).

You can read about my changes and reasons behind each and all of them [in respective chapter of README](#what-will-be-changed-in-this-fork). But tl:dr of goals are - same framework workflow but powered by modern gml features.

If you are interested in HOW unit tests frameworks are working then i'm hightly encourage you to check out the original gms2-test before digging in to mine :)

## Table of Contents

 1. [Requirements](#requirements)
 2. [Download & install](#download--install)
 3. [Maintainers & contribution](#maintainers--contribution)
 4. [API](#api)
    - [Framework control](#framework-control)
    - [Matchers](#matchers)
    - [Test definitions](#test-definitions)
 5. [Unit testing resources](#unit-testing-resources)
 6. [What (will be) changed in this fork](#what-will-be-changed-in-this-fork)
    - [Why?](#why)

## Requirements

Works on GameMaker IDE/Runtime versions :
- v2024.4.1
- v2024.13.1
- and i guess anything newer in future

## Download & install

Clone repo and generate .yymps file from everything that in "GMUT" project folder. 

I don't have any intentions to make a release versions and/or exported .yymps files. Sorry.

## Maintainers & contribution
Original author is [Paige Marincak](https://twitter.com/paigemarincak/). Current maintainer is [Grif_on](https://github.com/grif-on).

To contribute, please fork the repo and make pull requests.

## API
### Framework control

#### GMUT().run_tests()
Start running the unit tests

#### GMUT().set_deterministic(_deterministic)
Sets the seed to a static value or a random value. Can be toggled.

    @param {Bool} _deterministic Whether to set the seed to a static value or not

### Matchers

#### GMUT().expect_equal(_expected, _actual)
Expects that the actual value is equal to the expected value

    @param {*} _expected
    @param {*} _actual

#### GMUT().expect_not_equal(_expected, _actual)
Expects that the actual value is not equal to the expected value

    @param {*} _expected
    @param {*} _actual

#### GMUT().expect_true(_value)
Expects that the provided value is true

    @param {*} _value

#### GMUT().expect_false(_value)
Expects that the provided value is false

    @param {*} _value

#### GMUT().expect_greater_than(_expected, _actual)
Expects that the actual value is greater than the expected value

    @param {*} _expected
    @param {*} _actual

#### GMUT().expect_less_than(_expected, _actual)
Expects that the actual value is less than the expected value

    @param {*} _expected
    @param {*} _actual

### Test definitions

**!!!!! WIP !!!!!**

#### GMLTest_Harness
Base struct that all harnesses should extend from

    ///@description Called before the execution of the test.
    ///             Use this function to setup your fixtures and parameterized tests.
    function setup(){
    	// Override this function
    }
	
    ///@description Called after the execution of the test.
    ///             Use this function to clean up your fixtures and parameterized tests.
    function tear_down(){
    	// Override this function
    }
#### test
Register a basic test with a name and a function to execute

    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed
#### xtest
Disable a registered basic test that has a name and a function to execute

    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed
#### test_f
Register a fixture test with a harness, name and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed

#### xtest_f
Disable a registered fixture test that has a harness, name and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed

#### test_p
Register a parameterized test with a harness, name, array of parameters, and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {Array} array An array containing a list of parameters to be executed using the same provided function
    @param {Function} fn The function to be executed which takes one parameter

#### xtest_p
Disable a registered parameterized test that has a harness, name, array of parameters, and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {Array} array An array containing a list of parameters to be executed using the same provided function
    @param {Function} fn The function to be executed which takes one parameter
    
## Unit testing resources
The following are a list of resources that can assist you with writing your unit tests. 

- [What is unit testing?](https://en.wikipedia.org/wiki/Unit_testing)
- [What is a fixture?](https://en.wikipedia.org/wiki/Test_fixture)

## What (will be) changed in this fork
Note that this is a highlight of the the most important changes. For a full list of changes see the commits.
- Renamed classes/functions
    - Propper PascalCase and more understandable names
        - `GMLTest_Harness` --> `DefaultFixture`
    - Replaced disabling prefix `x` with draft suffix `_draft`
        - `xtest()` --> `GMUT().test_draft()`
- Changing of architecture
    - Replaced all global functions with methods in GMUT class/"namespace"
        - `gmltest_start()` --> `GMUT().run_tests()`
        - `gmltest_expect_eq()` --> `GMUT().expect_equal()`
        - No more ugly functions with `_` prefix in global namespace
    - Replaced `test()`/`test_f()`/`test_p()` trio with one "overloaded" function `GMUT().test()`
        - Same goes for draft (disabled) functions
    - Now you always need a fixture to register a test
        - But this alongside with overloading means that code now are much more consistent between tests - e.g. `GMUT().test(DefaultFixture, name, fn, array)`, `GMUT().test(MyFixture, name, fn)`, `GMUT().test_draft(MyAnotherFixture, name, fn, array)` and etc.
- General refactoring
    - Removal of `expect_null()`/`expect_not_null()`
        - since modern `instance_exists()` in pair with `GMUT().expect_true()`/`GMUT().expect_false()` achieve the same thing as horrible manual "null" check. GameMaker now have instance IDs typechecking under the hood!
- More readable console output
    - Tests are now explicitly grouped by fixtures

### Why?
There is two reasons - Feather and Stitch.

Even though both tools still require a lot of fundamental work to be done by their creators... the age of shitty "classic gms2" gml intellisense is at dawn. So, most of these chages are intended to modernize gms2-test for "true OOP coding" era of gml, while still keeping simplicity which are the main selling point of this framework.