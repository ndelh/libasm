#!/bin/bash

compil="cc -Wall -Werror -Wextra"
lib="../libasm.a"

$compil .c/main.c -o maintest "$lib"
$compil .c/test_atoi_base.c -o testatoi "$lib"
$compil .c/test_read.c -o test_read "$lib"
$compil .c/test_write.c -o test_write "$lib"
$compil .c/test_list_push_front.c -o test_pfront "$lib"
$compil .c/test_list_size.c -o test_lsize "$lib"
$compil .c/test_nb_sort.c -o test_lsort "$lib"
$compil .c/test_list_remove_if.c -o removeif "$lib"
