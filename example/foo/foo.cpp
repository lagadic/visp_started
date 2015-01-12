//! \example foo.cpp Provided example.
#include <iostream>

#include <visp/vpImage.h>

#include <my/myFoo.h>

int main()
{
  std::cout << "Call the constructors..." << std::endl;
  myFoo foo;
  vpImage<unsigned char> I;
  std::cout << "The end." << std::endl;

  return 0;
}
