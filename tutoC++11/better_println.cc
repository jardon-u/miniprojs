#include <iostream>
#include <vector>
#include <boost/variant.hpp>

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
void println(const Args&... args)
{
  for (auto v: iterable(args...))
    std::cout << v << " ";
  std::cout << std::endl;
}

int main()
{
  std::string s = "foo";
  println(5,s,8.9);
}
