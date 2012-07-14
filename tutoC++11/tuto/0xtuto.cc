///
/// Introduction to C++0x: Tutorial.
/// Ugo Jardonnet - December 12, 2009
///


// Compile this file as follow:
// $ g++ --std=c++0x -Wall -Wextra 0xtuto.cc
// with gcc >= 4.5


#include <list>
#include <string>
#include <cmath>
#include <algorithm>
#include <numeric>
#include <vector>
#include <iostream>

#include <array> // C++0x static container
#include <initializer_list>



// A classic C++ struct
struct number
{
  int i;
  std::string s;
};

//Uniform initialization (>= g++ 4.4)
//-----------------------------------
void uniform_initialization()
{
  //C++0x provides a new standard way for initialization
  int i{4};
  std::string s{"string"};

  number t{3, "three"};
  number u = {3, "three"};

  // Note that the following syntax is now valid C++
  // number f() { return {4, "smth"}; };
  // The output (type: number) is initialized with {4, "smth"}
}



//Initializer list (>= g++ 4.4)
//-----------------------------
void initializer_list()
{
  //Standard containers may now be initialized using initializer list
  std::vector<int> vec = {100, 200 ,35, 44};
  std::list<std::string> list{"one", "two", "three"};

  //You may implement this functionality for your own class
  class my_class
  {
  public:
    my_class(std::initializer_list<int> list) { (void) list; };
    int a;
    int b;
  };

  my_class a{5,6,7};
  my_class b = {5,6,7};

  my_class c = {5,6};

  //Can you develop a case where the initialization of a struct is ambiguous ?
  // -*- initializer list vs direct attribute initialization
}



//Type inference
//--------------
void type_inference()
{
  //keyword 'auto' infers the type of the variable you declare
  std::vector<int> v = {3,4,6};
  for (auto i = v.begin(); i != v.end(); i++)
    /* DO SOMETHING */;

  // 1. Observe the type of auto w{1,2,3}
  // -*- auto w{1,2,3}; // w [initializer_list<int>]
  // 2. What happen if you try to do: auto x{1,2,3.5} ?
  // -*- error: unable to deduce ‘std::initializer_list<_Tp>’
  //     from ‘{1, 2, 3.5e+0}’
}

// lambda function
void lambda_function()
{
  auto myLambda = [](float a, float b) {
    return std::abs(a) < std::abs(b);
  };
}

template <class C>
typename C::value_type sum(const C& a)
{
  return std::accumulate(a.begin(),a.end(),0);
}

// std::array
void standard_array()
{
  std::array<int,6> a = {{1, 2, 3}};
  a[3] = 4;
  int x = a[5]; // x becomes 0 because default elements are zero initialized
  int s = sum(a);
}

// Range-based for gcc 4.6
void range_based_for()
{
  std::vector<int> array = {1, 2, 3, 4, 5};
  int sum = 0;
  for (auto x : array)  {
    sum += x;
  }
}



// Introduction to C++0x
int main()
{
  uniform_initialization();
  type_inference();
  lambda_function();
  standard_array();
  range_based_for();
}

