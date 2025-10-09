#include <sys/syscall.h>
#include <unistd.h>

#ifndef DOCKER_ARCH
	#define DOCKER_ARCH "amd64"
#endif

const char message[] =
	"Hello from " DOCKER_ARCH "...!\n"
	"This message shows that your installation appears to be working correctly.\n";

void _start() {
	syscall(SYS_write, STDOUT_FILENO, message, sizeof(message) - 1);
	syscall(SYS_exit, 0);
}
