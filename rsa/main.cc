#include <iostream>
#include <cstdio>
#include "rsa.hh"


void usage(char ** argv)
{
  std::cout << "usage :" << argv[0] << " msg"<< std::endl;
  exit(1);
}


int main(int argc, char** argv)
{
  if (argc != 2)
    usage(argv);

  try {
  RSA rsa(512);
 
  char * ori = (char *) malloc(1024);
  char * mod = (char *) malloc(1024);
    
  std::strcpy(ori, argv[1]);
  std::strcpy(mod, ori);
        
  rsa.encrypt(mod);
  std::cout << "Message chiffré   : \n" <<mod << std::endl;
    
  rsa.decrypt(mod);
  std::cout << "Message déchiffré : \n" <<mod << std::endl;
  } catch (char* str) {
    std::cout << str << std::endl;
  }
}

