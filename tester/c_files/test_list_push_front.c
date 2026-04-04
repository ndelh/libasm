/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_list_push_front.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/01 19:22:30 by ndelhota          #+#    #+#             */
/*   Updated: 2026/04/02 15:25:35 by ndelhota         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libasm.h"
#include <stdio.h>
#include <string.h>
void	print_list(t_list* test)
{
		printf("head of list pointer: %p\n", test);
		while (test)
		{
			printf("data content: %s\n", (char *)test->data);
			test = test->next;
		}
		printf("\n");
}

void	free_list(t_list *test)
{
		t_list *tmp;
		while (test)
		{
			free(test->data);
			tmp = test->next;
			free(test);
			test = tmp;
		}
}

void	ft_add(char *a, char *b, char *c, char *d)
{
	t_list *test;
	
	test = NULL;
	print_list(test);
	ft_list_push_front(&test, a);
	print_list(test);
	ft_list_push_front(&test, b);
	print_list(test);
	ft_list_push_front(&test, c);
	print_list(test);
	ft_list_push_front(&test, d);
	print_list(test);
	free_list(test);
}

int	main(void)
{
	char *a;
	char *b;
	char *c;
	char *d;

	d = NULL;
	a = strdup("premiere node");
	printf("a value: %p\n", a);
	b = strdup("deuxieme node");
	printf("b value: %p\n", b);
	c = strdup("troisieme node");
	printf("c value: %p\n", c);
	printf("d value: %p\n", d);
	ft_add(a, b , c,d);
}
