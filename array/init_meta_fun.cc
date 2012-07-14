
#include <iostream>
#include <cmath>

/*
template <typename F, unsigned Size, unsigned i>
void
map_(int * t)
{
  
}
*/
template <unsigned Size, unsigned i>
inline
void map(int t[Size])
{
  map<Size,i-1>(t);
  t[i] = i;
}

int main(int, char **)
{
  int t[5];
  map<5,0>(t);
}
