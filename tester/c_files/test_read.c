#include "../../libasm.h"
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>


void    invalid_fd(void)
{
    char *c;

    c = malloc(1);
    printf("invalid fd test\n");
    ft_read(-1, c, 1000);
    perror("ft_read invalid fd");
    read(-1, c, 1000);
    perror("read invalid fd");
    free(c);
    write(1, "\n", 1);
}

void    null_arg(void)
{
    int fd;

    printf("Null second arg test\n");
    fd = open("/dev/urandom", O_RDONLY);
    ft_read(fd, NULL, 1);
    perror("ft_read with null pointer as second arg");
    read(fd, NULL, 1);
    perror("read with null pointer as second arg");
    write(1, "\n", 1);
    close(fd);
}

void    is_dir(void)
{
    int fd;
    char *c;

    c = malloc(2);
    fd = open ("../tester", O_RDONLY);
    printf("directory read test\n");
    ft_read(fd, c, 1);
    perror("ft_read trying to read a directory");
    read(fd, c, 1);
    perror("read trying to read a directory");
    close(fd);
    free(c);
}

void    read_try(char *s)
{
        int     fd;
        int     cursor;
        char    *c;

        c = malloc(1001);
        fd = open(s, O_RDONLY);
        for (int i = 1; i < 1001; i *= 10)
        {
            printf("trying to read %i char from buffer%s : ", i, s);
            cursor = ft_read(fd, c, i);
            c[cursor] = 0;
            printf("%s\n", c);
        }
        free(c);

}

void    stdin_readloop(void)
{
    char    *c;
    int     i;
    int     cursor;

    c = malloc(257);
    i = 0;
    printf("now reading three times from stdin with a max buffer size of 256\n");
    while (i < 3)
    {
        cursor = ft_read(0, c, 256);
        c[cursor] = 0;
        printf("line readed is: %s", c);
        ++i;
    }
    free(c);
}

int main(int ac, char **argv)
{
        if (ac == 1)
        {
            invalid_fd();
            null_arg();
            is_dir();
        }
        else if (ac == 2)
            read_try(argv[1]);
        else
            stdin_readloop();
}