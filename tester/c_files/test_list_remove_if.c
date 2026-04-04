#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include "../../libasm.h"

void	print_list(t_list *list)
{
	int	i;

	i = 0;
	printf("%p\n", list);
	while (list)
	{
		printf("For node number: %i, data value is: %i\n", i, *(int *)list->data);
		list = list->next;
		++i;
	}
}

void	free_list(t_list *list)
{
	t_list	*tmp;

	while (list)
	{
		tmp = list->next;
		free(list->data);
		free(list);
		list = tmp;
	}
}

int     gen_rand(int c)
{
        int fd;
        char buffer[1];

        fd = open("/dev/urandom", O_RDONLY);
        read(fd, buffer, 1);
        close(fd);
        return (buffer[0] % c);
}

t_list *gen_list(int d)
{
	int 	*buffer;
	int c;
    t_list  *to_ret;
	c = 10;
	to_ret = NULL;
	while (c)
	{
		buffer = malloc(sizeof(int));
		*buffer = gen_rand(d);
		ft_list_push_front(&to_ret, buffer);
		--c;
	}
	return (to_ret);
}

int 	comp(void *a, void *b)
{
	int	c;
	char 	*d;

	d = strdup("are you aligned son?\n");
	c = *(int *)a - *(int *)b;
	free(d);
	return (c);
}

void	remove_from_list(void *data)
{
	char *randommalloc;
	
	randommalloc = malloc(337);
	free(randommalloc);
	free(data);
	
}


void remove_all(void)
{
    int i;
    t_list *list;
    int *c;

    list = NULL;
    i = 10;
    while (i)
    {
        --i;
        c = malloc(sizeof(int));
        *c = 2;
        ft_list_push_front(&list, c);
    }
    print_list(list);
    printf("removing all 2 instance\n");
    c = malloc(sizeof(int));
    *c = 2;
    ft_list_remove_if(&list, c, comp, remove_from_list);
    print_list(list);
    free_list(list);
    free(c);
}

void	no_remove_test(void)
{
	t_list *list;
	int *c;

	printf("\n noremove test\n");
	c = malloc(sizeof(int));
	*c = 4;
	list = gen_list(3);
	print_list(list);
    	ft_list_remove_if(&list, c, comp, remove_from_list);
	print_list(list);
	free_list(list);
	free(c);
}

void	remove_test(void)
{
	t_list *list;
	int *c;

	printf("\n remove test, removing all 3\n");
	c = malloc(sizeof(int));
	*c = 3;
	list = gen_list(4);
	print_list(list);
	ft_list_remove_if(&list, c, comp, remove_from_list);
	print_list(list);
	free_list(list);
	free(c);
}

void	remove_all_except_head(void)
{

    	int i;
    	t_list *list;
    	int *c;

	printf("\nremoving all except head\n");
    	list = NULL;
    	i = 10;
    	while (i)
    	{
        	--i;
        	c = malloc(sizeof(int));
        	*c = 2;
        	ft_list_push_front(&list, c);
    	}
	c = malloc(sizeof(int));
	*c = 100;
       	ft_list_push_front(&list, c);
    	print_list(list);
    	printf("removing all 2 instance\n");
    	c = malloc(sizeof(int));
    	*c = 2;
    	ft_list_remove_if(&list, c, comp, remove_from_list);
    	print_list(list);
    	free_list(list);
    	free(c);
}

int	main(void)
{
    	remove_all();
    	no_remove_test();
    	remove_test();
	remove_all_except_head();
}
