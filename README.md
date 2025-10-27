# GMUT
GameMaker Unit Testing framework 

## About fork
This fork is refactored and improved version of [original gms2-test by pmarincak](https://github.com/pmarincak/gms2-test).

You can read about my changes and reasons behind each and all of them [in respective chapter of README](#what-will-be-changed-in-this-fork).

If you are interested in HOW unit tests frameworks are working then i'm hightly encourage you to check out the original original gms2-test before digging in to mine :)

## Table of Contents

 1. [Requirements](#requirements)
 2. [Download](#download)
 3. [Maintainers & contribution](#maintainers--contribution)
 4. [API](#api)
    - [GMUT "namespace"](#gmut-namespace)
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

## Download

Clone repo and generate .yymps file yourself. 

I don't have any intentions to make a release versions and/or exported .yymps files. Sorry.

## Maintainers & contribution
Original author is [Paige Marincak](https://twitter.com/paigemarincak/). Current maintainer is [Grif_on](https://github.com/grif-on).

To contribute, please fork the repo and make pull requests.

## API
### GMUT "namespace"

**!!!!! WIP !!!!!**

#### gmltest_start
Start running the unit tests

#### gmltest_set_deterministic
Sets the seed to a static value or a random value. Can be toggled.

    @param {Bool} deterministic Whether to set the seed to a static value or not

### Matchers

**!!!!! WIP !!!!!**

#### gmltest_expect_eq
Expects that the actual value is equal to the expected value

    @param {*} expected
    @param {*} actual

#### gmltest_expect_false
Expects that the provided value is false

    @param {*} value

#### gmltest_expect_true
Expects that the provided value is true

    @param {*} value

#### gmltest_expect_gt
Expects that the actual value is greater than the expected value

       @param {*} expected
       @param {*} actual

#### gmltest_expect_lt
Expects that the actual value is less than the expected value

       @param {*} expected
       @param {*} actual

#### gmltest_expect_neq
Expects that the actual value is not equal to the expected value

    @param {*} expected
    @param {*} actual

#### gmltest_expect_not_null
Expects that the provided value is not null

    @param {*} value

#### gmltest_expect_null
Expects that the provided value is null

    @param {*} value

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
- [Beginner's guide to unit testing](https://www.codementor.io/@wbsimms/unit-testing-foundations-programming-beginners-du107q81d)

## What (will be) changed in this fork
Note that this is a highlight of the the most important changes. For a full list of changes see the commits.
- Renamed classes/functions
    - A propper PascalCase for all of them
        - GMLTest_Manager --> GMUTManager
    - More understandable names
        - GMLTest_Harness --> GMUTDefaultFixture
    - Replaced disabling prefix "x" with draft suffix "_draft"
        - .xtest() --> .test_draft()
- Changing of architecture
    - Replaced test()/test_f()/test_p() trio with one "overloaded" function .test()
    - Now you always need a fixture to register a test
        - But this alongside with overloading means that code now is much cleaner - e.g. DefaultFixture.test(name, fn, array), MyFixture.test(name, fn), MyAnotherFixture.test_draft(name, fn, array)
    - Replaced all global functions with static methods in GMUT class/"namespace"
        - gmltest_start() --> GMUT.run_tests()
        - gmltest_expect_eq() --> GMUT.expect_equal()
- More readable console output
    - Tests are now explicitly grouped by fixtures

### Why?
There is two reasons - Stitch and Feather.

Even though both tools still require a lot of fundamental work to be done by their creators... the age of shitty "classic gms2" gml intellisense is at dawn. So, most of these chages are intended to modernize gms2-test for "true OOP coding" era of gml, while still keeping simplicity which are the main selling point of this framework.