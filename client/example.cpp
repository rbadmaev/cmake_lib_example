#include "MyLib/MyLibPublic.h"

#include <iostream>

int main() {
	const auto fooResult = myLib::foo();
	std::cout << int(fooResult) << std::endl;
}
