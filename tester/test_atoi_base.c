/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_atoi_base.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/01 16:36:55 by ndelhota          #+#    #+#             */
/*   Updated: 2026/04/01 17:42:41 by ndelhota         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../libasm.h"
#include <stdio.h>

int	main(int ac, char **argv)
{
	if (ac != 3)
		return 1;
	printf("result of atoi base for this nb: %s with this base: %s:\n%i"
		, argv[1], argv[2], ft_atoi_base(argv[1], argv[2]));	
}
