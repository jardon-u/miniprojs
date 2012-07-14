#include <iostream>
#include <vector>
#include <boost/variant.hpp>

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

// better println
template <template <class...> class T, typename ...Args>
struct Fill { // Hack to parametrize boost::variant by Args
  typedef T<Args...> type;
};
template <typename ...Args>
inline
std::vector<typename Fill<boost::variant,Args...>::type>
iterable(const Args&... args)
{
  return {args...};
}

template <typename ...Args>
void print(const Args&... args)
{
  for (auto v: iterable(args...))   // WTF: Should be built-in.
    std::cout << v << " ";
  std::cout << std::endl;
}

int main()
{
  println(5,"foo",8.9);
  print(5,"foo",8.9);
}
