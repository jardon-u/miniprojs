#include <iostream>
#include <cmath>

//class array

template < int i >
class array;

template <>
class array<0>
{
public:
  static int val;
};

template <int i>
class array
{
public:
  static int val;
  array<i-1> pred;
};

template < int i >
class next
{
};

// static loop

int array<0>::val = 0;
template < int i >
int array<i>::val = cos(i)* 100;


//wrap

template <template <int> class T,
          int i>
struct unique
{
  T<i> tab;
};


//dynamic loop

template < int i >
void for_all(array<i> a); 

template <>
void for_all(array<0> a)
{
  std::cout << a.val << std::endl;
}

template < int i >
void for_all(array<i> a)
{
  std::cout << a.val << std::endl;
  for_all(a.pred);
}


int main(int, char **)
{
  array<5> a;
  unique<array, 1> b;

  b.tab.val = 5;

  for_all(a);
  for_all(b.tab);
}
