#include <iostream>

// println
void println() {
  std::cout << std::endl;
}
template <typename T, typename ...Args>
void println(const T& value, const Args&... args)
{
  std::cout << value << " ";
  println(args...);
}

int main()
{
  println(5,"foo",8.9,5);
}
