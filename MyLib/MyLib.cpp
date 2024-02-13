#include "MyLibPrivate.h"
#include "MyLibPublic.h"

#include <iostream>

myLib::MyEnum myLib::foo()
{
    std::cout << "foo" << std::endl;
    return MyEnum::Second;
}

myLib::MyPrivateEnum myLib::bar()
{
    std::cout << "bar" << std::endl;
    return MyPrivateEnum::First;
}
