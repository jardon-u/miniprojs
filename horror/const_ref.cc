/*
 * if affected to a const ref
 * life time of a temporary object is extended
 * to life time of the ref
 */

#include <string>
#include <iostream>

std::string f()
{
  return "lol";
}

int main(int, char **)
{
  const std::string& r = f();

  std::cout << r << std::endl;
}
