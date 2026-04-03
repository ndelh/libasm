/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_nb_sort.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/02 18:41:05 by ndelhota          #+#    #+#             */
/*   Updated: 2026/04/03 10:38:11 by ndelhota         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libasm.h"
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
void	print_list(t_list *list)
{
	int	i;

	i = 0;
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

int     gen_rand()
{
        int fd;
        char buffer[1];

        fd = open("/dev/urandom", O_RDONLY);
        read(fd, buffer, 1);
        close(fd);
        return (buffer[0] % 100);
}

t_list *gen_list(void)
{
	int 	*buffer;
	int c;
    t_list  *to_ret;
	c = 10;
	to_ret = NULL;
	while (c)
	{
		buffer = malloc(sizeof(int));
		*buffer = gen_rand();
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

void	check_sort(t_list *list)
{
	int flag;
	int i;

	i = 0;
	while (list && list->next)
	{
		flag = comp(list->data, list->next->data);
		if (flag > 0)
			printf("error detected between node %i and node %i\n", i , i + 1);
		++i;
		list = list->next;
	}

}

void	null_test(t_list *good)
{
	t_list *list;

	list = NULL;
	printf("launching test with null params, checking for segfault\n");
	ft_list_sort(NULL, comp);
	ft_list_sort(&list, comp);
	ft_list_sort(&good , NULL);
	printf("survived without segfaulting\n");
}

int	main(void)
{
	t_list *list;

	list = gen_list();
	print_list(list);
	null_test(list);
	ft_list_sort(&list, comp);
    	printf("after sorting process:\n");
	print_list(list);
	check_sort(list);
	free_list(list);
}
