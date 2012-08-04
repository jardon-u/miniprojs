
#include <iostream>
#include <vector>
#include <boost/variant.hpp>


// compute the type of v1[i] + v2[i] + ...
template<typename... T> struct sum_type;
template<typename T>    struct sum_type<T> {
  typedef typename T::value_type type;
};
template<typename T, typename... P>
struct sum_type<T,P...> {
  typedef decltype(
     typename T::value_type() + typename sum_type<P...>::type()
  ) type;
};

// sum ith element of args vectors
template <typename T>
typename T::value_type sum(std::size_t i, const T& value)
{
  return value[i];
}
template <typename T, typename... Args>
// unfortunately we cannot use decltype on recursive definition.
// May be a bug ...
typename sum_type<T, Args...>::type
sum(std::size_t i, const T& value, const Args... args)
{
  return value[i] + sum(i, args...);
}

template <typename... Args>
std::vector<int> sum_all(std::size_t size, const Args... args)
{
  std::vector<int> res(size,0);
  for (std::size_t i = 0 ; i < size; i++)
    res[i] = sum(i, args...);
  return res;
}

int main(int argc, char ** argv)
{
  std::vector<int>    a = {  1,  2, 3  };
  std::vector<double> b = { 1., 2., 3. };
  std::vector<float>  c = {  1,  2, 3  };
  auto v = sum_all(3, a,b,c);
  for (auto e : v)
    std::cout << e << std::endl;
}
