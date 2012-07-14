/*
 * f is not defined at call time
 * without any warning on g++ 4.3.1
 * results in segfault
 */

#include <string>
using namespace std;

class A
{
public:
  A( const string& s ) : s(s) { }
  string f() { return "hello, world"; }
  const string& s;
};

class B : public A
{
public:
  B() : A( s = f() ) {}
private:
  string s;
};

int main()
{
  B b;
}
