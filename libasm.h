/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/01 12:11:33 by ndelhota          #+#    #+#             */
/*   Updated: 2026/04/02 14:55:33 by ndelhota         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H
# include <stdlib.h>
size_t	ft_strlen(const char *s);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, const void *buf, size_t count);
char*	ft_strcpy(char *dest, const char *src);
int	    ft_strcmp(char *s1, char *s2);
char*   ft_strdup(char *s1);
int     ft_atoi_base(char *str, char *base);

typedef struct s_list
{
    void *data;
    struct s_list *next;
} t_list;

void	ft_list_push_front(t_list **begin_list, void *data);
int	    ft_list_size(t_list *begin_list);
void	ft_list_sort(t_list **begin_list, int (*cmp)());
void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
#endif
