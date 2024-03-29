#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/**
 * infinite_while - creates an infinite while loop
 *
 * Return: 0
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - creates 5 zombie processes
 *
 * Return: inf while
 */
int main(void)
{
	pid_t child_pid;
	int i;

	for (i = 0; i < 5; i++)
	{
		child_pid = fork();

		if (child_pid < 0)
		{
			perror("Fork failed");
			exit(1);
		}
		else if (child_pid == 0)
			exit(0);
		else
			printf("Zombie process created, PID: %d\n", child_pid);
	}
	return (infinite_while());
}
