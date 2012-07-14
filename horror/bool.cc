/*
  bool support operator++ but not operator--
 */

#include <iostream>

int main(int argc, char ** argv)
{
  bool a = false;
  a++; // compiles.
  a--; // do not.
}
