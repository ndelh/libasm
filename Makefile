# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ndelhota <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/01 12:10:17 by ndelhota          #+#    #+#              #
#    Updated: 2026/04/03 17:28:23 by ndelhota         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := libasm.a

SRCS := ft_strlen.s \
	ft_strcpy.s \
	ft_strcmp.s \
	ft_strdup.s \
	ft_write.s \
	ft_read.s \

SRCBONUS := ft_atoi_base_bonus.s \
	    ft_list_push_front_bonus.s \
	    ft_list_size_bonus.s \
	    ft_list_sort_bonus.s \
	    ft_list_remove_if_bonus.s

CC := cc

CFLAGS := -Wall -Werror -Wextra

OBJS := $(SRCS:.s=.o)

BONUSOBJ := $(SRCBONUS:.s=.o)

%.o : %.s
	$(NASM) $(NASMFLAGS) $< -o $@

$(NAME) : $(OBJS)
	ar rcs $(NAME) $(OBJS)

NASM := nasm

NASMFLAGS := -f elf64

all: $(NAME)

bonus: $(OBJS) $(BONUSOBJ)
	ar rcs $(NAME) $(OBJS) $(BONUSOBJ)
clean:
	rm -f $(OBJS) $(BONUSOBJ)

fclean: clean
	rm -f $(NAME)
	rm -rf *.gch

re: fclean all


.PHONY: all clean fclean re main bonus

