/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_list_size.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/02 19:15:21 by ndelhota          #+#    #+#             */
/*   Updated: 2026/04/02 19:40:37 by ndelhota         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libasm.h"
#include <stdlib.h>
#include <stdio.h>

void	free_list(t_list *list)
{
	t_list	*tmp;

	while(list)
	{
		tmp = list->next;
		free(list);
		list = tmp;
	}
}


int	main(int ac, char **argv)
{
	int 	counter;
	t_list	*list;

	list = NULL;
	if (ac == 2)
	{
		counter = atoi(argv[1]);
		if (counter < 0)
			return 1;
		while (counter)
		{
			ft_list_push_front(&list, NULL);
			--counter;
		}
		printf("size of created list:%i\n", ft_list_size(list));
		free_list(list);
	}
}
