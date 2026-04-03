/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/01 12:10:37 by ndelhota          #+#    #+#             */
/*   Updated: 2026/04/03 14:52:49 by ndelhota         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libasm.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>


void    copytest(char *s, int i)
{
    char *c;
    char *d;

    c = malloc(100000);
    d = malloc(100000);
    if (!c || !d) 
    {
        free(c);
        free(d);
        printf("malloc error\n");
        exit(1);
    }
    printf("strcpy result: %s\n", strcpy(c, s));
    printf("ft_strcpy result: %s\n", ft_strcpy(d, s));
    if (i >= 5)
        printf("displaced string for ft_strcpy, displacing by 5: %s\n", ft_strcpy(c, s + 5));
    free(c);
    free(d);
}

void    duptest(char *s)
{
        char *c;
        char *d;

        c = strdup(s);
        d = ft_strdup(s);
        printf("strdup: %s\n", c);
        printf ("ft_strdup: %s\n", d);
        if (ft_strlen(s) >= 5)
        {
            free(c);
            c = ft_strdup(s + 5);
            printf("displaced by 5 strdup: %s\n", c);
        }
        free(c);
        free(d);        
}

void    comptest(char *s1, char *s2)
{
    printf ("result of strcmp: %i\n", strcmp(s1, s2));
    printf("result of ft_strcmp: %i\n", ft_strcmp(s1, s2));
    if (strlen(s1) >= 5 && strlen(s2) >= 5)
            printf("displaced result of ft_strncmp with both string displaced by 5: %i\n", ft_strcmp(s1 +5 , s2 + 5));
}

int		main(int ac, char **argv)
{
    if (ac == 2)
    {
        printf("strlen result: %zu\n", strlen(argv[1]));
        printf("ft_strlen result: %zu\n", ft_strlen(argv[1]));
        if (ft_strlen(argv[1]) > 3)
            printf("ft_strlen displaced by 3: %zu\n", ft_strlen(argv[1] + 3));
        copytest(argv[1], strlen(argv[1]));
        duptest(argv[1]);
    }
    if (ac == 3)
        comptest(argv[1], argv[2]);
    // if (ac == 2)
    // {
    //     char *c = malloc(1000000); 
    //     c = ft_strcpy(c, argv[1]);
    //     printf("%s\n", c);
    //     free(c);
    // }
}
