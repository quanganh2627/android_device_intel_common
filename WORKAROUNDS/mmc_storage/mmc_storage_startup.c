
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include <getopt.h>     /* getopt_long() */

#include <fcntl.h>      /* low-level i/o */
#include <unistd.h>
#include <errno.h>
#include <malloc.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <sys/statfs.h>

int
main (int argc, char **argv)
{
  struct statfs sf;
  struct timeval start, end;
  long timeuse;

  printf("start checking whether the sdcard folder is mounted\n");
  while (access("/mnt/sdcard/LOST.DIR", 0) != 0) sleep(1);
  gettimeofday( &start, NULL );
  statfs("/mnt/sdcard", &sf);
  gettimeofday( &end, NULL );
  timeuse = 1000000 * ( end.tv_sec - start.tv_sec ) + end.tv_usec - start.tv_usec;
  timeuse /= 1000000;
  printf("!!!!time %d\n", timeuse);
  printf("\nstatfs:\n");
  printf("f_type: %10d\n", sf.f_type);
  printf("f_bsize: %10d\n", sf.f_bsize);
  printf("f_blocks: %10d\n", sf.f_blocks);
  printf("f_bfree: %10d\n", sf.f_bfree);
  printf("f_bavail: %10d\n", sf.f_bavail);
  printf("f_files: %10d\n", sf.f_files);
  printf("f_ffree: %10d\n", sf.f_ffree);

  return 0;
}
