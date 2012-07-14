#include <iostream>
#include <vector>

template <typename T, typename ...Args>
void init(T& vec, const Args&... args)
{
  vec = {args...};
}

int main()
{
  std::vector<int> b = {1,2,3,4,5};
  init(b, 1,2,3,4,5);
}
