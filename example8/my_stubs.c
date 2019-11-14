#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#undef errno
extern int errno;

char *__env[1] = { 0 };
char **environ = __env;

char tbuf[1024];
int tbuf_index = 0;
int tbuf_len = 0;

void _cpu_init_hook() {
  // enable uart transmit/receive...
  asm("mov x1,#0x9000000");
  asm("mov x0,#0x2c");
  asm("orr x1,x1,x0");
  asm("mov x0,#0x10");
  asm("str w0,[x1],#0");

  tbuf_index = 0;
  tbuf_len = 0;
}

void _exit(int rc) {
  asm("wfi");
}

int _close(int file) {
  errno = EBADF;
  return -1;
}

int _execve(const char *name, char * const argv[], char * const env[]) {
  errno = ENOMEM;
  return -1;
}

int _fork() {
  errno = EAGAIN;
  return -1;
}

int _fstat(int file, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}

int _getpid() {
  return 1;
}

int _isatty(int file) {
  return 1;
}

int _kill(int pid, int sig) {
  errno = EINVAL;
  return -1;
}

int _link(const char *old, const char *new) {
  errno = EMLINK;
  return -1;
}

off_t _lseek(int file, off_t ptr, int dir) {
  return 0;
}

int _open(const char *name, int flags, int mode) {
  errno = ENOSYS;
  return -1;
}

char _inbyte() {
  // uart (input) access here...
  asm("mov x1,#0x9000000");
  asm("mov x0,#0x0");
  asm("ldr w0,[x1],#0");
}

void _outbyte(char xc) {
  // uart (output) access here...
  asm("mov x1,#0x9000000");
  asm("str w0,[x1],#0");
}

//#define DEBUG_READ 1

int _read(int file, void *ptr, size_t len) {
#ifdef DEBUG_READ
  fputs("_read entered, len=",stdout);
  putchar('0' + (len & 0xf) );
  puts("...");
  
  fputs("  tbuf_len=",stdout);
  putchar('0' + (tbuf_len & 0xf) );
  puts("");
  fputs("  tbuf_index=",stdout);
  putchar('0' + (tbuf_index & 0xf) );
  puts("");
#endif
  
  if ( (tbuf_len <= 0) || (tbuf_index >= tbuf_len) ) {
#ifdef DEBUG_READ
    puts("tbuf is empty or have used it up...");
#endif
    tbuf_len = 0;
    int i;
    for (i = 0; i < 1024; i++) {
       char xc = 0;
       while(xc == 0) {
         xc = _inbyte();
       }
       tbuf[i] = xc;
       tbuf_len++;
       if (xc == '\n')
	 break;
    }
    tbuf_index = 0;
#ifdef DEBUG_READ
    puts("tbuf is primed...");
#endif
  }

  char *cbuf = (char *) ptr;

#ifdef DEBUG_READ
  puts("tbuf has some more chars to consume...");
#endif

  cbuf[0] = tbuf[tbuf_index++];
  cbuf[1] = '\0';

#ifdef DEBUG_READ  
  fputs("cbuf: '",stdout);
  fputs(cbuf,stdout);
  puts("'");

  puts("_read exited.");
#endif
  
  return len;
}

/*
int _read(int file, void *ptr, size_t len) { 
  puts("_read entered, len=");
  putchar('0' + (len & 0xf) );
  puts("...\n");

  //char *tbuf = (char *) ptr;
  int i, cnt = 0;
  
  for (i = 0; i < len; i++) {
    char xc = 0;
    while(xc == 0) {
      xc = _inbyte();
    }
    tbuf[i] = xc;
    cnt += 1;
    putchar(xc);
    //if (xc == '\n')
    //  break;
  }
  
  puts("_read exited.\n");
  return cnt;
}
*/

void * _sbrk(ptrdiff_t incr) {
  errno = ENOMEM;
  return (void *) -1;
}

int _stat(const char *file, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}

clock_t _times(void *buf) {
  errno = EACCES;
  return -1;
}

int _unlink(const char *name) {
  errno = ENOENT;
  return -1;
}

int _wait(int *status) {
  errno = ECHILD;
  return -1;
}

int _write(int file, const void *ptr, size_t len) {
  const char *tbuf = (const char *) ptr;
  int i;
  for (i = 0; i < len; i++)
     _outbyte(tbuf[i]);
  return len;
}

int _gettimeofday(struct timeval *p, void *z) {
  errno = ENOSYS;
  return -1;
}
