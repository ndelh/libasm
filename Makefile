# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/01 12:10:17 by ndelhota          #+#    #+#              #
#    Updated: 2026/04/02 19:38:20 by ndelhota         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := libasm.a

SRCS := ft_strlen.s \
		ft_strcpy.s \
		ft_strcmp.s \
		ft_strdup.s \
		ft_write.s \
		ft_read.s \
		ft_atoi_base.s \
		ft_list_push_front.s \
		ft_list_size.s \
		ft_list_sort.s \
		ft_list_remove_if.s

CC := cc

CFLAGS := -Wall -Werror -Wextra

OBJS := $(SRCS:.s=.o)

%.o : %.s
	$(NASM) $(NASMFLAGS) $< -o $@

$(NAME) : $(OBJS)
	ar rcs $(NAME) $(OBJS)

NASM := nasm

NASMFLAGS := -f elf64

all: $(NAME)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)
	rm -rf *.gch
	rm -f maintest

re: fclean all

main: $(NAME)
	$(CC) $(CFLAGS)  main.c $(NAME) -o maintest

.PHONY: all clean fclean re main

