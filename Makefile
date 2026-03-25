# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/01 12:10:17 by ndelhota          #+#    #+#              #
#    Updated: 2025/12/02 16:45:28 by ndelhota         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := libasm.a

SRCS := ft_strlen.s \
		ft_strcpy.s \

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
	rm -f maintest

re: fclean all

main: $(NAME)
	$(CC) $(CFLAGS)  main.c $(NAME) -o maintest

.PHONY: all clean fclean re main

