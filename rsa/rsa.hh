#ifndef RSA_HH
# define RSA_HH

# include <iostream>
# include <ctime>
# include <cmath>
# include <gmp.h>
# include <gmpxx.h>

typedef mpz_class num;

class RSA
{
public:
  RSA(int size)
  {
    //compute two large prime numbers
    do {
      p = get_prime(size);
      q = get_prime(size);
    } while (p == q);

    //compute n
    n = p * q;

    //compute phi(n)
    totient = (p - 1) * (q - 1);

    //encryption key e
    e = 65537;

    //d = inverse of e mod phi(n)
    mpz_invert(d.get_mpz_t(), e.get_mpz_t(), totient.get_mpz_t());
    
    // Display
    std::cout << "n (" << nb_bits(n) << ") :\n" << n << std::endl;
    std::cout << "Nombre de bits de d : ";
    std::cout << nb_bits(d) << std::endl;
  }

  char * encrypt(char * str);
  char * decrypt(char * str);

  inline num get_n() const {
    return n;
  }

  inline unsigned int nb_bits(num n) {
    return mpz_sizeinbase(n.get_mpz_t(), 2);
  }
    
private:
  num get_prime(unsigned int size);

  num n,p,q, totient;
  num e,d;
};


num
RSA::get_prime(unsigned int size)
{
  static int old_t = time(0);
  gmp_randclass r(gmp_randinit_default);

  int t = time(0);
  while (t == old_t)
    t = time(0);
  old_t = t;
  
  r.seed(t);

  num p = r.get_z_bits(size);
  mpz_nextprime(p.get_mpz_t(), p.get_mpz_t());
  
  return p;
}


//encryption => m^e mod n
char * RSA::encrypt(char * str)
{
  num m,em;
  if (mpz_set_str(m.get_mpz_t(), str, 36) != 0)
    throw "Invalid string";

  mpz_powm(em.get_mpz_t(), m.get_mpz_t(), e.get_mpz_t(), n.get_mpz_t());
  
  return mpz_get_str(str, 36, em.get_mpz_t());
}


//decryption => m^d mod n
char * RSA::decrypt(char * str)
{
  num m,dm;
  if (mpz_set_str(m.get_mpz_t(), str, 36) != 0)
    throw "Invalid string";
  
  mpz_powm(dm.get_mpz_t(), m.get_mpz_t(), d.get_mpz_t(), n.get_mpz_t());
  
  return mpz_get_str(str, 36, dm.get_mpz_t());
}

#endif /* RSA_HH */
