/*
  Example program from "Linux-Magazin Kern Technik"
  "Folge 13 - Speicherpuzzle"
  by Eva-Katharina Kunst & Juergen Quade

  https://www.linux-magazin.de/ausgaben/2023/11/kern-technik/
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
//#include <fcntl.h> // commented for nolibc

#define HEAP_SIZE (256*1024*256)

int global_var = 99;
char *const_data = "program start";

int main( int argc, char **argv, char **envp )
{
  int fd, count;
  char buffer[256];
  char *heap_var;

  heap_var = (char *)sbrk( HEAP_SIZE ); // alloc heap memory
  if (heap_var == NULL) {
    perror( "sbrk" );
    exit( -2 );
  }
  heap_var = heap_var - HEAP_SIZE;

  printf("code: %p, const_data: %p, var_data: %p, heap_data: %p ",
    main, const_data, &global_var, heap_var );
  printf("stack_data: %p\n\n", &fd );

  printf("\n\n --- MAPS ---\n\n");
  fd = open( "/proc/self/maps", O_RDONLY );
  if (fd<0) {
    printf("open failed\n");
    exit( -1 );
  }
  while ((count=read( fd, buffer, sizeof(buffer)))>0) {
    if (write( 1, buffer, count )<0)
      break;
  }
  close( fd );

  printf("\n\n --- SMAPS ---\n\n");
  fd = open( "/proc/self/smaps", O_RDONLY );
  if (fd<0) {
    printf("open failed\n");
    exit( -1 );
  }
  while ((count=read( fd, buffer, sizeof(buffer)))>0) {
    if (write( 1, buffer, count )<0)
      break;
  }
  close( fd );
  printf("\n");

  return 0;
}
