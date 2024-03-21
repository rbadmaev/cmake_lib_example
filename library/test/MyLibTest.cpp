#include "MyLibPrivate.h"
#include "MyLibPublic.h"

#include <boost/test/unit_test.hpp>

using namespace myLib;

BOOST_AUTO_TEST_SUITE(MyLibTest)

//======================================================================================================================
BOOST_AUTO_TEST_CASE(fooTest)
{
    BOOST_CHECK_NO_THROW(foo());
}

//======================================================================================================================
BOOST_AUTO_TEST_CASE(barTest)
{
    BOOST_CHECK_NO_THROW(bar());
}

BOOST_AUTO_TEST_SUITE_END()
