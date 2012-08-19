
#include <iostream>

using namespace std;

template < typename T >
typename enable_if<is_integral<T>::value,void>::type
algo(T) {
  cout << "integral" << endl;
}
template < typename T >
typename enable_if<!is_integral<T>::value,void>::type
algo(T) {
  cout << "not integral" << endl;
}
//template <typename T, EnableIf<is_scalable<T>>...>
//T twice(T t) { return 2*t; }

int main(int, char **)
{
  string A;
  algo(A) ;
}
