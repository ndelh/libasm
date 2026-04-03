#include "../../libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

void    no_right_test(void)
{
    int fd;

    printf("no right test:\n");
    fd = open("no_right_test", O_CREAT | O_RDONLY);
    ft_write(fd, "test\n", 6);
    perror("ft_write with no right");
    write(fd, "test\n", 6);
    perror("write with no right");
    write(1, "\n", 1);
    close(fd);
    unlink("no_right_test");
    close(fd);
}

void    negative_fd_test(void)
{

    printf("negative fd test:\n");
    ft_write(-1, "test\n", 6);
    perror("ft_write with -1 fd");
    write(-1, "test\n", 6);
    perror("write with -1 fd");
    ft_write(1, "\n", 1);

}

void    null_pointer_test(void)
{
    printf("test by passing a null pointer as the second argument of write\n");
    ft_write(1, NULL, 300);
    perror("ft_write with 1, NULL, 300 as parameters");
    write(1, NULL, 300);
    perror("write with 1, NULL, 300 as parameters");
}

void    standard_test(void)
{
    printf("standard test with ft_write\n");
    ft_write(1, "standard_output_test\n", strlen("standard_output_test\n"));
    ft_write(2, "error_output_test\n", strlen("error_output_test"));
}

void    write_on_file(char *s)
{
    int fd;
    printf("injecting argv[1] on a file via ft_write\n");
    fd = open("test_file", O_CREAT | O_APPEND | O_WRONLY, 777);
    if (fd < 0)
    {
        perror("open failed");
        return ;
    }
    ft_write(fd, s, ft_strlen(s));
    close(fd);
}
int main(int ac, char **argv)
{
    if (ac != 2)
    {
        negative_fd_test();
        no_right_test();
        null_pointer_test();
        standard_test();
    }
    else
           write_on_file(argv[1]);

}