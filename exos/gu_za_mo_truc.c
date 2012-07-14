#include <stdio.h>
#include <math.h>

void gu_za_mo_truc(int n)
{
  char * tab[] = {"guu", "zaa", "moo", "truc"};
  int i = 0;
  //  int b = 0;
  int nn = n;

  for (i = 0; i < pow(4.,nn); i++, printf("\n"))
    for (n = nn; n > 0; n--)
      printf("%s ", tab[(int)(i / pow(4, n - 1)) % 4]);
}

int main(void)
{
  gu_za_mo_truc(7);
  return 0;
}
