#include <initializer_list>
#include <iostream>
#include <vector>

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
  auto v = {1,2,3,4,5};
  for (auto e : v)
    println("- ", e);
}
