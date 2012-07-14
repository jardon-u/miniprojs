#include <iostream>
#include <string>
#include <cstring>

//// Q3 a)
// 1/ Que fait std::cin >> s ?
// 2/ Le code est il le même si on utilise /char */ à la place de /string/ ?
//     Hint: Penser à l'allocation mémoire.
std::string read_int()
{
  std::string s;

  std::cin >> s;
  return s;
}

//// Q3 b)
// 1/ Que signifie *s et s++ ?
// 2/ Soit la chaine char * s = "abcd". Que vaut *s++ ? *++s ?
// 3/ Quelle difference entre 0 et '0' ?
bool valid_int(std::string s_)
{
  const char * s = s_.c_str();

  if (*s == '-')
    s++;
  while (*s >= '0' && *s <= '9')
    s++;
  return *s == 0;
}

//// Q3 c)
// 1/ Commenter integralement le code.
int atoi8(const char * s)
{
  int r    = 0;
  int sign = 1;
  int t    = 1;
  int n    = 0;
  int n8   = 0;

  if (*s == '-')
  {
    sign = -1;
    s++;
  }

  for (int i = std::strlen(s)-1; i >= 0; --i)
  {
    n = (s[i] - '0') * t;
    t *= 10;
  }

  t = 1;
  while (n != 0)
  {
    n8 += (n % 8) * t;
    t *= 10;
    n /= 8;
  }
  return n8 * sign;
}


//// Q4
// 1/ /fact/ réutilise sa définition. Comment s'appelle ce type d'algorythme?
// 2/ Corriger le bug de cette fonction.
long fact( long n )
{
  if (n == 0)
    return 1;
  return n * fact(n-1);
}


// 1/ Que fait std::cout ?
// 2/ Ecrire la fonction complete demandé à la Q3.
//     ie simplement appeller les fonctions a, b et c
//     depuis une fonction "chapeau".
int main()
{
  // Important. Toujours écrire une batterie de testes.
  // Q3 a)
  std::cout << "Please, enter a number: " << std::endl;
  std::cout << read_int() << std::endl;

  // Q3 b)
  std::cout << "valid_int(\"1234\") -> " << valid_int("1234") << std::endl;
  std::cout << "valid_int(\"-512\") -> " << valid_int("-512") << std::endl;
  std::cout << "valid_int(\"-4-4\") -> " << valid_int("-4-4") << std::endl;
  std::cout << "valid_int(\"test\") -> " << valid_int("test") << std::endl;

  // Q3 c)
  std::cout << "atoi8(\"8\")   -> " << atoi8("8") << std::endl;
  std::cout << "atoi8(\"20\")  -> " << atoi8("20") << std::endl;
  std::cout << "atoi8(\"-18\") -> " << atoi8("-18") << std::endl;

  // Q4
  std::cout << "fatc(0) -> " << fact(0) << std::endl;
  std::cout << "fatc(5) -> " << fact(5) << std::endl;
}
